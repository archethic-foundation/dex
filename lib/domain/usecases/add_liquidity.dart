/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

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
        liquidityAddNotifier.setWalletConfirmation(false);
      } catch (e) {
        if (e is Failure) {
          liquidityAddNotifier.setFailure(e);
          return;
        }
        liquidityAddNotifier.setFailure(Failure.other(cause: e.toString()));

        return;
      }
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionAddLiquidity!,
      ],
    );

    liquidityAddNotifier.setCurrentStep(3);

    unawaited(refreshCurrentAccountInfoWallet());
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
