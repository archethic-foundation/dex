/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'LevelUpFarmLockCase';

class LevelUpFarmLockCase with aedappfm.TransactionMixin {
  Future<double> run(
    WidgetRef ref,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    int depositIndex,
    String farmAddress,
    bool isUCO,
    FarmLockDepositDurationType durationType, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionDeposit,
  }) async {
    //final apiService = aedappfm.sl.get<archethic.ApiService>();
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final farmDepositNotifier =
        ref.read(FarmLockDepositFormProvider.farmLockDepositForm.notifier);

    archethic.Transaction? transactionDeposit;
    if (recoveryTransactionDeposit != null) {
      transactionDeposit = recoveryTransactionDeposit;
    }

    farmDepositNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      farmDepositNotifier.setCurrentStep(1);
      try {
        final transactionDepositMap =
            await archethicContract.getFarmLockRelockTx(
          farmGenesisAddress,
          lpTokenAddress,
          amount,
          depositIndex,
          durationType,
        );

        transactionDepositMap.map(
          success: (success) {
            transactionDeposit = success;
            farmDepositNotifier.setTransactionFarmLockDeposit(
              transactionDeposit!,
            );
          },
          failure: (failure) {
            farmDepositNotifier
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
      farmDepositNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmDepositNotifier.setWalletConfirmation(true);

      transactionDeposit = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionDeposit!],
        description: {
          'en':
              "The transaction sends the LP tokens to be locked into the farm and calls the smart contract's deposit function with the tokens' release date.",
        },
      ))
          .first;

      farmDepositNotifier
        ..setWalletConfirmation(false)
        ..setTransactionFarmLockDeposit(
          transactionDeposit!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmDepositNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmDepositNotifier
          .setFailure(aedappfm.Failure.other(cause: e.toString()));
      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionDeposit!,
        ],
      );

      farmDepositNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmLockDepositOk(true);

      notificationService.start(
        operationId,
        DexNotification.depositFarm(
          txAddress: transactionDeposit!.address!.address,
          farmAddress: farmAddress,
          isUCO: isUCO,
        ),
      );

      final cancelCompleter = Completer<void>();
      final periodicFuture = aedappfm.PeriodicFuture.periodic<double>(
        () => getAmountFromTx(
          transactionDeposit!.address!.address!,
          isUCO,
          farmAddress,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (amount) => amount > 0,
        cancelCompleter: cancelCompleter,
      );

      final amount = await periodicFuture.timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          cancelCompleter.complete();
          throw const aedappfm.Timeout();
        },
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

      unawaited(refreshCurrentAccountInfoWallet());

      return amount;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionFarmDeposit sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmDepositNotifier
        ..setFailure(
          e is aedappfm.Timeout
              ? e
              : aedappfm.Failure.other(
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
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep3;
      default:
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep0;
    }
  }
}