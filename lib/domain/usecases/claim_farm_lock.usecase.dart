/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'ClaimFarmLockCase';

class ClaimFarmLockCase with aedappfm.TransactionMixin {
  Future<double> run(
    WidgetRef ref,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    int depositIndex,
    DexToken rewardToken, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionClaim,
  }) async {
    //final apiService = aedappfm.sl.get<archethic.ApiService>();
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final farmClaimNotifier =
        ref.read(FarmClaimFormProvider.farmClaimForm.notifier);

    archethic.Transaction? transactionClaim;
    if (recoveryTransactionClaim != null) {
      transactionClaim = recoveryTransactionClaim;
    }

    farmClaimNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      farmClaimNotifier.setCurrentStep(1);
      try {
        final transactionClaimMap = await archethicContract.getFarmLockClaimTx(
          farmGenesisAddress,
          depositIndex,
        );

        transactionClaimMap.map(
          success: (success) {
            transactionClaim = success;
            farmClaimNotifier.setTransactionClaimFarm(
              transactionClaim!,
            );
          },
          failure: (failure) {
            farmClaimNotifier
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
      farmClaimNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmClaimNotifier.setWalletConfirmation(true);

      transactionClaim = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionClaim!],
      ))
          .first;

      farmClaimNotifier
        ..setWalletConfirmation(false)
        ..setTransactionClaimFarm(
          transactionClaim!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmClaimNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmClaimNotifier.setFailure(aedappfm.Failure.other(cause: e.toString()));

      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionClaim!,
        ],
      );

      farmClaimNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmClaimOk(true);

      notificationService.start(
        operationId,
        DexNotification.claimFarm(
          txAddress: transactionClaim!.address!.address,
          rewardToken: rewardToken,
        ),
      );

      final amount = await aedappfm.PeriodicFuture.periodic<double>(
        () => getAmountFromTxInput(
          transactionClaim!.address!.address!,
          rewardToken.address,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (amount) => amount > 0,
        timeout: const Duration(minutes: 1),
      );

      notificationService.succeed(
        operationId,
        DexNotification.claimFarm(
          txAddress: transactionClaim!.address!.address,
          amount: amount,
          rewardToken: rewardToken,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet());

      return amount;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionFarmClaim sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmClaimNotifier
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
        return AppLocalizations.of(context)!.claimProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.claimProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.claimProcessStep3;
      default:
        return AppLocalizations.of(context)!.claimProcessStep0;
    }
  }
}
