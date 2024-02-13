/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'WithdrawFarmCase';

class WithdrawFarmCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionWithdraw,
  }) async {
    final archethicContract = ArchethicContract();
    final farmWithdrawNotifier =
        ref.read(FarmWithdrawFormProvider.farmWithdrawForm.notifier);

    archethic.Transaction? transactionWithdraw;
    if (recoveryTransactionWithdraw != null) {
      transactionWithdraw = recoveryTransactionWithdraw;
    }

    if (recoveryStep <= 1) {
      farmWithdrawNotifier.setCurrentStep(1);
      try {
        final transactionWithdrawMap = await archethicContract.getWithdrawTx(
          farmGenesisAddress,
          amount,
        );

        transactionWithdrawMap.map(
          success: (success) {
            transactionWithdraw = success;
            farmWithdrawNotifier.setTransactionWithdrawFarm(
              transactionWithdraw!,
            );
          },
          failure: (failure) {
            farmWithdrawNotifier
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
      farmWithdrawNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmWithdrawNotifier.setWalletConfirmation(true);

      transactionWithdraw = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionWithdraw!],
      ))
          .first;

      farmWithdrawNotifier
        ..setWalletConfirmation(false)
        ..setTransactionWithdrawFarm(
          transactionWithdraw!,
        );
    } catch (e) {
      if (e is Failure) {
        farmWithdrawNotifier.setFailure(e);
        return;
      }
      farmWithdrawNotifier.setFailure(Failure.other(cause: e.toString()));

      return;
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionWithdraw!,
        ],
      );

      farmWithdrawNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmWithdrawOk(true);
    } catch (e) {
      sl.get<LogManager>().log(
            'TransactionWithdrawFarm sendTx failed $e',
            level: LogLevel.error,
            name: 'TransactionDexMixin - sendTransactions',
          );

      farmWithdrawNotifier.setFailure(
        Failure.other(
          cause: e.toString(),
        ),
      );
      return;
    }
  }

  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.withdrawProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.withdrawProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.withdrawProcessStep3;
      default:
        return AppLocalizations.of(context)!.withdrawProcessStep0;
    }
  }
}
