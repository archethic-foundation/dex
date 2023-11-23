/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'AddPoolCase';

class AddPoolCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    String routerAddress,
    double slippage, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionAddPool,
    archethic.Transaction? recoveryTransactionAddPoolTransfer,
    archethic.Transaction? recoveryTransactionAddPoolLiquidity,
    String? recoveryPoolGenesisAddress,
  }) async {
    final archethicContract = ArchethicContract();
    final poolAddNotifier = ref.read(PoolAddFormProvider.poolAddForm.notifier);

    archethic.Transaction? transactionAddPool;
    archethic.Transaction? transactionAddPoolTransfer;
    archethic.Transaction? transactionAddPoolLiquidity;
    String? poolGenesisAddress;
    if (recoveryTransactionAddPool != null) {
      transactionAddPool = recoveryTransactionAddPool;
    }
    if (recoveryTransactionAddPoolTransfer != null) {
      transactionAddPoolTransfer = recoveryTransactionAddPoolTransfer;
    }
    if (recoveryTransactionAddPoolLiquidity != null) {
      transactionAddPoolLiquidity = recoveryTransactionAddPoolLiquidity;
    }
    if (recoveryPoolGenesisAddress != null) {
      poolGenesisAddress = recoveryPoolGenesisAddress;
    }
    if (recoveryStep <= 1) {
      poolAddNotifier.setCurrentStep(1);
      try {
        final poolSeed = archethic.generateRandomSeed();
        poolGenesisAddress = archethic.deriveAddress(poolSeed, 0).toUpperCase();
        poolAddNotifier.setRecoveryPoolGenesisAddress(poolGenesisAddress);

        final lpTokenAddress =
            archethic.deriveAddress(poolSeed, 1).toUpperCase();
        final transactionAddPoolMap = await archethicContract.getAddPoolTx(
          routerAddress,
          token1,
          token2,
          poolSeed,
          poolGenesisAddress,
          lpTokenAddress,
        );

        transactionAddPoolMap.map(
          success: (success) {
            transactionAddPool = success;
            poolAddNotifier
                .setRecoveryTransactionAddPool(recoveryTransactionAddPool);
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

    if (recoveryStep <= 2) {
      poolAddNotifier.setCurrentStep(2);
      try {
        final transactionAddPoolTransferMap =
            await archethicContract.getAddPoolTxTransfer(
          transactionAddPool!,
          poolGenesisAddress!,
        );

        transactionAddPoolTransferMap.map(
          success: (success) {
            transactionAddPoolTransfer = success;
            poolAddNotifier.setRecoveryTransactionAddPoolTransfer(
              transactionAddPoolTransfer,
            );
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

    if (recoveryStep <= 3) {
      poolAddNotifier.setCurrentStep(3);
      try {
        final currentNameAccount = await getCurrentAccount();
        ref
            .read(PoolAddFormProvider.poolAddForm.notifier)
            .setWalletConfirmation(true);

        transactionAddPoolTransfer = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionAddPoolTransfer!],
        ))
            .first;

        ref
            .read(PoolAddFormProvider.poolAddForm.notifier)
            .setWalletConfirmation(false);
      } catch (e) {
        dev.log('Signature failed $e', name: logName);
        if (e is Failure) {
          poolAddNotifier.setFailure(e);
          return;
        }
        poolAddNotifier.setFailure(Failure.other(cause: e.toString()));

        return;
      }
      await sendTransactions(
        <archethic.Transaction>[
          transactionAddPoolTransfer!,
          transactionAddPool!,
        ],
      );
    }

    if (recoveryStep <= 4) {
      poolAddNotifier.setCurrentStep(4);
      try {
        final transactionAddPoolLiquidityMap =
            await archethicContract.getAddPoolPlusLiquidityTx(
          routerAddress,
          transactionAddPool!.address!.address!,
          token1,
          token1Amount,
          token2,
          token2Amount,
          poolGenesisAddress!,
          slippage,
        );

        transactionAddPoolLiquidityMap.map(
          success: (success) {
            transactionAddPoolLiquidity = success;
            poolAddNotifier.setRecoveryTransactionAddPoolLiquidity(
              transactionAddPoolLiquidity,
            );
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

    if (recoveryStep <= 5) {
      poolAddNotifier.setCurrentStep(5);
      try {
        final currentNameAccount = await getCurrentAccount();
        poolAddNotifier.setWalletConfirmation(true);

        transactionAddPoolLiquidity = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionAddPoolLiquidity!],
        ))
            .first;

        poolAddNotifier.setWalletConfirmation(false);
      } catch (e) {
        dev.log('Signature failed $e', name: logName);
        if (e is Failure) {
          poolAddNotifier.setFailure(e);
          return;
        }
        poolAddNotifier.setFailure(Failure.other(cause: e.toString()));

        return;
      }

      await sendTransactions(
        <archethic.Transaction>[
          transactionAddPoolLiquidity!,
        ],
      );

      poolAddNotifier.setCurrentStep(6);
    }
  }

  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.addPoolProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.addPoolProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.addPoolProcessStep3;
      case 4:
        return AppLocalizations.of(context)!.addPoolProcessStep4;
      case 5:
        return AppLocalizations.of(context)!.addPoolProcessStep5;
      case 6:
        return AppLocalizations.of(context)!.addPoolProcessStep6;
      default:
        return AppLocalizations.of(context)!.addPoolProcessStep0;
    }
  }
}
