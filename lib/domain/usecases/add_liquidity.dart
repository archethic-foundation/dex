/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'AddLiquidityCase';

class AddLiquidityCase with TransactionDexMixin {
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
    final poolAddNotifier =
        ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier);

    archethic.Transaction? transactionAddLiquidity;
    if (recoveryStep <= 1) {
      poolAddNotifier.setCurrentStep(1);
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
            poolAddNotifier
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
      poolAddNotifier.setCurrentStep(2);
      try {
        final currentNameAccount = await getCurrentAccount();
        poolAddNotifier.setWalletConfirmation(true);
        transactionAddLiquidity = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionAddLiquidity!],
        ))
            .first;
        poolAddNotifier.setWalletConfirmation(false);
      } catch (e) {
        dev.log('Signature failed', name: logName);
        if (e is Failure) {
          ref
              .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
              .setFailure(e);
          return;
        }
        ref
            .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
            .setFailure(Failure.other(cause: e.toString()));

        return;
      }
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionAddLiquidity!,
      ],
    );

    poolAddNotifier.setCurrentStep(3);
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
