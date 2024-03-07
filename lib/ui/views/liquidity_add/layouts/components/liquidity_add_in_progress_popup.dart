/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/add_liquidity.usecase.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_final_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityAddInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: liquidityAdd.currentStep,
        totalSteps: 3,
        isProcessInProgress: liquidityAdd.isProcessInProgress,
        failure: liquidityAdd.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: AddLiquidityCase().getAEStepLabel(
          context,
          liquidityAdd.currentStep,
        ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: liquidityAdd.isProcessInProgress,
        walletConfirmation: liquidityAdd.walletConfirmation,
        failure: liquidityAdd.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: liquidityAdd.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .liquidityAddProcessInProgress,
        walletConfirmationTxt:
            AppLocalizations.of(context)!.liquidityAddInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.liquidityAddSuccessInfo,
      ),
      const LiquidityAddInProgressTxAddresses(),
      if (liquidityAdd.pool != null &&
          liquidityAdd.pool!.lpToken.address != null &&
          liquidityAdd.transactionAddLiquidity != null &&
          liquidityAdd.transactionAddLiquidity!.address != null &&
          liquidityAdd.transactionAddLiquidity!.address!.address != null)
        const LiquidityAddFinalAmount(),
      const Spacer(),
      aedappfm.InProgressResumeBtn(
        currentStep: liquidityAdd.currentStep,
        isProcessInProgress: liquidityAdd.isProcessInProgress,
        onPressed: () async {
          ref
              .read(
                LiquidityAddFormProvider.liquidityAddForm.notifier,
              )
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(
                LiquidityAddFormProvider.liquidityAddForm.notifier,
              )
              .add(context, ref);
        },
        failure: liquidityAdd.failure,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: liquidityAdd.isProcessInProgress,
      warningCloseLabel: liquidityAdd.isProcessInProgress == true
          ? AppLocalizations.of(context)!.liquidityAddProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.read(
          LiquidityAddFormProvider.liquidityAddForm.notifier,
        )
          ..setProcessInProgress(false)
          ..setFailure(null)
          ..setLiquidityAddOk(false)
          ..setWalletConfirmation(false);
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
