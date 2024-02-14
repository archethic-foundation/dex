/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'DepositFarmCase';

class DepositFarmCase with aedappfm.TransactionMixin {
  Future<void> run(
    WidgetRef ref,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionDeposit,
  }) async {
    final archethicContract = ArchethicContract();
    final farmDepositNotifier =
        ref.read(FarmDepositFormProvider.farmDepositForm.notifier);

    archethic.Transaction? transactionDeposit;
    if (recoveryTransactionDeposit != null) {
      transactionDeposit = recoveryTransactionDeposit;
    }

    if (recoveryStep <= 1) {
      farmDepositNotifier.setCurrentStep(1);
      try {
        final transactionDepositMap = await archethicContract.getDepositTx(
          farmGenesisAddress,
          lpTokenAddress,
          amount,
        );

        transactionDepositMap.map(
          success: (success) {
            transactionDeposit = success;
            farmDepositNotifier.setTransactionDepositFarm(
              transactionDeposit!,
            );
          },
          failure: (failure) {
            farmDepositNotifier
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
      farmDepositNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmDepositNotifier.setWalletConfirmation(true);

      transactionDeposit = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionDeposit!],
      ))
          .first;

      farmDepositNotifier
        ..setWalletConfirmation(false)
        ..setTransactionDepositFarm(
          transactionDeposit!,
        );
    } catch (e) {
      if (e is aedappfm.Failure) {
        farmDepositNotifier.setFailure(e);
        return;
      }
      farmDepositNotifier
          .setFailure(aedappfm.Failure.other(cause: e.toString()));

      return;
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionDeposit!,
        ],
      );

      farmDepositNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmDepositOk(true);
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionFarmDeposit sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmDepositNotifier.setFailure(
        aedappfm.Failure.other(
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
        return AppLocalizations.of(context)!.depositProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.depositProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.depositProcessStep3;
      default:
        return AppLocalizations.of(context)!.depositProcessStep0;
    }
  }
}
