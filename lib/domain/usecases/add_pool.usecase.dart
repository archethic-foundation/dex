/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/util/string_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_gen/gen_l10n/localizations.dart';

const logName = 'AddPoolCase';

class AddPoolCase with aedappfm.TransactionMixin {
  AddPoolCase({
    required this.apiService,
    required this.poolAddNotifier,
    required this.verifiedTokensRepository,
  });

  final archethic.ApiService apiService;
  final PoolAddFormNotifier poolAddNotifier;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;

  Future<void> run(
    AppLocalizations localizations,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    String routerAddress,
    String factoryAddress,
    double slippage, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionAddPool,
    archethic.Transaction? recoveryTransactionAddPoolTransfer,
    archethic.Transaction? recoveryTransactionAddPoolLiquidity,
    String? recoveryPoolGenesisAddress,
  }) async {
    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );

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
          factoryAddress,
          token1,
          token2,
          poolSeed,
          poolGenesisAddress,
          lpTokenAddress,
        );

        transactionAddPoolMap.map(
          success: (success) {
            transactionAddPool = success;
            poolAddNotifier.setRecoveryTransactionAddPool(transactionAddPool);
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
        poolAddNotifier.setWalletConfirmation(true);

        transactionAddPoolTransfer = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionAddPoolTransfer!],
          description: {
            'en': localizations.addPoolSignTxDesc1_en,
            'fr': localizations.addPoolSignTxDesc1_fr,
          },
        ))
            .first;

        poolAddNotifier
          ..setWalletConfirmation(false)
          ..setRecoveryTransactionAddPoolTransfer(
            transactionAddPoolTransfer,
          );
      } catch (e) {
        if (e is aedappfm.Failure) {
          poolAddNotifier
            ..setFailure(e)
            ..setProcessInProgress(false);
          return;
        }
        poolAddNotifier.setFailure(
          aedappfm.Failure.other(
            cause: e.toString().replaceAll('Exception: ', '').capitalize(),
          ),
        );

        return;
      }
      await sendTransactions(
        <archethic.Transaction>[
          transactionAddPoolTransfer!,
          transactionAddPool!,
        ],
        apiService,
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
          description: {
            'en': localizations.addPoolSignTxDesc2_en,
            'fr': localizations.addPoolSignTxDesc2_fr,
          },
        ))
            .first;

        poolAddNotifier
          ..setWalletConfirmation(false)
          ..setRecoveryTransactionAddPoolLiquidity(
            transactionAddPoolLiquidity,
          );
      } catch (e) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'Signature failed $e',
              level: aedappfm.LogLevel.error,
              name: 'aedappfm.TransactionMixin - sendTransactions',
            );
        if (e is aedappfm.Failure) {
          poolAddNotifier
            ..setFailure(e)
            ..setProcessInProgress(false);

          return;
        }
        poolAddNotifier
          ..setFailure(
            aedappfm.Failure.other(
              cause: e.toString().replaceAll('Exception: ', '').capitalize(),
            ),
          )
          ..setProcessInProgress(false);
        return;
      }

      try {
        await sendTransactions(
          <archethic.Transaction>[
            transactionAddPoolLiquidity!,
          ],
          apiService,
        );
        poolAddNotifier
          ..setCurrentStep(6)
          ..setResumeProcess(false)
          ..setProcessInProgress(false)
          ..setPoolAddOk(true);
        unawaited(refreshCurrentAccountInfoWallet());
      } catch (e) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'TransactionAddPoolLiquidity sendTx failed $e',
              level: aedappfm.LogLevel.error,
              name: 'aedappfm.TransactionMixin - sendTransactions',
            );

        poolAddNotifier
          ..setFailure(
            aedappfm.Failure.other(
              cause: e.toString().replaceAll('Exception: ', '').capitalize(),
            ),
          )
          ..setProcessInProgress(false);
        return;
      }
    }
  }

  String getAEStepLabel(
    AppLocalizations localizations,
    int step,
  ) {
    switch (step) {
      case 1:
        return localizations.addPoolProcessStep1;
      case 2:
        return localizations.addPoolProcessStep2;
      case 3:
        return localizations.addPoolProcessStep3;
      case 4:
        return localizations.addPoolProcessStep4;
      case 5:
        return localizations.addPoolProcessStep5;
      case 6:
        return localizations.addPoolProcessStep6;
      default:
        return localizations.addPoolProcessStep0;
    }
  }
}
