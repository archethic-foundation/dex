/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_final_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final swap = ref.watch(swapFormNotifierProvider);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: swap.currentStep,
        totalSteps: 4,
        isProcessInProgress: swap.isProcessInProgress,
        failure: swap.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.read(swapCaseProvider).getAEStepLabel(
              localizations,
              swap.currentStep,
            ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: swap.isProcessInProgress,
        walletConfirmation: swap.walletConfirmation,
        failure: swap.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: swap.failure,
        ).getMessage(),
        inProgressTxt: localizations.swapProcessInProgress,
        walletConfirmationTxt: localizations.swapInProgressConfirmAEWallet,
        successTxt: localizations.swapSuccessInfo,
      ),
      const SwapInProgressTxAddresses(),
      if (swap.recoveryTransactionSwap != null &&
          swap.recoveryTransactionSwap!.address != null &&
          swap.recoveryTransactionSwap!.address!.address != null)
        const SwapFinalAmount(),
      const Spacer(),
      if (swap.recoveryTransactionSwap == null ||
          swap.recoveryTransactionSwap!.address == null ||
          swap.recoveryTransactionSwap!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: swap.currentStep,
          isProcessInProgress: swap.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  swapFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  swapFormNotifierProvider.notifier,
                )
                .swap(context);
          },
          failure: swap.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final swap = ref.watch(swapFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: swap.isProcessInProgress,
      warningCloseLabel: swap.isProcessInProgress == true
          ? AppLocalizations.of(context)!.swapProcessInterruptionWarning
          : '',
      warningCloseFunction: () async {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        await ref.read(swapFormNotifierProvider.notifier).returnToSwapForm();
      },
      closeFunction: () async {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        await ref.read(swapFormNotifierProvider.notifier).returnToSwapForm();
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
