/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/add_pool.usecase.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolAddInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: poolAdd.currentStep,
        totalSteps: 6,
        isProcessInProgress: poolAdd.isProcessInProgress,
        failure: poolAdd.failure,
      ),
      aedappfm.InProgressCurrentStep(
        steplabel: AddPoolCase().getAEStepLabel(
          context,
          poolAdd.currentStep,
        ),
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: poolAdd.isProcessInProgress,
        walletConfirmation: poolAdd.walletConfirmation,
        failure: poolAdd.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: poolAdd.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(context)!.poolAddProcessInProgress,
        walletConfirmationTxt:
            AppLocalizations.of(context)!.poolAddInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.poolAddSuccessInfo,
      ),
      const PoolAddInProgressTxAddresses(),
      const Spacer(),
      aedappfm.InProgressResumeBtn(
        currentStep: poolAdd.currentStep,
        isProcessInProgress: poolAdd.isProcessInProgress,
        onPressed: () async {
          ref
              .read(
                PoolAddFormProvider.poolAddForm.notifier,
              )
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(
                PoolAddFormProvider.poolAddForm.notifier,
              )
              .add(context, ref);
        },
        failure: poolAdd.failure,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: poolAdd.isProcessInProgress,
      warningCloseLabel: poolAdd.isProcessInProgress == true
          ? AppLocalizations.of(context)!.poolAddProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        ref.read(
          PoolAddFormProvider.poolAddForm.notifier,
        )
          ..setProcessInProgress(false)
          ..setFailure(null)
          ..setPoolAddOk(false)
          ..setWalletConfirmation(false);
        context.go(PoolListSheet.routerPage);
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
