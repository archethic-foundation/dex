/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
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

const logName = 'DepositFarmLockCase';

class DepositFarmLockCase with aedappfm.TransactionMixin {
  DepositFarmLockCase({
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
    FarmLockDepositFormNotifier farmLockDepositNotifier,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    String farmAddress,
    bool isUCO,
    FarmLockDepositDurationType durationType,
    String level, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionDeposit,
  }) async {
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );

    archethic.Transaction? transactionDeposit;
    if (recoveryTransactionDeposit != null) {
      transactionDeposit = recoveryTransactionDeposit;
    }

    farmLockDepositNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      farmLockDepositNotifier.setCurrentStep(1);
      try {
        final transactionDepositMap =
            await archethicContract.getFarmLockDepositTx(
          farmGenesisAddress,
          lpTokenAddress,
          amount,
          durationType,
          level,
        );

        transactionDepositMap.map(
          success: (success) {
            transactionDeposit = success;
            farmLockDepositNotifier.setTransactionFarmLockDeposit(
              transactionDeposit!,
            );
          },
          failure: (failure) {
            farmLockDepositNotifier
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
      farmLockDepositNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount(dappClient);
      farmLockDepositNotifier.setWalletConfirmation(true);

      transactionDeposit = (await signTx(
        dappClient,
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionDeposit!],
        description: {
          'en': localizations.depositFarmLockSignTxDesc_en,
          'fr': localizations.depositFarmLockSignTxDesc_fr,
        },
      ))
          .first;

      farmLockDepositNotifier
        ..setWalletConfirmation(false)
        ..setTransactionFarmLockDeposit(
          transactionDeposit!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmLockDepositNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmLockDepositNotifier.setFailure(
        aedappfm.Failure.other(
          cause: e.toString().replaceAll('Exception: ', '').capitalize(),
        ),
      );
      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionDeposit!,
        ],
        apiService,
      );

      farmLockDepositNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmLockDepositOk(true);

      notificationService.start(
        operationId,
        DexNotification.depositFarmLock(
          txAddress: transactionDeposit!.address!.address,
          farmAddress: farmAddress,
          isUCO: isUCO,
        ),
      );

      await aedappfm.PeriodicFuture.periodic<bool>(
        () => isSCCallExecuted(
          apiService,
          farmAddress,
          transactionDeposit!.address!.address!,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (depositOk) => depositOk == true,
        timeout: const Duration(minutes: 1),
      );

      notificationService.succeed(
        operationId,
        DexNotification.depositFarmLock(
          txAddress: transactionDeposit!.address!.address,
          amount: amount,
          farmAddress: farmAddress,
          isUCO: isUCO,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet(dappClient));

      return amount;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionFarmDeposit sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmLockDepositNotifier
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
        return localizations.depositFarmLockProcessStep1;
      case 2:
        return localizations.depositFarmLockProcessStep2;
      case 3:
        return localizations.depositFarmLockProcessStep3;
      default:
        return localizations.depositFarmLockProcessStep0;
    }
  }
}
