import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_final_amount.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);

    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: liquidityRemove.currentStep,
        totalSteps: 3,
        isProcessInProgress: liquidityRemove.isProcessInProgress,
        failure: liquidityRemove.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.read(removeLiquidityCaseProvider).getAEStepLabel(
              localizations,
              liquidityRemove.currentStep,
            ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: liquidityRemove.isProcessInProgress,
        walletConfirmation: liquidityRemove.walletConfirmation,
        failure: liquidityRemove.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: liquidityRemove.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .liquidityRemoveProcessInProgress,
        walletConfirmationTxt: AppLocalizations.of(context)!
            .liquidityRemoveInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(
          context,
        )!
            .liquidityRemoveSuccessInfo,
      ),
      const LiquidityRemoveInProgressTxAddresses(),
      if (liquidityRemove.transactionRemoveLiquidity != null &&
          liquidityRemove.transactionRemoveLiquidity!.address != null &&
          liquidityRemove.transactionRemoveLiquidity!.address!.address != null)
        const LiquidityRemoveFinalAmount(),
      const Spacer(),
      if (liquidityRemove.transactionRemoveLiquidity == null ||
          liquidityRemove.transactionRemoveLiquidity!.address == null ||
          liquidityRemove.transactionRemoveLiquidity!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: liquidityRemove.currentStep,
          isProcessInProgress: liquidityRemove.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  liquidityRemoveFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  liquidityRemoveFormNotifierProvider.notifier,
                )
                .remove(context);
          },
          failure: liquidityRemove.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);

    return aedappfm.PopupCloseButton(
      warningCloseWarning: liquidityRemove.isProcessInProgress,
      warningCloseLabel: liquidityRemove.isProcessInProgress == true
          ? AppLocalizations.of(context)!
              .liquidityRemoveProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.invalidate(
          liquidityRemoveFormNotifierProvider,
        );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          liquidityRemoveFormNotifierProvider,
        );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
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
