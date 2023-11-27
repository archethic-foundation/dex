/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'RemoveLiquidityCase';

class RemoveLiquidityCase with TransactionDexMixin {
  Future<void> run(
    String poolGenesisAddress,
    WidgetRef ref,
    String lpTokenAddress,
    double lpTokenAmount, {
    int recoveryStep = 0,
  }) async {
    final archethicContract = ArchethicContract();
    final liquidityRemoveNotifier =
        ref.read(LiquidityRemoveFormProvider.liquidityRemoveForm.notifier);

    archethic.Transaction? transactionRemoveLiquidity;
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
        return;
      }
    }

    if (recoveryStep <= 1) {
      liquidityRemoveNotifier.setCurrentStep(2);
      try {
        final currentNameAccount = await getCurrentAccount();
        liquidityRemoveNotifier.setWalletConfirmation(true);
        transactionRemoveLiquidity = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionRemoveLiquidity!],
        ))
            .first;
        liquidityRemoveNotifier.setWalletConfirmation(false);
      } catch (e) {
        if (e is Failure) {
          liquidityRemoveNotifier.setFailure(e);
          return;
        }
        liquidityRemoveNotifier.setFailure(Failure.other(cause: e.toString()));

        return;
      }
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionRemoveLiquidity!,
      ],
    );

    liquidityRemoveNotifier.setCurrentStep(3);

    unawaited(refreshCurrentAccountInfoWallet());
  }

  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.removeLiquidityProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.removeLiquidityProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.removeLiquidityProcessStep3;
      default:
        return AppLocalizations.of(context)!.removeLiquidityProcessStep0;
    }
  }
}
