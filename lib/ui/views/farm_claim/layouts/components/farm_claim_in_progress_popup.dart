/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/claim_farm.usecase.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_final_amount.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
            .farmClaimProcessInProgress,
        walletConfirmationTxt:
            AppLocalizations.of(context)!.farmClaimInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.farmClaimSuccessInfo,
      ),
      const FarmClaimInProgressTxAddresses(),
      if (farmClaim.transactionClaimFarm != null &&
          farmClaim.transactionClaimFarm!.address != null &&
          farmClaim.transactionClaimFarm!.address!.address != null)
        FarmClaimFinalAmount(
          address: farmClaim.transactionClaimFarm!.address!.address!,
        ),
      const Spacer(),
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
          ? AppLocalizations.of(context)!.farmClaimProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.read(
          FarmClaimFormProvider.farmClaimForm.notifier,
        )
          ..setProcessInProgress(false)
          ..setFailure(null)
          ..setFarmClaimOk(false)
          ..setWalletConfirmation(false);
        ref
            .read(
              navigationIndexMainScreenProvider.notifier,
            )
            .state = 2;
        context.go(FarmListSheet.routerPage);
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
