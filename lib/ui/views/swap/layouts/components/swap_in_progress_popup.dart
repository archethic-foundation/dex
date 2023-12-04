/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/usecases/swap.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_close.dart';
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

class SwapInProgressPopup {
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
                  final swap = ref.watch(SwapFormProvider.swapForm);
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
                                          currentStep: swap.currentStep,
                                          totalSteps: 4,
                                          isProcessInProgress:
                                              swap.isProcessInProgress,
                                          failure: swap.failure,
                                        ),
                                        DexInProgressCurrentStep(
                                          steplabel: SwapCase().getAEStepLabel(
                                            context,
                                            swap.currentStep,
                                          ),
                                        ),
                                        DexInProgressInfosBanner(
                                          isProcessInProgress:
                                              swap.isProcessInProgress,
                                          walletConfirmation:
                                              swap.walletConfirmation,
                                          failure: swap.failure,
                                        ),
                                        const SwapInProgressTxAddresses(),
                                        const Spacer(),
                                        if (swap.failure == null &&
                                            swap.isProcessInProgress == false)
                                          DexButtonClose(
                                            onPressed: () {
                                              ref.invalidate(
                                                SwapFormProvider.swapForm,
                                              );
                                              ref
                                                  .read(
                                                    MainScreenWidgetDisplayedProviders
                                                        .mainScreenWidgetDisplayedProvider
                                                        .notifier,
                                                  )
                                                  .setWidget(
                                                    const SwapSheet(),
                                                    ref,
                                                  );
                                              if (!context.mounted) return;
                                              Navigator.of(context).pop();
                                              return;
                                            },
                                          ),
                                        DexInProgressResumeBtn(
                                          currentStep: swap.currentStep,
                                          isProcessInProgress:
                                              swap.isProcessInProgress,
                                          onPressed: () async {
                                            ref
                                                .read(
                                                  SwapFormProvider
                                                      .swapForm.notifier,
                                                )
                                                .setResumeProcess(true);

                                            if (!context.mounted) return;
                                            await ref
                                                .read(
                                                  SwapFormProvider
                                                      .swapForm.notifier,
                                                )
                                                .swap(context, ref);
                                          },
                                          failure: swap.failure,
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
                              warningCloseWarning: swap.isProcessInProgress,
                              warningCloseLabel:
                                  swap.isProcessInProgress == true
                                      ? AppLocalizations.of(context)!
                                          .swapProcessInterruptionWarning
                                      : '',
                              warningCloseFunction: () {
                                ref.invalidate(
                                  SwapFormProvider.swapForm,
                                );
                                ref
                                    .read(
                                      MainScreenWidgetDisplayedProviders
                                          .mainScreenWidgetDisplayedProvider
                                          .notifier,
                                    )
                                    .setWidget(const SwapSheet(), ref);
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
