/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/withdraw_farm_lock.usecase.dart';
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
    final farmLockWithdraw =
        ref.watch(FarmLockWithdrawFormProvider.farmLockWithdrawForm);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmLockWithdraw.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmLockWithdraw.isProcessInProgress,
        failure: farmLockWithdraw.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: WithdrawFarmLockCase().getAEStepLabel(
          context,
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
            .aeswap_farmLockWithdrawProcessInProgress,
        walletConfirmationTxt: AppLocalizations.of(context)!
            .aeswap_farmLockWithdrawInProgressConfirmAEWallet,
        successTxt:
            AppLocalizations.of(context)!.aeswap_farmLockWithdrawSuccessInfo,
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
                  FarmLockWithdrawFormProvider.farmLockWithdrawForm.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  FarmLockWithdrawFormProvider.farmLockWithdrawForm.notifier,
                )
                .withdraw(context, ref);
          },
          failure: farmLockWithdraw.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockWithdraw =
        ref.watch(FarmLockWithdrawFormProvider.farmLockWithdrawForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmLockWithdraw.isProcessInProgress,
      warningCloseLabel: farmLockWithdraw.isProcessInProgress == true
          ? AppLocalizations.of(context)!
              .aeswap_farmLockWithdrawProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.invalidate(
          FarmLockWithdrawFormProvider.farmLockWithdrawForm,
        );
        if (!context.mounted) return;
        context
          ..pop()
          ..pop();
      },
      closeFunction: () {
        ref.invalidate(
          FarmLockWithdrawFormProvider.farmLockWithdrawForm,
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
