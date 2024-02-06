/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/contracts/archethic_contract.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'ClaimFarmCase';

class ClaimFarmCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    String farmGenesisAddress, {
    int recoveryStep = 0,
    archethic.Transaction? recoveryTransactionClaim,
  }) async {
    final archethicContract = ArchethicContract();
    final farmClaimNotifier =
        ref.read(FarmClaimFormProvider.farmClaimForm.notifier);

    archethic.Transaction? transactionClaim;
    if (recoveryTransactionClaim != null) {
      transactionClaim = recoveryTransactionClaim;
    }

    if (recoveryStep <= 1) {
      farmClaimNotifier.setCurrentStep(1);
      try {
        final transactionClaimMap = await archethicContract.getClaimTx(
          farmGenesisAddress,
        );

        transactionClaimMap.map(
          success: (success) {
            transactionClaim = success;
            farmClaimNotifier.setTransactionClaimFarm(
              transactionClaim!,
            );
          },
          failure: (failure) {
            farmClaimNotifier
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
      farmClaimNotifier.setCurrentStep(2);
    }
    try {
      final currentNameAccount = await getCurrentAccount();
      farmClaimNotifier.setWalletConfirmation(true);

      transactionClaim = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionClaim!],
      ))
          .first;

      farmClaimNotifier
        ..setWalletConfirmation(false)
        ..setTransactionClaimFarm(
          transactionClaim!,
        );
    } catch (e) {
      if (e is Failure) {
        farmClaimNotifier.setFailure(e);
        return;
      }
      farmClaimNotifier.setFailure(Failure.other(cause: e.toString()));

      return;
    }

    try {
      await sendTransactions(
        <archethic.Transaction>[
          transactionClaim!,
        ],
      );

      farmClaimNotifier
        ..setCurrentStep(3)
        ..setResumeProcess(false)
        ..setProcessInProgress(false)
        ..setFarmClaimOk(true);
      unawaited(refreshCurrentAccountInfoWallet());
    } catch (e) {
      sl.get<LogManager>().log(
            'TransactionFarmClaim sendTx failed $e',
            level: LogLevel.error,
            name: 'TransactionDexMixin - sendTransactions',
          );

      farmClaimNotifier.setFailure(
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
        return AppLocalizations.of(context)!.claimProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.claimProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.claimProcessStep3;
      default:
        return AppLocalizations.of(context)!.claimProcessStep0;
    }
  }
}