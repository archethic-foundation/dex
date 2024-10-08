/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:uuid/uuid.dart';

const logName = 'DepositFarmCase';

class DepositFarmCase with aedappfm.TransactionMixin {
  DepositFarmCase({
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
    FarmDepositFormNotifier farmDepositNotifier,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    String farmAddress,
    bool isUCO, {
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

    farmDepositNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      farmDepositNotifier.setCurrentStep(1);
      try {
        final transactionDepositMap = await archethicContract.getFarmDepositTx(
          farmGenesisAddress,
          lpTokenAddress,
          amount,
        );

        transactionDepositMap.map(
          success: (success) {
            transactionDeposit = success;
            farmDepositNotifier.setTransactionDepositFarm(
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
      final currentNameAccount = await getCurrentAccount(dappClient);
      farmDepositNotifier.setWalletConfirmation(true);

      transactionDeposit = (await signTx(
        dappClient,
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionDeposit!],
        description: {
          'en': localizations.depositFarmSignTxDesc_en,
          'fr': localizations.depositFarmSignTxDesc_fr,
        },
      ))
          .first;

      farmDepositNotifier
        ..setWalletConfirmation(false)
        ..setTransactionDepositFarm(
          transactionDeposit!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmDepositNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmDepositNotifier.setFailure(
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

      farmDepositNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmDepositOk(true);

      notificationService.start(
        operationId,
        DexNotification.depositFarm(
          txAddress: transactionDeposit!.address!.address,
          farmAddress: farmAddress,
          isUCO: isUCO,
        ),
      );

      final amount = await aedappfm.PeriodicFuture.periodic<double>(
        () => getAmountFromTx(
          apiService,
          transactionDeposit!.address!.address!,
          isUCO,
          farmAddress,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (amount) => amount > 0,
        timeout: const Duration(minutes: 1),
      );

      notificationService.succeed(
        operationId,
        DexNotification.depositFarm(
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

      farmDepositNotifier
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
        return localizations.depositProcessStep1;
      case 2:
        return localizations.depositProcessStep2;
      case 3:
        return localizations.depositProcessStep3;
      default:
        return localizations.depositProcessStep0;
    }
  }
}
