/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'LevelUpFarmLockCase';

class LevelUpFarmLockCase with aedappfm.TransactionMixin {
  Future<double> run(
    WidgetRef ref,
    BuildContext context,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    String depositId,
    String farmAddress,
    bool isUCO,
    FarmLockDepositDurationType durationType,
    String level, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionLevelUp,
  }) async {
    final apiService = aedappfm.sl.get<archethic.ApiService>();
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final farmLevelUpNotifier =
        ref.read(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier);

    archethic.Transaction? transactionLevelUp;
    if (recoveryTransactionLevelUp != null) {
      transactionLevelUp = recoveryTransactionLevelUp;
    }

    farmLevelUpNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      farmLevelUpNotifier.setCurrentStep(1);
      try {
        final transactionDepositMap =
            await archethicContract.getFarmLockRelockTx(
          farmGenesisAddress,
          lpTokenAddress,
          amount,
          depositId,
          durationType,
          level,
        );

        transactionDepositMap.map(
          success: (success) {
            transactionLevelUp = success;
            farmLevelUpNotifier.setTransactionFarmLockLevelUp(
              transactionLevelUp!,
            );
          },
          failure: (failure) {
            farmLevelUpNotifier
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
      farmLevelUpNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmLevelUpNotifier.setWalletConfirmation(true);

      transactionLevelUp = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionLevelUp!],
        description: {
          'en': context.mounted
              ? AppLocalizations.of(context)!
                  .aeswap_levelUpFarmLockSignTxDesc_en
              : '',
          'fr': context.mounted
              ? AppLocalizations.of(context)!
                  .aeswap_levelUpFarmLockSignTxDesc_fr
              : '',
        },
      ))
          .first;

      farmLevelUpNotifier
        ..setWalletConfirmation(false)
        ..setTransactionFarmLockLevelUp(
          transactionLevelUp!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmLevelUpNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmLevelUpNotifier.setFailure(
        aedappfm.Failure.other(
          cause: e.toString().replaceAll('Exception: ', '').capitalize(),
        ),
      );
      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionLevelUp!,
        ],
        apiService,
      );

      farmLevelUpNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmLockLevelUpOk(true);

      notificationService.start(
        operationId,
        DexNotification.levelUpFarmLock(
          txAddress: transactionLevelUp!.address!.address,
          farmAddress: farmAddress,
          isUCO: isUCO,
        ),
      );

      await aedappfm.PeriodicFuture.periodic<bool>(
        () => isSCCallExecuted(
          farmAddress,
          transactionLevelUp!.address!.address!,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (depositOk) => depositOk == true,
        timeout: const Duration(minutes: 1),
      );

      notificationService.succeed(
        operationId,
        DexNotification.levelUpFarmLock(
          txAddress: transactionLevelUp!.address!.address,
          amount: amount,
          farmAddress: farmAddress,
          isUCO: isUCO,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet());

      return amount;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionFarmLevelUp sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmLevelUpNotifier
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
        return AppLocalizations.of(context)!.aeswap_levelUpFarmLockProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.aeswap_levelUpFarmLockProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.aeswap_levelUpFarmLockProcessStep3;
      default:
        return AppLocalizations.of(context)!.aeswap_levelUpFarmLockProcessStep0;
    }
  }
}
