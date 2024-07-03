/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'WithdrawFarmCase';

class WithdrawFarmCase with aedappfm.TransactionMixin {
  Future<({double finalAmountReward, double finalAmountWithdraw})> run(
    WidgetRef ref,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    DexToken rewardToken, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionWithdraw,
  }) async {
    //final apiService = aedappfm.sl.get<archethic.ApiService>();
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final farmWithdrawNotifier =
        ref.read(FarmWithdrawFormProvider.farmWithdrawForm.notifier);
    final farmWithdraw = ref.read(FarmWithdrawFormProvider.farmWithdrawForm);

    archethic.Transaction? transactionWithdraw;
    if (recoveryTransactionWithdraw != null) {
      transactionWithdraw = recoveryTransactionWithdraw;
    }
    farmWithdrawNotifier
      ..setFinalAmountReward(null)
      ..setFinalAmountWithdraw(null);

    if (recoveryStep <= 1) {
      farmWithdrawNotifier.setCurrentStep(1);
      try {
        final transactionWithdrawMap =
            await archethicContract.getFarmWithdrawTx(
          farmGenesisAddress,
          amount,
        );

        transactionWithdrawMap.map(
          success: (success) {
            transactionWithdraw = success;
            farmWithdrawNotifier.setTransactionWithdrawFarm(
              transactionWithdraw!,
            );
          },
          failure: (failure) {
            farmWithdrawNotifier
              ..setFailure(failure)
              ..setProcessInProgress(false);
            throw failure;
          },
        );
      } catch (e) {
        throw aedappfm.Failure.fromError(e);
      }
    }

    if (recoveryStep <= 2) {
      farmWithdrawNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmWithdrawNotifier.setWalletConfirmation(true);

      transactionWithdraw = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionWithdraw!],
      ))
          .first;

      farmWithdrawNotifier
        ..setWalletConfirmation(false)
        ..setTransactionWithdrawFarm(
          transactionWithdraw!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmWithdrawNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmWithdrawNotifier
          .setFailure(aedappfm.Failure.other(cause: e.toString()));

      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionWithdraw!,
        ],
      );

      farmWithdrawNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmWithdrawOk(true);

      notificationService.start(
        operationId,
        DexNotification.withdrawFarm(
          txAddress: transactionWithdraw!.address!.address,
          rewardToken: rewardToken,
          isFarmClose: farmWithdraw.isFarmClose,
        ),
      );

      final amounts = await aedappfm.PeriodicFuture.periodic<List<double>>(
        () => Future.wait([
          getAmountFromTxInput(
            transactionWithdraw!.address!.address!,
            rewardToken.address,
          ),
          getAmountFromTxInput(
            transactionWithdraw!.address!.address!,
            lpTokenAddress,
          ),
        ]),
        sleepDuration: const Duration(seconds: 3),
        until: (amounts) {
          final amountWithdraw = amounts[1];
          return amountWithdraw > 0;
        },
      ).timeout(
        const Duration(minutes: 1),
        onTimeout: () => throw const aedappfm.Timeout(),
      );

      final amountReward = amounts[0];
      final amountWithdraw = amounts[1];

      notificationService.succeed(
        operationId,
        DexNotification.withdrawFarm(
          txAddress: transactionWithdraw!.address!.address,
          amountReward: amountReward,
          amountWithdraw: amountWithdraw,
          rewardToken: rewardToken,
          isFarmClose: farmWithdraw.isFarmClose,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet());

      return (
        finalAmountReward: amountReward,
        finalAmountWithdraw: amountWithdraw
      );
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionWithdrawFarm sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmWithdrawNotifier
        ..setFailure(
          aedappfm.Failure.other(
            cause: e.toString(),
          ),
        )
        ..setCurrentStep(3);

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
        return AppLocalizations.of(context)!.withdrawProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.withdrawProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.withdrawProcessStep3;
      default:
        return AppLocalizations.of(context)!.withdrawProcessStep0;
    }
  }
}
