/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/swap.usecase.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_final_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SwapInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: swap.currentStep,
        totalSteps: 4,
        isProcessInProgress: swap.isProcessInProgress,
        failure: swap.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: SwapCase().getAEStepLabel(
          context,
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
        inProgressTxt: AppLocalizations.of(context)!.swapProcessInProgress,
        walletConfirmationTxt:
            AppLocalizations.of(context)!.swapInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.swapSuccessInfo,
      ),
      const SwapInProgressTxAddresses(),
      if (swap.recoveryTransactionSwap != null &&
          swap.recoveryTransactionSwap!.address != null &&
          swap.recoveryTransactionSwap!.address!.address != null)
        const SwapFinalAmount(),
      const Spacer(),
      aedappfm.InProgressResumeBtn(
        currentStep: swap.currentStep,
        isProcessInProgress: swap.isProcessInProgress,
        onPressed: () async {
          ref
              .read(
                SwapFormProvider.swapForm.notifier,
              )
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(
                SwapFormProvider.swapForm.notifier,
              )
              .swap(context, ref);
        },
        failure: swap.failure,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: swap.isProcessInProgress,
      warningCloseLabel: swap.isProcessInProgress == true
          ? AppLocalizations.of(context)!.swapProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.invalidate(
          SwapFormProvider.swapForm,
        );
        context.go(SwapSheet.routerPage);
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
