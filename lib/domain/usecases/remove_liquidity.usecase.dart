/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:uuid/uuid.dart';

const logName = 'RemoveLiquidityCase';

class RemoveLiquidityCase with aedappfm.TransactionMixin {
  RemoveLiquidityCase({
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

  Future<({double amountToken1, double amountToken2, double amountLPToken})>
      run(
    AppLocalizations localizations,
    LiquidityRemoveFormNotifier liquidityRemoveNotifier,
    String poolGenesisAddress,
    String lpTokenAddress,
    double lpTokenAmount,
    DexToken token1,
    DexToken token2,
    DexToken lpToken, {
    int recoveryStep = 0,
  }) async {
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );

    archethic.Transaction? transactionRemoveLiquidity;

    liquidityRemoveNotifier
      ..setFinalAmountToken1(null)
      ..setFinalAmountToken2(null)
      ..setFinalAmountLPToken(null);

    if (recoveryStep <= 1) {
      liquidityRemoveNotifier.setCurrentStep(1);
      try {
        final transactionAddLiquiditylMap =
            await archethicContract.getRemoveLiquidityTx(
          lpTokenAddress,
          lpTokenAmount,
          poolGenesisAddress,
        );

        transactionAddLiquiditylMap.map(
          success: (success) {
            transactionRemoveLiquidity = success;
          },
          failure: (failure) {
            liquidityRemoveNotifier
              ..setFailure(failure)
              ..setProcessInProgress(false);
            throw failure;
          },
        );
      } catch (e) {
        throw aedappfm.Failure.fromError(e);
      }
    }

    if (recoveryStep <= 1) {
      liquidityRemoveNotifier.setCurrentStep(2);
      try {
        final currentNameAccount = await getCurrentAccount(dappClient);
        liquidityRemoveNotifier.setWalletConfirmation(true);
        transactionRemoveLiquidity = (await signTx(
          dappClient,
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionRemoveLiquidity!],
          description: {
            'en': localizations.removeLiquiditySignTxDesc_en,
            'fr': localizations.removeLiquiditySignTxDesc_fr,
          },
        ))
            .first;
        liquidityRemoveNotifier
          ..setWalletConfirmation(false)
          ..setTransactionRemoveLiquidity(transactionRemoveLiquidity!);
      } catch (e) {
        if (e is aedappfm.Failure) {
          liquidityRemoveNotifier.setFailure(e);
          throw aedappfm.Failure.fromError(e);
        }
        liquidityRemoveNotifier.setFailure(
          aedappfm.Failure.other(
            cause: e.toString().replaceAll('Exception: ', '').capitalize(),
          ),
        );

        throw aedappfm.Failure.fromError(e);
      }
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionRemoveLiquidity!,
        ],
        apiService,
      );

      liquidityRemoveNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setLiquidityRemoveOk(true);

      notificationService.start(
        operationId,
        DexNotification.removeLiquidity(
          txAddress: transactionRemoveLiquidity!.address!.address,
        ),
      );

      final amounts = await aedappfm.PeriodicFuture.periodic<List<double>>(
        () => Future.wait([
          getAmountFromTxInput(
            transactionRemoveLiquidity!.address!.address!,
            token1.address,
            apiService,
          ),
          getAmountFromTxInput(
            transactionRemoveLiquidity!.address!.address!,
            token2.address,
            apiService,
          ),
          getAmountFromTx(
            apiService,
            transactionRemoveLiquidity!.address!.address!,
            false,
            '00000000000000000000000000000000000000000000000000000000000000000000',
          ),
        ]),
        sleepDuration: const Duration(seconds: 3),
        until: (amounts) {
          final amountToken1 = amounts[0];
          final amountToken2 = amounts[1];
          final amountLPToken = amounts[2];
          return amountToken1 > 0 && amountToken2 > 0 && amountLPToken > 0;
        },
        timeout: const Duration(minutes: 1),
      );

      final amountToken1 = amounts[0];
      final amountToken2 = amounts[1];
      final amountLPToken = amounts[2];

      notificationService.succeed(
        operationId,
        DexNotification.removeLiquidity(
          txAddress: transactionRemoveLiquidity!.address!.address,
          token1: token1,
          token2: token2,
          lpToken: lpToken,
          amountToken1: amountToken1,
          amountToken2: amountToken2,
          amountLPToken: amountLPToken,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet(dappClient));

      return (
        amountToken1: amountToken1,
        amountToken2: amountToken2,
        amountLPToken: amountLPToken,
      );
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionRemoveLiquidity sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      liquidityRemoveNotifier
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
        return localizations.removeLiquidityProcessStep1;
      case 2:
        return localizations.removeLiquidityProcessStep2;
      case 3:
        return localizations.removeLiquidityProcessStep3;
      default:
        return localizations.removeLiquidityProcessStep0;
    }
  }
}
