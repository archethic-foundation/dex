/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_lock_claim/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:uuid/uuid.dart';

const logName = 'ClaimFarmLockCase';

class ClaimFarmLockCase with aedappfm.TransactionMixin {
  ClaimFarmLockCase({
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
    FarmLockClaimFormNotifier farmClaimLockNotifier,
    String farmGenesisAddress,
    String depositId,
    DexToken rewardToken, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionClaim,
  }) async {
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );

    archethic.Transaction? transactionClaim;
    if (recoveryTransactionClaim != null) {
      transactionClaim = recoveryTransactionClaim;
    }

    farmClaimLockNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      farmClaimLockNotifier.setCurrentStep(1);
      try {
        final transactionClaimMap = await archethicContract.getFarmLockClaimTx(
          farmGenesisAddress,
          depositId,
        );

        transactionClaimMap.map(
          success: (success) {
            transactionClaim = success;
            farmClaimLockNotifier.setTransactionClaimFarmLock(
              transactionClaim!,
            );
          },
          failure: (failure) {
            farmClaimLockNotifier
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
      farmClaimLockNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount(dappClient);
      farmClaimLockNotifier.setWalletConfirmation(true);

      transactionClaim = (await signTx(
        dappClient,
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionClaim!],
        description: {
          'en': localizations.claimFarmLockSignTxDesc_en,
          'fr': localizations.claimFarmLockSignTxDesc_fr,
        },
      ))
          .first;

      farmClaimLockNotifier
        ..setWalletConfirmation(false)
        ..setTransactionClaimFarmLock(
          transactionClaim!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmClaimLockNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmClaimLockNotifier.setFailure(
        aedappfm.Failure.other(
          cause: e.toString().replaceAll('Exception: ', '').capitalize(),
        ),
      );

      throw aedappfm.Failure.fromError(e);
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionClaim!,
        ],
        apiService,
      );

      farmClaimLockNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmLockClaimOk(true);

      notificationService.start(
        operationId,
        DexNotification.claimFarmLock(
          txAddress: transactionClaim!.address!.address,
          rewardToken: rewardToken,
        ),
      );

      await aedappfm.PeriodicFuture.periodic<bool>(
        () => isSCCallExecuted(
          apiService,
          farmGenesisAddress,
          transactionClaim!.address!.address!,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (depositOk) => depositOk == true,
        timeout: const Duration(minutes: 1),
      );

      final amount = await aedappfm.PeriodicFuture.periodic<double>(
        () => getAmountFromTxInput(
          transactionClaim!.address!.address!,
          rewardToken.address,
          apiService,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (amount) => amount > 0,
        timeout: const Duration(minutes: 1),
      );

      notificationService.succeed(
        operationId,
        DexNotification.claimFarmLock(
          txAddress: transactionClaim!.address!.address,
          amount: amount,
          rewardToken: rewardToken,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet(dappClient));

      return amount;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionFarmClaim sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmClaimLockNotifier
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
        return localizations.claimLockProcessStep1;
      case 2:
        return localizations.claimLockProcessStep2;
      case 3:
        return localizations.claimLockProcessStep3;
      default:
        return localizations.claimLockProcessStep0;
    }
  }
}
