/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'AddLiquidityCase';

class AddLiquidityCase with aedappfm.TransactionMixin {
  Future<void> run(
    WidgetRef ref,
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    double slippage, {
    int recoveryStep = 0,
  }) async {
    final archethicContract = ArchethicContract();
    final liquidityAddNotifier =
        ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier);

    archethic.Transaction? transactionAddLiquidity;
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
        return;
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
        ))
            .first;
        liquidityAddNotifier
          ..setWalletConfirmation(false)
          ..setTransactionAddLiquidity(transactionAddLiquidity!);
      } catch (e) {
        if (e is aedappfm.Failure) {
          liquidityAddNotifier.setFailure(e);
          return;
        }
        liquidityAddNotifier
            .setFailure(aedappfm.Failure.other(cause: e.toString()));

        return;
      }
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionAddLiquidity!,
        ],
      );

      liquidityAddNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setLiquidityAddOk(true);
      unawaited(refreshCurrentAccountInfoWallet());
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionAddLiquidity sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      liquidityAddNotifier
        ..setFailure(
          aedappfm.Failure.other(
            cause: e.toString(),
          ),
        )
        ..setCurrentStep(3);
      return;
    }
  }

  // TODO(redDwarf03): Wait for https://github.com/archethic-foundation/archethic-node/issues/1418
  Future<double> estimateFees(
    WidgetRef ref,
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    double slippage,
  ) async {
    final archethicContract = ArchethicContract();
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
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }

    final fees = await calculateFees(transactionAddLiquidity!);
    return fees;
  }

  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.addLiquidityProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.addLiquidityProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.addLiquidityProcessStep3;
      default:
        return AppLocalizations.of(context)!.addLiquidityProcessStep0;
    }
  }
}
