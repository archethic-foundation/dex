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
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:uuid/uuid.dart';

const logName = 'LevelUpFarmLockCase';

class LevelUpFarmLockCase with aedappfm.TransactionMixin {
  LevelUpFarmLockCase({
    required this.apiService,
    required this.notificationService,
    required this.verifiedTokensRepository,
    required this.dappClient,
  });

  final awc.ArchethicDAppClient dappClient;
  final archethic.ApiService apiService;
  final ns.TaskNotificationService<DexNotification, aedappfm.Failure>
      notificationService;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;

  Future<double> run(
    AppLocalizations localizations,
    FarmLockLevelUpFormNotifier farmLevelUpNotifier,
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
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );

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
      final currentNameAccount = await getCurrentAccount(dappClient);
      farmLevelUpNotifier.setWalletConfirmation(true);

      transactionLevelUp = (await signTx(
        dappClient,
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionLevelUp!],
        description: {
          'en': localizations.levelUpFarmLockSignTxDesc_en,
          'fr': localizations.levelUpFarmLockSignTxDesc_fr,
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
          apiService,
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

      unawaited(refreshCurrentAccountInfoWallet(dappClient));

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
    AppLocalizations localizations,
    int step,
  ) {
    switch (step) {
      case 1:
        return localizations.levelUpFarmLockProcessStep1;
      case 2:
        return localizations.levelUpFarmLockProcessStep2;
      case 3:
        return localizations.levelUpFarmLockProcessStep3;
      default:
        return localizations.levelUpFarmLockProcessStep0;
    }
  }
}
