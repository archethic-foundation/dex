/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_final_amount.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_list/layouts/farm_list_sheet.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmDepositInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final farmDeposit = ref.watch(farmDepositFormNotifierProvider);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmDeposit.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmDeposit.isProcessInProgress,
        failure: farmDeposit.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: ref.read(depositFarmCaseProvider).getAEStepLabel(
              localizations,
              farmDeposit.currentStep,
            ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmDeposit.isProcessInProgress,
        walletConfirmation: farmDeposit.walletConfirmation,
        failure: farmDeposit.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: farmDeposit.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .farmDepositProcessInProgress,
        walletConfirmationTxt:
            AppLocalizations.of(context)!.farmDepositInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.farmDepositSuccessInfo,
      ),
      const FarmDepositInProgressTxAddresses(),
      if (farmDeposit.transactionDepositFarm != null &&
          farmDeposit.transactionDepositFarm!.address != null &&
          farmDeposit.transactionDepositFarm!.address!.address != null)
        const FarmDepositFinalAmount(),
      const Spacer(),
      if (farmDeposit.transactionDepositFarm == null ||
          farmDeposit.transactionDepositFarm!.address == null ||
          farmDeposit.transactionDepositFarm!.address!.address == null)
        aedappfm.InProgressResumeBtn(
          currentStep: farmDeposit.currentStep,
          isProcessInProgress: farmDeposit.isProcessInProgress,
          onPressed: () async {
            ref
                .read(
                  farmDepositFormNotifierProvider.notifier,
                )
                .setResumeProcess(true);

            if (!context.mounted) return;
            await ref
                .read(
                  farmDepositFormNotifierProvider.notifier,
                )
                .deposit(context);
          },
          failure: farmDeposit.failure,
        ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmDeposit = ref.watch(farmDepositFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmDeposit.isProcessInProgress,
      warningCloseLabel: farmDeposit.isProcessInProgress == true
          ? AppLocalizations.of(context)!.farmDepositProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        final _farmDeposit = ref.read(farmDepositFormNotifierProvider);
        ref
          ..invalidate(
            DexFarmProviders.getFarmList,
          )
          ..invalidate(
            FarmListFormProvider.balance(
              _farmDeposit.dexFarmInfo!.lpToken!.address,
            ),
          )
          ..invalidate(
            farmDepositFormNotifierProvider,
          );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        context.go(FarmListSheet.routerPage);
      },
      closeFunction: () {
        ref.invalidate(
          farmDepositFormNotifierProvider,
        );
        if (!context.mounted) return;
        Navigator.of(context).pop();
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
