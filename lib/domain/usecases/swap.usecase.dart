/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
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
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String poolGenesisAddress,
    DexToken tokenToSwap,
    double tokenToSwapAmount,
    double slippage, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionSwap,
  }) async {
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);

    archethic.Transaction? transactionSwap;
    if (recoveryTransactionSwap != null) {
      transactionSwap = recoveryTransactionSwap;
    }

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
        ..setFailure(aedappfm.Failure.other(cause: e.toString()))
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
        DexNotification(
          actionType: DexActionType.swap,
          txAddress: poolGenesisAddress,
        ),
      );

      final amount = await PeriodicFuture.periodic<double>(
        () => getAmountFromTxInput(
          poolGenesisAddress,
          tokenToSwap.address,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (amount) {
          return amount > 0;
        },
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw const aedappfm.Failure.timeout(),
      );

      notificationService.succeed(
        operationId,
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
          aedappfm.Failure.other(
            cause: e.toString(),
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

  // TODO(redDwarf03): Wait for https://github.com/archethic-foundation/archethic-node/issues/1418
  Future<double> estimateFees(
    WidgetRef ref,
    String poolGenesisAddress,
    DexToken tokenToSwap,
    double tokenToSwapAmount,
    double slippage,
  ) async {
    final archethicContract = ArchethicContract();
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

      transactionSwapMap.map(
        success: (success) async {
          transactionSwap = success;
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
    return 0.0;
  }
}

class PeriodicFuture {
  /// Executes [action] until verification succeeds.
  /// It waits [sleepDuration] between each run.
  static Future<T> periodic<T>(
    FutureOr<T> Function() action, {
    required Duration sleepDuration,
    required bool Function(T value) until,
  }) async {
    late T result;
    await Future.doWhile(() async {
      result = await action();
      return !until(result);
    });
    return result;
  }
}
