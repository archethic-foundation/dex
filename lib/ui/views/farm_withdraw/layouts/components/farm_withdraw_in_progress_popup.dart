/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/usecases/withdraw_farm.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_in_progress_tx_addresses.dart';
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

class FarmWithdrawInProgressPopup {
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
                  final farmWithdraw =
                      ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
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
                                          currentStep: farmWithdraw.currentStep,
                                          totalSteps: 3,
                                          isProcessInProgress:
                                              farmWithdraw.isProcessInProgress,
                                          failure: farmWithdraw.failure,
                                        ),
                                        DexInProgressCurrentStep(
                                          steplabel:
                                              WithdrawFarmCase().getAEStepLabel(
                                            context,
                                            farmWithdraw.currentStep,
                                          ),
                                        ),
                                        DexInProgressInfosBanner(
                                          isProcessInProgress:
                                              farmWithdraw.isProcessInProgress,
                                          walletConfirmation:
                                              farmWithdraw.walletConfirmation,
                                          failure: farmWithdraw.failure,
                                          inProgressTxt: AppLocalizations.of(
                                            context,
                                          )!
                                              .farmWithdrawProcessInProgress,
                                          walletConfirmationTxt: AppLocalizations
                                                  .of(context)!
                                              .farmWithdrawInProgressConfirmAEWallet,
                                          successTxt:
                                              AppLocalizations.of(context)!
                                                  .farmWithdrawSuccessInfo,
                                        ),
                                        const FarmWithdrawInProgressTxAddresses(),
                                        const Spacer(),
                                        DexInProgressResumeBtn(
                                          currentStep: farmWithdraw.currentStep,
                                          isProcessInProgress:
                                              farmWithdraw.isProcessInProgress,
                                          onPressed: () async {
                                            ref
                                                .read(
                                                  FarmWithdrawFormProvider
                                                      .farmWithdrawForm
                                                      .notifier,
                                                )
                                                .setResumeProcess(true);

                                            if (!context.mounted) return;
                                            await ref
                                                .read(
                                                  FarmWithdrawFormProvider
                                                      .farmWithdrawForm
                                                      .notifier,
                                                )
                                                .withdraw(context, ref);
                                          },
                                          failure: farmWithdraw.failure,
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
                                  farmWithdraw.isProcessInProgress,
                              warningCloseLabel: farmWithdraw
                                          .isProcessInProgress ==
                                      true
                                  ? AppLocalizations.of(context)!
                                      .farmWithdrawProcessInterruptionWarning
                                  : '',
                              warningCloseFunction: () {
                                ref.read(
                                  FarmWithdrawFormProvider
                                      .farmWithdrawForm.notifier,
                                )
                                  ..setProcessInProgress(false)
                                  ..setFailure(null)
                                  ..setFarmWithdrawOk(false)
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
