/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_final_amount.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockLevelUpInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmLockLevelUp.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmLockLevelUp.isProcessInProgress,
        failure: farmLockLevelUp.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.read(levelUpFarmLockCaseProvider).getAEStepLabel(
              localizations,
              farmLockLevelUp.currentStep,
            ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmLockLevelUp.isProcessInProgress,
        walletConfirmation: farmLockLevelUp.walletConfirmation,
        failure: farmLockLevelUp.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: farmLockLevelUp.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .depositFarmLockProcessInProgress,
        walletConfirmationTxt: AppLocalizations.of(context)!
            .farmLockLevelUpInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.farmLockLevelUpSuccessInfo,
      ),
      const FarmLockLevelUpInProgressTxAddresses(),
      if (farmLockLevelUp.transactionFarmLockLevelUp != null &&
          farmLockLevelUp.transactionFarmLockLevelUp!.address != null &&
          farmLockLevelUp.transactionFarmLockLevelUp!.address!.address != null)
        const FarmLockLevelUpFinalAmount(),
      const Spacer(),
      if (farmLockLevelUp.transactionFarmLockLevelUp == null ||
          farmLockLevelUp.transactionFarmLockLevelUp!.address == null ||
          farmLockLevelUp.transactionFarmLockLevelUp!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: farmLockLevelUp.currentStep,
          isProcessInProgress: farmLockLevelUp.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  farmLockLevelUpFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  farmLockLevelUpFormNotifierProvider.notifier,
                )
                .lock(context);
          },
          failure: farmLockLevelUp.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmLockLevelUp.isProcessInProgress,
      warningCloseLabel: farmLockLevelUp.isProcessInProgress == true
          ? AppLocalizations.of(context)!.farmDepositProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        final _farmLockLevelUp = ref.read(farmLockLevelUpFormNotifierProvider);
        ref
          ..invalidate(
            DexFarmProviders.getFarmList,
          )
          ..invalidate(
            FarmListFormProvider.balance(
              _farmLockLevelUp.pool!.lpToken.address,
            ),
          )
          ..invalidate(
            farmLockLevelUpFormNotifierProvider,
          );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          farmLockLevelUpFormNotifierProvider,
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
