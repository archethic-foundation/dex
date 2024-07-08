/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/domain/usecases/deposit_farm_lock.usecase.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_final_amount.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockDeposit =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmLockDeposit.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmLockDeposit.isProcessInProgress,
        failure: farmLockDeposit.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: DepositFarmLockCase().getAEStepLabel(
          context,
          farmLockDeposit.currentStep,
        ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmLockDeposit.isProcessInProgress,
        walletConfirmation: farmLockDeposit.walletConfirmation,
        failure: farmLockDeposit.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: farmLockDeposit.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .depositFarmLockProcessInProgress,
        walletConfirmationTxt: AppLocalizations.of(context)!
            .farmLockDepositInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.farmLockDepositSuccessInfo,
      ),
      const FarmLockDepositInProgressTxAddresses(),
      if (farmLockDeposit.transactionFarmLockDeposit != null &&
          farmLockDeposit.transactionFarmLockDeposit!.address != null &&
          farmLockDeposit.transactionFarmLockDeposit!.address!.address != null)
        const FarmLockDepositFinalAmount(),
      const Spacer(),
      if (farmLockDeposit.transactionFarmLockDeposit == null ||
          farmLockDeposit.transactionFarmLockDeposit!.address == null ||
          farmLockDeposit.transactionFarmLockDeposit!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: farmLockDeposit.currentStep,
          isProcessInProgress: farmLockDeposit.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  FarmLockDepositFormProvider.farmLockDepositForm.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  FarmLockDepositFormProvider.farmLockDepositForm.notifier,
                )
                .lock(context, ref);
          },
          failure: farmLockDeposit.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockDeposit =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmLockDeposit.isProcessInProgress,
      warningCloseLabel: farmLockDeposit.isProcessInProgress == true
          ? AppLocalizations.of(context)!.farmDepositProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        final _farmLockDeposit =
            ref.read(FarmLockDepositFormProvider.farmLockDepositForm);
        ref
          ..invalidate(
            DexFarmProviders.getFarmList,
          )
          ..invalidate(
            FarmListFormProvider.balance(
              _farmLockDeposit.pool!.lpToken.address,
            ),
          )
          ..invalidate(
            FarmLockDepositFormProvider.farmLockDepositForm,
          );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          FarmLockDepositFormProvider.farmLockDepositForm,
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
