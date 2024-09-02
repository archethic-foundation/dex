/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/domain/usecases/claim_farm.usecase.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_claim/layouts/components/farm_lock_claim_final_amount.dart';
import 'package:aedex/ui/views/farm_lock_claim/layouts/components/farm_lock_claim_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockClaimInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockClaim =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm);

    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmLockClaim.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmLockClaim.isProcessInProgress,
        failure: farmLockClaim.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ClaimFarmCase().getAEStepLabel(
          context,
          farmLockClaim.currentStep,
        ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmLockClaim.isProcessInProgress,
        walletConfirmation: farmLockClaim.walletConfirmation,
        failure: farmLockClaim.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: farmLockClaim.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .aeswap_farmLockClaimProcessInProgress,
        walletConfirmationTxt: AppLocalizations.of(context)!
            .aeswap_farmLockClaimInProgressConfirmAEWallet,
        successTxt:
            AppLocalizations.of(context)!.aeswap_farmLockClaimSuccessInfo,
      ),
      const FarmLockClaimInProgressTxAddresses(),
      if (farmLockClaim.transactionClaimFarmLock != null &&
          farmLockClaim.transactionClaimFarmLock!.address != null &&
          farmLockClaim.transactionClaimFarmLock!.address!.address != null)
        const FarmLockClaimFinalAmount(),
      const Spacer(),
      if (farmLockClaim.transactionClaimFarmLock == null ||
          farmLockClaim.transactionClaimFarmLock!.address == null ||
          farmLockClaim.transactionClaimFarmLock!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: farmLockClaim.currentStep,
          isProcessInProgress: farmLockClaim.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  FarmLockClaimFormProvider.farmLockClaimForm.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  FarmLockClaimFormProvider.farmLockClaimForm.notifier,
                )
                .claim(context, ref);
          },
          failure: farmLockClaim.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockClaim =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmLockClaim.isProcessInProgress,
      warningCloseLabel: farmLockClaim.isProcessInProgress == true
          ? AppLocalizations.of(context)!
              .aeswap_farmLockClaimProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        final _farmLockClaim =
            ref.read(FarmLockClaimFormProvider.farmLockClaimForm);
        ref
          ..invalidate(
            DexFarmProviders.getFarmList,
          )
          ..invalidate(
            FarmListFormProvider.balance(
              _farmLockClaim.lpTokenAddress,
            ),
          )
          ..invalidate(
            FarmLockClaimFormProvider.farmLockClaimForm,
          );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          FarmLockClaimFormProvider.farmLockClaimForm,
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
