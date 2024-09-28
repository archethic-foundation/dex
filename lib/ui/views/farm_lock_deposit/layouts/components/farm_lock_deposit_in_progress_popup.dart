import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
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
    final localizations = AppLocalizations.of(context)!;
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmLockDeposit.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmLockDeposit.isProcessInProgress,
        failure: farmLockDeposit.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.read(depositFarmLockCaseProvider).getAEStepLabel(
              localizations,
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
                  farmLockDepositFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  farmLockDepositFormNotifierProvider.notifier,
                )
                .lock(AppLocalizations.of(context)!);
          },
          failure: farmLockDeposit.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmLockDeposit.isProcessInProgress,
      warningCloseLabel: farmLockDeposit.isProcessInProgress == true
          ? AppLocalizations.of(context)!.farmDepositProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref
          ..invalidate(
            DexFarmLockProviders.getFarmLockInfos,
          )
          ..invalidate(farmLockFormBalancesProvider)
          ..invalidate(farmLockFormFarmLockProvider)
          ..invalidate(
            farmLockDepositFormNotifierProvider,
          );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          farmLockDepositFormNotifierProvider,
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
