/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'SwapCase';

class SwapCase with aedappfm.TransactionMixin {
  Future<double> run(
    WidgetRef ref,
    BuildContext context,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String poolGenesisAddress,
    DexToken tokenToSwap,
    DexToken tokenSwapped,
    double tokenToSwapAmount,
    double slippage, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionSwap,
  }) async {
    //final apiService = aedappfm.sl.get<archethic.ApiService>();
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);

    archethic.Transaction? transactionSwap;
    if (recoveryTransactionSwap != null) {
      transactionSwap = recoveryTransactionSwap;
    }

    swapNotifier.setFinalAmount(null);

    var outputAmount = 0.0;
    if (recoveryStep <= 1) {
      swapNotifier.setCurrentStep(1);

      try {
        final outputAmountMap = await archethicContract.getOutputAmount(
          tokenToSwap,
          tokenToSwapAmount,
          poolGenesisAddress,
        );

        outputAmountMap.map(
          success: (success) {
            outputAmount = success;

            if (outputAmount <= 0) {
              throw const aedappfm.Failure.other(
                cause: 'Error outputAmount',
              );
            }
          },
          failure: (failure) {
            //FIXME : il faudrait faire ça dans l'autre sens :
            // - la methode run() retourne un Stream<SwapState>.
            // - le notifierProvider écoute ce stream et se met a jour en conséquence
            swapNotifier
              ..setFailure(failure)
              ..setCurrentStep(4)
              ..setProcessInProgress(false);
            throw failure;
          },
        );
      } catch (e) {
        throw aedappfm.Failure.fromError(e);
      }
    }

    if (recoveryStep <= 1) {
      swapNotifier.setCurrentStep(2);
      try {
        final transactionSwapMap = await archethicContract.getSwapTx(
          tokenToSwap,
          tokenToSwapAmount,
          poolGenesisAddress,
          slippage,
          outputAmount,
        );

        transactionSwapMap.map(
          success: (success) {
            transactionSwap = success;
            swapNotifier.setRecoveryTransactionSwap(
              transactionSwap,
            );
          },
          failure: (failure) {
            swapNotifier
              ..setFailure(failure)
              ..setCurrentStep(4)
              ..setProcessInProgress(false);
            throw failure;
          },
        );
      } catch (e) {
        throw aedappfm.Failure.fromError(e);
      }
    }

    if (recoveryStep <= 3) {
      swapNotifier.setCurrentStep(3);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      swapNotifier.setWalletConfirmation(true);

      transactionSwap = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionSwap!],
        description: {
          'en': context.mounted
              ? AppLocalizations.of(context)!.swapSignTxDesc_en
              : '',
          'fr': context.mounted
              ? AppLocalizations.of(context)!.swapSignTxDesc_fr
              : '',
        },
      ))
          .first;

      swapNotifier
        ..setWalletConfirmation(false)
        ..setRecoveryTransactionSwap(
          transactionSwap,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        swapNotifier
          ..setFailure(e)
          ..setCurrentStep(4);
        throw aedappfm.Failure.fromError(e);
      }
      swapNotifier
        ..setFailure(
          aedappfm.Failure.other(
            cause: e.toString().replaceAll('Exception: ', '').capitalize(),
          ),
        )
        ..setCurrentStep(4);
      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionSwap!,
        ],
      );

      swapNotifier
        ..setCurrentStep(4)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setSwapOk(true);

      notificationService.start(
        operationId,
        DexNotification.swap(
          txAddress: transactionSwap!.address!.address,
          tokenSwapped: tokenSwapped,
        ),
      );

      final amount = await aedappfm.PeriodicFuture.periodic<double>(
        () => getAmountFromTxInput(
          transactionSwap!.address!.address!,
          tokenSwapped.address,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (amount) => amount > 0,
        timeout: const Duration(minutes: 1),
      );

      notificationService.succeed(
        operationId,
        DexNotification.swap(
          txAddress: transactionSwap!.address!.address,
          tokenSwapped: tokenSwapped,
          amountSwapped: amount,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet());

      return amount;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionSwap sendTx failed $e ($transactionSwap)',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      swapNotifier
        ..setFailure(
          e is aedappfm.Timeout
              ? e
              : aedappfm.Failure.other(
                  cause:
                      e.toString().replaceAll('Exception: ', '').capitalize(),
                ),
        )
        ..setCurrentStep(4);

      notificationService.failed(
        operationId,
        aedappfm.Failure.fromError(e),
      );
      throw aedappfm.Failure.fromError(e);
    }
  }

  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.swapProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.swapProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.swapProcessStep3;
      case 4:
        return AppLocalizations.of(context)!.swapProcessStep4;
      default:
        return AppLocalizations.of(context)!.swapProcessStep0;
    }
  }

  Future<double> estimateFees(
    String poolGenesisAddress,
    DexToken tokenToSwap,
    double tokenToSwapAmount,
    double slippage,
  ) async {
    final archethicContract = ArchethicContract();
    //final apiService = aedappfm.sl.get<archethic.ApiService>();
    archethic.Transaction? transactionSwap;
    var outputAmount = 0.0;

    try {
      final outputAmountMap = await archethicContract.getOutputAmount(
        tokenToSwap,
        tokenToSwapAmount,
        poolGenesisAddress,
      );

      outputAmountMap.map(
        success: (success) {
          outputAmount = success;

          if (outputAmount <= 0) {
            return 0.0;
          }
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }

    try {
      final transactionSwapMap = await archethicContract.getSwapTx(
        tokenToSwap,
        tokenToSwapAmount,
        poolGenesisAddress,
        slippage,
        outputAmount,
      );

      return transactionSwapMap.map(
        success: (success) async {
          transactionSwap = success;
          // Add fake signature and address to allow estimation by node
          transactionSwap = transactionSwap!.copyWith(
            address: const archethic.Address(
              address:
                  '00000000000000000000000000000000000000000000000000000000000000000000',
            ),
            previousPublicKey:
                '00000000000000000000000000000000000000000000000000000000000000000000',
          );
          final fees = await calculateFees(transactionSwap!, slippage: 1.1);
          return fees;
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }
  }
}
