/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:uuid/uuid.dart';

const logName = 'AddLiquidityCase';

class AddLiquidityCase with aedappfm.TransactionMixin {
  AddLiquidityCase({
    required this.apiService,
    required this.notificationService,
    required this.liquidityAddNotifier,
    required this.verifiedTokensRepository,
  });

  final archethic.ApiService apiService;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;

  final ns.TaskNotificationService<DexNotification, aedappfm.Failure>
      notificationService;
  final LiquidityAddFormNotifier liquidityAddNotifier;

  Future<double> run(
    AppLocalizations localizations,
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    double slippage,
    DexToken lpToken, {
    int recoveryStep = 0,
  }) async {
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );

    archethic.Transaction? transactionAddLiquidity;

    liquidityAddNotifier.setFinalAmount(null);

    if (recoveryStep <= 1) {
      liquidityAddNotifier.setCurrentStep(1);
      try {
        final transactionAddLiquiditylMap =
            await archethicContract.getAddLiquidityTx(
          token1,
          token1Amount,
          token2,
          token2Amount,
          poolGenesisAddress,
          slippage,
        );

        transactionAddLiquiditylMap.map(
          success: (success) {
            transactionAddLiquidity = success;
          },
          failure: (failure) {
            liquidityAddNotifier
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
      liquidityAddNotifier.setCurrentStep(2);
      try {
        final currentNameAccount = await getCurrentAccount();
        liquidityAddNotifier.setWalletConfirmation(true);
        transactionAddLiquidity = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionAddLiquidity!],
          description: {
            'en': localizations.addLiquiditySignTxDesc_en,
            'fr': localizations.addLiquiditySignTxDesc_fr,
          },
        ))
            .first;
        liquidityAddNotifier
          ..setWalletConfirmation(false)
          ..setTransactionAddLiquidity(transactionAddLiquidity!);
      } catch (e) {
        if (e is aedappfm.Failure) {
          liquidityAddNotifier.setFailure(e);
          throw aedappfm.Failure.fromError(e);
        }
        liquidityAddNotifier.setFailure(
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
          transactionAddLiquidity!,
        ],
        apiService,
      );

      liquidityAddNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setLiquidityAddOk(true);

      notificationService.start(
        operationId,
        DexNotification.addLiquidity(
          txAddress: transactionAddLiquidity!.address!.address,
        ),
      );

      final amount = await aedappfm.PeriodicFuture.periodic<double>(
        () => getAmountFromTxInput(
          transactionAddLiquidity!.address!.address!,
          lpToken.address,
          apiService,
        ),
        sleepDuration: const Duration(seconds: 3),
        until: (amount) => amount > 0,
        timeout: const Duration(minutes: 1),
      );

      notificationService.succeed(
        operationId,
        DexNotification.addLiquidity(
          txAddress: transactionAddLiquidity!.address!.address,
          lpToken: lpToken,
          amount: amount,
        ),
      );

      unawaited(refreshCurrentAccountInfoWallet());

      return amount;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionAddLiquidity sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      liquidityAddNotifier
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

  Future<double> estimateFees(
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    double slippage,
  ) async {
    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );
    archethic.Transaction? transactionAddLiquidity;

    try {
      final transactionAddLiquiditylMap =
          await archethicContract.getAddLiquidityTx(
        token1,
        token1Amount,
        token2,
        token2Amount,
        poolGenesisAddress,
        slippage,
      );

      transactionAddLiquiditylMap.map(
        success: (success) {
          transactionAddLiquidity = success;
          // Add fake signature and address to allow estimation by node
          transactionAddLiquidity = transactionAddLiquidity!.copyWith(
            address: const archethic.Address(
              address:
                  '00000000000000000000000000000000000000000000000000000000000000000000',
            ),
            previousPublicKey:
                '00000000000000000000000000000000000000000000000000000000000000000000',
          );
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }

    final fees = await calculateFees(
      transactionAddLiquidity!,
      apiService,
    );
    return fees;
  }

  String getAEStepLabel(
    AppLocalizations localizations,
    int step,
  ) {
    switch (step) {
      case 1:
        return localizations.addLiquidityProcessStep1;
      case 2:
        return localizations.addLiquidityProcessStep2;
      case 3:
        return localizations.addLiquidityProcessStep3;
      default:
        return localizations.addLiquidityProcessStep0;
    }
  }
}
