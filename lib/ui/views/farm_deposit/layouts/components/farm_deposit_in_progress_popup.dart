/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/deposit_farm.usecase.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_final_amount.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
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
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: farmDeposit.currentStep,
        totalSteps: 3,
        isProcessInProgress: farmDeposit.isProcessInProgress,
        failure: farmDeposit.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: DepositFarmCase().getAEStepLabel(
          context,
          farmDeposit.currentStep,
        ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: farmDeposit.isProcessInProgress,
        walletConfirmation: farmDeposit.walletConfirmation,
        failure: farmDeposit.failure,
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
        FarmDepositFinalAmount(
          address: farmDeposit.transactionDepositFarm!.address!.address!,
        ),
      const Spacer(),
      aedappfm.InProgressResumeBtn(
        currentStep: farmDeposit.currentStep,
        isProcessInProgress: farmDeposit.isProcessInProgress,
        onPressed: () async {
          ref
              .read(
                FarmDepositFormProvider.farmDepositForm.notifier,
              )
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(
                FarmDepositFormProvider.farmDepositForm.notifier,
              )
              .deposit(context, ref);
        },
        failure: farmDeposit.failure,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: farmDeposit.isProcessInProgress,
      warningCloseLabel: farmDeposit.isProcessInProgress == true
          ? AppLocalizations.of(context)!.farmDepositProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.read(
          FarmDepositFormProvider.farmDepositForm.notifier,
        )
          ..setProcessInProgress(false)
          ..setFailure(null)
          ..setFarmDepositOk(false)
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
      ref,
      body(
        context,
        ref,
      ),
      popupCloseButton(context, ref),
    );
  }
}
