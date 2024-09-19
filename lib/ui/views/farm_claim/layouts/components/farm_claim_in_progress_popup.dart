/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_final_amount.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final farmClaim = ref.watch(farmClaimFormNotifierProvider);

    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmClaim.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmClaim.isProcessInProgress,
        failure: farmClaim.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.watch(claimFarmCaseProvider).getAEStepLabel(
              localizations,
              farmClaim.currentStep,
            ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmClaim.isProcessInProgress,
        walletConfirmation: farmClaim.walletConfirmation,
        failure: farmClaim.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: farmClaim.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .farmClaimProcessInProgress,
        walletConfirmationTxt:
            AppLocalizations.of(context)!.farmClaimInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.farmClaimSuccessInfo,
      ),
      const FarmClaimInProgressTxAddresses(),
      if (farmClaim.transactionClaimFarm != null &&
          farmClaim.transactionClaimFarm!.address != null &&
          farmClaim.transactionClaimFarm!.address!.address != null)
        const FarmClaimFinalAmount(),
      const Spacer(),
      if (farmClaim.transactionClaimFarm == null ||
          farmClaim.transactionClaimFarm!.address == null ||
          farmClaim.transactionClaimFarm!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: farmClaim.currentStep,
          isProcessInProgress: farmClaim.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  farmClaimFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  farmClaimFormNotifierProvider.notifier,
                )
                .claim(context);
          },
          failure: farmClaim.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmClaim = ref.watch(farmClaimFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmClaim.isProcessInProgress,
      warningCloseLabel: farmClaim.isProcessInProgress == true
          ? AppLocalizations.of(context)!.farmClaimProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        final _farmClaim = ref.read(farmClaimFormNotifierProvider);
        ref
          ..invalidate(
            DexFarmProviders.getFarmList,
          )
          ..invalidate(
            FarmListFormProvider.balance(
              _farmClaim.lpTokenAddress,
            ),
          )
          ..invalidate(
            farmClaimFormNotifierProvider,
          );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          farmClaimFormNotifierProvider,
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
