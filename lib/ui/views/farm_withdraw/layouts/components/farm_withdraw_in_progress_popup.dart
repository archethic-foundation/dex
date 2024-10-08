/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_final_amount.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmWithdrawInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final farmWithdraw = ref.watch(farmWithdrawFormNotifierProvider);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmWithdraw.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmWithdraw.isProcessInProgress,
        failure: farmWithdraw.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.read(withdrawFarmCaseProvider).getAEStepLabel(
              localizations,
              farmWithdraw.currentStep,
            ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmWithdraw.isProcessInProgress,
        walletConfirmation: farmWithdraw.walletConfirmation,
        failure: farmWithdraw.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: farmWithdraw.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .farmWithdrawProcessInProgress,
        walletConfirmationTxt:
            AppLocalizations.of(context)!.farmWithdrawInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.farmWithdrawSuccessInfo,
      ),
      const FarmWithdrawInProgressTxAddresses(),
      if (farmWithdraw.transactionWithdrawFarm != null &&
          farmWithdraw.transactionWithdrawFarm!.address != null &&
          farmWithdraw.transactionWithdrawFarm!.address!.address != null)
        const FarmWithdrawFinalAmount(),
      const Spacer(),
      if (farmWithdraw.transactionWithdrawFarm == null ||
          farmWithdraw.transactionWithdrawFarm!.address == null ||
          farmWithdraw.transactionWithdrawFarm!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: farmWithdraw.currentStep,
          isProcessInProgress: farmWithdraw.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  farmWithdrawFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  farmWithdrawFormNotifierProvider.notifier,
                )
                .withdraw(localizations);
          },
          failure: farmWithdraw.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmWithdraw = ref.watch(farmWithdrawFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmWithdraw.isProcessInProgress,
      warningCloseLabel: farmWithdraw.isProcessInProgress == true
          ? AppLocalizations.of(context)!.farmWithdrawProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        final _farmWithdraw = ref.read(farmWithdrawFormNotifierProvider);
        ref
          ..invalidate(
            DexFarmProviders.getFarmList,
          )
          ..invalidate(
            FarmListFormProvider.balance(
              _farmWithdraw.dexFarmInfo!.lpToken!.address,
            ),
          )
          ..invalidate(
            farmWithdrawFormNotifierProvider,
          );
        if (!context.mounted) return;
        context
          ..pop()
          ..pop();
      },
      closeFunction: () {
        ref.invalidate(
          farmWithdrawFormNotifierProvider,
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
