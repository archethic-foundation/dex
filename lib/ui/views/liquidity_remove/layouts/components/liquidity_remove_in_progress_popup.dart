/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/remove_liquidity.usecase.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityRemoveInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: liquidityRemove.currentStep,
        totalSteps: 3,
        isProcessInProgress: liquidityRemove.isProcessInProgress,
        failure: liquidityRemove.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: RemoveLiquidityCase().getAEStepLabel(
          context,
          liquidityRemove.currentStep,
        ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: liquidityRemove.isProcessInProgress,
        walletConfirmation: liquidityRemove.walletConfirmation,
        failure: liquidityRemove.failure,
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
      const Spacer(),
      aedappfm.InProgressResumeBtn(
        currentStep: liquidityRemove.currentStep,
        isProcessInProgress: liquidityRemove.isProcessInProgress,
        onPressed: () async {
          ref
              .read(
                LiquidityRemoveFormProvider.liquidityRemoveForm.notifier,
              )
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(
                LiquidityRemoveFormProvider.liquidityRemoveForm.notifier,
              )
              .remove(context, ref);
        },
        failure: liquidityRemove.failure,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    return aedappfm.PopupCloseButton(
      warningCloseWarning: liquidityRemove.isProcessInProgress,
      warningCloseLabel: liquidityRemove.isProcessInProgress == true
          ? AppLocalizations.of(context)!
              .liquidityRemoveProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.read(
          LiquidityRemoveFormProvider.liquidityRemoveForm.notifier,
        )
          ..setProcessInProgress(false)
          ..setFailure(null)
          ..setLiquidityRemoveOk(false)
          ..setWalletConfirmation(false);
        ref
            .read(
              navigationIndexMainScreenProvider.notifier,
            )
            .state = 1;
        context.go(PoolListSheet.routerPage);
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
