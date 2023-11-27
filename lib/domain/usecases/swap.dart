/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'SwapCase';

class SwapCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    String poolGenesisAddress,
    DexToken tokenToSwap,
    double tokenToSwapAmount,
    double slippage, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionSwap,
  }) async {
    final archethicContract = ArchethicContract();
    final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);

    archethic.Transaction? transactionSwap;
    if (recoveryTransactionSwap != null) {
      transactionSwap = recoveryTransactionSwap;
    }

    var outputAmount = 0.0;
    if (recoveryStep <= 1) {
      swapNotifier.setCurrentStep(1);

      try {
        final outputAmountMap = await archethicContract.getOutputAmount(
          tokenToSwap,
          tokenToSwapAmount,
          poolGenesisAddress,
        );

        outputAmountMap.map(
          success: (success) {
            outputAmount = success;

            if (outputAmount <= 0) {
              throw const Failure.other(
                cause: 'Error outputAmount',
              );
            }
          },
          failure: (failure) {
            swapNotifier
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
      swapNotifier.setCurrentStep(2);
      try {
        final transactionSwapMap = await archethicContract.getSwapTx(
          tokenToSwap,
          tokenToSwapAmount,
          poolGenesisAddress,
          slippage,
          outputAmount,
        );

        transactionSwapMap.map(
          success: (success) {
            transactionSwap = success;
            swapNotifier.setRecoveryTransactionSwap(
              transactionSwap,
            );
          },
          failure: (failure) {
            swapNotifier
              ..setFailure(failure)
              ..setProcessInProgress(false);
            throw failure;
          },
        );
      } catch (e) {
        return;
      }
    }

    if (recoveryStep <= 3) {
      swapNotifier.setCurrentStep(3);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      swapNotifier.setWalletConfirmation(true);

      transactionSwap = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionSwap!],
      ))
          .first;

      swapNotifier.setWalletConfirmation(false);
    } catch (e) {
      if (e is Failure) {
        swapNotifier.setFailure(e);
        return;
      }
      swapNotifier.setFailure(Failure.other(cause: e.toString()));

      return;
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionSwap!,
      ],
    );

    swapNotifier.setCurrentStep(4);

    unawaited(refreshCurrentAccountInfoWallet());
  }

  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.swapProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.swapProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.swapProcessStep3;
      case 4:
        return AppLocalizations.of(context)!.swapProcessStep4;
      default:
        return AppLocalizations.of(context)!.swapProcessStep0;
    }
  }
}