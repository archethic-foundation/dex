/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:uuid/uuid.dart';

const logName = 'ClaimFarmCase';

class ClaimFarmCase with aedappfm.TransactionMixin {
  ClaimFarmCase({
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
    FarmClaimFormNotifier farmClaimNotifier,
    String farmGenesisAddress,
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

    farmClaimNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      farmClaimNotifier.setCurrentStep(1);
      try {
        final transactionClaimMap = await archethicContract.getFarmClaimTx(
          farmGenesisAddress,
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
      final currentNameAccount = await getCurrentAccount(dappClient);
      farmClaimNotifier.setWalletConfirmation(true);

      transactionClaim = (await signTx(
        dappClient,
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionClaim!],
        description: {
          'en': localizations.claimFarmSignTxDesc_en,
          'fr': localizations.claimFarmSignTxDesc_fr,
        },
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
      farmClaimNotifier.setFailure(
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
          apiService,
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

      unawaited(refreshCurrentAccountInfoWallet(dappClient));

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
        return localizations.claimProcessStep1;
      case 2:
        return localizations.claimProcessStep2;
      case 3:
        return localizations.claimProcessStep3;
      default:
        return localizations.claimProcessStep0;
    }
  }
}
