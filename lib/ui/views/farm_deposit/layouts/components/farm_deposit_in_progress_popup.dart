/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/usecases/deposit_farm.usecase.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_circular_step_progress_indicator.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_current_step.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_infos_banner.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_resume_btn.dart';
import 'package:aedex/ui/views/util/components/popup_close_button.dart';
import 'package:aedex/ui/views/util/components/popup_waves.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositInProgressPopup {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return Consumer(
                builder: (context, ref, _) {
                  final farmDeposit =
                      ref.watch(FarmDepositFormProvider.farmDepositForm);
                  return Scaffold(
                    backgroundColor: Colors.transparent.withAlpha(120),
                    body: AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Stack(
                        children: <Widget>[
                          ArchethicScrollbar(
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                right: 15,
                                left: 8,
                              ),
                              height: 400,
                              width: DexThemeBase.sizeBoxComponentWidth,
                              decoration: BoxDecoration(
                                color: DexThemeBase.backgroundPopupColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 300,
                                    ),
                                    child: Card(
                                      color: Colors.transparent,
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: PopupWaves(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        DexInProgressCircularStepProgressIndicator(
                                          currentStep: farmDeposit.currentStep,
                                          totalSteps: 3,
                                          isProcessInProgress:
                                              farmDeposit.isProcessInProgress,
                                          failure: farmDeposit.failure,
                                        ),
                                        DexInProgressCurrentStep(
                                          steplabel:
                                              DepositFarmCase().getAEStepLabel(
                                            context,
                                            farmDeposit.currentStep,
                                          ),
                                        ),
                                        DexInProgressInfosBanner(
                                          isProcessInProgress:
                                              farmDeposit.isProcessInProgress,
                                          walletConfirmation:
                                              farmDeposit.walletConfirmation,
                                          failure: farmDeposit.failure,
                                          inProgressTxt: AppLocalizations.of(
                                            context,
                                          )!
                                              .farmDepositProcessInProgress,
                                          walletConfirmationTxt: AppLocalizations
                                                  .of(context)!
                                              .farmDepositInProgressConfirmAEWallet,
                                          successTxt:
                                              AppLocalizations.of(context)!
                                                  .farmDepositSuccessInfo,
                                        ),
                                        const FarmDepositInProgressTxAddresses(),
                                        const Spacer(),
                                        DexInProgressResumeBtn(
                                          currentStep: farmDeposit.currentStep,
                                          isProcessInProgress:
                                              farmDeposit.isProcessInProgress,
                                          onPressed: () async {
                                            ref
                                                .read(
                                                  FarmDepositFormProvider
                                                      .farmDepositForm.notifier,
                                                )
                                                .setResumeProcess(true);

                                            if (!context.mounted) return;
                                            await ref
                                                .read(
                                                  FarmDepositFormProvider
                                                      .farmDepositForm.notifier,
                                                )
                                                .deposit(context, ref);
                                          },
                                          failure: farmDeposit.failure,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: PopupCloseButton(
                              warningCloseWarning:
                                  farmDeposit.isProcessInProgress,
                              warningCloseLabel:
                                  farmDeposit.isProcessInProgress == true
                                      ? AppLocalizations.of(context)!
                                          .farmDepositProcessInterruptionWarning
                                      : '',
                              warningCloseFunction: () {
                                ref.read(
                                  FarmDepositFormProvider
                                      .farmDepositForm.notifier,
                                )
                                  ..setProcessInProgress(false)
                                  ..setFailure(null)
                                  ..setFarmDepositOk(false)
                                  ..setWalletConfirmation(false);
                                ref
                                    .read(
                                      MainScreenWidgetDisplayedProviders
                                          .mainScreenWidgetDisplayedProvider
                                          .notifier,
                                    )
                                    .setWidget(const FarmListSheet(), ref);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
