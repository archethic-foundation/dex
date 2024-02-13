/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/usecases/claim_farm.usecase.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_final_amount.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_in_progress_tx_addresses.dart';
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

class FarmClaimInProgressPopup {
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
                  final farmClaim =
                      ref.watch(FarmClaimFormProvider.farmClaimForm);
                  return Scaffold(
                    backgroundColor: Colors.transparent.withAlpha(120),
                    body: AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Stack(
                        children: <Widget>[
                          ArchethicScrollbar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 30,
                                    right: 15,
                                    left: 8,
                                  ),
                                  height: 400,
                                  width: DexThemeBase.sizeBoxComponentWidth,
                                  decoration: BoxDecoration(
                                    color: DexThemeBase.sheetBackground,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: DexThemeBase.sheetBorder,
                                    ),
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
                                              currentStep:
                                                  farmClaim.currentStep,
                                              totalSteps: 3,
                                              isProcessInProgress:
                                                  farmClaim.isProcessInProgress,
                                              failure: farmClaim.failure,
                                            ),
                                            DexInProgressCurrentStep(
                                              steplabel: ClaimFarmCase()
                                                  .getAEStepLabel(
                                                context,
                                                farmClaim.currentStep,
                                              ),
                                            ),
                                            DexInProgressInfosBanner(
                                              isProcessInProgress:
                                                  farmClaim.isProcessInProgress,
                                              walletConfirmation:
                                                  farmClaim.walletConfirmation,
                                              failure: farmClaim.failure,
                                              inProgressTxt: AppLocalizations
                                                      .of(
                                                context,
                                              )!
                                                  .farmClaimProcessInProgress,
                                              walletConfirmationTxt:
                                                  AppLocalizations.of(context)!
                                                      .farmClaimInProgressConfirmAEWallet,
                                              successTxt:
                                                  AppLocalizations.of(context)!
                                                      .farmClaimSuccessInfo,
                                            ),
                                            const FarmClaimInProgressTxAddresses(),
                                            if (farmClaim.transactionClaimFarm != null &&
                                                farmClaim.transactionClaimFarm!
                                                        .address !=
                                                    null &&
                                                farmClaim.transactionClaimFarm!
                                                        .address!.address !=
                                                    null)
                                              FarmClaimFinalAmount(
                                                address: farmClaim
                                                    .transactionClaimFarm!
                                                    .address!
                                                    .address!,
                                              ),
                                            const Spacer(),
                                            DexInProgressResumeBtn(
                                              currentStep:
                                                  farmClaim.currentStep,
                                              isProcessInProgress:
                                                  farmClaim.isProcessInProgress,
                                              onPressed: () async {
                                                ref
                                                    .read(
                                                      FarmClaimFormProvider
                                                          .farmClaimForm
                                                          .notifier,
                                                    )
                                                    .setResumeProcess(true);

                                                if (!context.mounted) return;
                                                await ref
                                                    .read(
                                                      FarmClaimFormProvider
                                                          .farmClaimForm
                                                          .notifier,
                                                    )
                                                    .claim(context, ref);
                                              },
                                              failure: farmClaim.failure,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: PopupCloseButton(
                              warningCloseWarning:
                                  farmClaim.isProcessInProgress,
                              warningCloseLabel:
                                  farmClaim.isProcessInProgress == true
                                      ? AppLocalizations.of(context)!
                                          .farmClaimProcessInterruptionWarning
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
