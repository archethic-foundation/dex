/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/domain/usecases/claim_farm.usecase.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_final_amount.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);

    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmClaim.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmClaim.isProcessInProgress,
        failure: farmClaim.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ClaimFarmCase().getAEStepLabel(
          context,
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
            .aeswap_farmClaimProcessInProgress,
        walletConfirmationTxt: AppLocalizations.of(context)!
            .aeswap_farmClaimInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.aeswap_farmClaimSuccessInfo,
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
                  FarmClaimFormProvider.farmClaimForm.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  FarmClaimFormProvider.farmClaimForm.notifier,
                )
                .claim(context, ref);
          },
          failure: farmClaim.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmClaim.isProcessInProgress,
      warningCloseLabel: farmClaim.isProcessInProgress == true
          ? AppLocalizations.of(context)!
              .aeswap_farmClaimProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        final _farmClaim = ref.read(FarmClaimFormProvider.farmClaimForm);
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
            FarmClaimFormProvider.farmClaimForm,
          );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          FarmClaimFormProvider.farmClaimForm,
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
