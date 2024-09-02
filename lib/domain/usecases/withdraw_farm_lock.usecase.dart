/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
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

const logName = 'WithdrawFarmLockCase';

class WithdrawFarmLockCase with aedappfm.TransactionMixin {
  Future<({double finalAmountReward, double finalAmountWithdraw})> run(
    WidgetRef ref,
    BuildContext context,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    String depositId,
    DexToken rewardToken, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionWithdraw,
  }) async {
    //final apiService = aedappfm.sl.get<archethic.ApiService>();
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final farmLockWithdrawNotifier =
        ref.read(FarmLockWithdrawFormProvider.farmLockWithdrawForm.notifier);
    final farmWithdraw = ref.read(FarmWithdrawFormProvider.farmWithdrawForm);

    archethic.Transaction? transactionWithdraw;
    if (recoveryTransactionWithdraw != null) {
      transactionWithdraw = recoveryTransactionWithdraw;
    }
    farmLockWithdrawNotifier
      ..setFinalAmountReward(null)
      ..setFinalAmountWithdraw(null);

    if (recoveryStep <= 1) {
      farmLockWithdrawNotifier.setCurrentStep(1);
      try {
        final transactionWithdrawMap =
            await archethicContract.getFarmLockWithdrawTx(
          farmGenesisAddress,
          amount,
          depositId,
        );

        transactionWithdrawMap.map(
          success: (success) {
            transactionWithdraw = success;
            farmLockWithdrawNotifier.setTransactionWithdrawFarmLock(
              transactionWithdraw!,
            );
          },
          failure: (failure) {
            farmLockWithdrawNotifier
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
      farmLockWithdrawNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmLockWithdrawNotifier.setWalletConfirmation(true);

      transactionWithdraw = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionWithdraw!],
        description: {
          'en': context.mounted
              ? AppLocalizations.of(context)!
                  .aeswap_withdrawFarmLockSignTxDesc_en
              : '',
          'fr': context.mounted
              ? AppLocalizations.of(context)!
                  .aeswap_withdrawFarmLockSignTxDesc_fr
              : '',
        },
      ))
          .first;

      farmLockWithdrawNotifier
        ..setWalletConfirmation(false)
        ..setTransactionWithdrawFarmLock(
          transactionWithdraw!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmLockWithdrawNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmLockWithdrawNotifier.setFailure(
        aedappfm.Failure.other(
          cause: e.toString().replaceAll('Exception: ', '').capitalize(),
        ),
      );

      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionWithdraw!,
        ],
      );

      farmLockWithdrawNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmLockWithdrawOk(true);

      notificationService.start(
        operationId,
        DexNotification.withdrawFarmLock(
          txAddress: transactionWithdraw!.address!.address,
          rewardToken: rewardToken,
          isFarmClose: farmWithdraw.isFarmClose,
        ),
      );

      await aedappfm.PeriodicFuture.periodic<bool>(
        () => isSCCallExecuted(
          farmGenesisAddress,
          transactionWithdraw!.address!.address!,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (depositOk) => depositOk == true,
        timeout: const Duration(minutes: 1),
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
        timeout: const Duration(minutes: 1),
      );

      final amountReward = amounts[0];
      final amountWithdraw = amounts[1];

      notificationService.succeed(
        operationId,
        DexNotification.withdrawFarmLock(
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

      farmLockWithdrawNotifier
        ..setFailure(
          e is aedappfm.Timeout
              ? e
              : aedappfm.Failure.other(
                  cause:
                      e.toString().replaceAll('Exception: ', '').capitalize(),
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
        return AppLocalizations.of(context)!
            .aeswap_withdrawFarmLockProcessStep1;
      case 2:
        return AppLocalizations.of(context)!
            .aeswap_withdrawFarmLockProcessStep2;
      case 3:
        return AppLocalizations.of(context)!
            .aeswap_withdrawFarmLockProcessStep3;
      default:
        return AppLocalizations.of(context)!
            .aeswap_withdrawFarmLockProcessStep0;
    }
  }
}
