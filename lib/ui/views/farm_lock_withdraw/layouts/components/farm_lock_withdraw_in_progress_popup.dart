/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/components/farm_lock_withdraw_final_amount.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/components/farm_lock_withdraw_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockWithdrawInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmLockWithdraw.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmLockWithdraw.isProcessInProgress,
        failure: farmLockWithdraw.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.read(withdrawFarmLockCaseProvider).getAEStepLabel(
              localizations,
              farmLockWithdraw.currentStep,
            ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmLockWithdraw.isProcessInProgress,
        walletConfirmation: farmLockWithdraw.walletConfirmation,
        failure: farmLockWithdraw.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: farmLockWithdraw.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .farmLockWithdrawProcessInProgress,
        walletConfirmationTxt: AppLocalizations.of(context)!
            .farmLockWithdrawInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.farmLockWithdrawSuccessInfo,
      ),
      const FarmLockWithdrawInProgressTxAddresses(),
      if (farmLockWithdraw.transactionWithdrawFarmLock != null &&
          farmLockWithdraw.transactionWithdrawFarmLock!.address != null &&
          farmLockWithdraw.transactionWithdrawFarmLock!.address!.address !=
              null)
        const FarmLockWithdrawFinalAmount(),
      const Spacer(),
      if (farmLockWithdraw.transactionWithdrawFarmLock == null ||
          farmLockWithdraw.transactionWithdrawFarmLock!.address == null ||
          farmLockWithdraw.transactionWithdrawFarmLock!.address!.address ==
              null)
        aedappfm.InProgressResumeBtn(
          currentStep: farmLockWithdraw.currentStep,
          isProcessInProgress: farmLockWithdraw.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  farmLockWithdrawFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  farmLockWithdrawFormNotifierProvider.notifier,
                )
                .withdraw(localizations);
          },
          failure: farmLockWithdraw.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmLockWithdraw.isProcessInProgress,
      warningCloseLabel: farmLockWithdraw.isProcessInProgress == true
          ? AppLocalizations.of(context)!
              .farmLockWithdrawProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref
          ..invalidate(
            DexFarmLockProviders.getFarmLockInfos,
          )
          ..invalidate(farmLockFormBalancesProvider)
          ..invalidate(farmLockFormFarmLockProvider)
          ..invalidate(
            farmLockWithdrawFormNotifierProvider,
          );
        if (!context.mounted) return;
        context
          ..pop()
          ..pop();
      },
      closeFunction: () {
        ref.invalidate(
          farmLockWithdrawFormNotifierProvider,
        );
        if (!context.mounted) return;
        context
          ..pop()
          ..pop();
      },
    );
  }

  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return aedappfm.InProgressPopup.getDialog(
      context,
      body,
      popupCloseButton,
    );
  }
}
