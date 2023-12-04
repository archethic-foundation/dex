/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/usecases/remove_liquidity.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
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

class LiquidityRemoveInProgressPopup {
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
                  final liquidityRemove = ref
                      .watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
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
                                          currentStep:
                                              liquidityRemove.currentStep,
                                          totalSteps: 3,
                                          isProcessInProgress: liquidityRemove
                                              .isProcessInProgress,
                                          failure: liquidityRemove.failure,
                                        ),
                                        DexInProgressCurrentStep(
                                          steplabel: RemoveLiquidityCase()
                                              .getAEStepLabel(
                                            context,
                                            liquidityRemove.currentStep,
                                          ),
                                        ),
                                        DexInProgressInfosBanner(
                                          isProcessInProgress: liquidityRemove
                                              .isProcessInProgress,
                                          walletConfirmation: liquidityRemove
                                              .walletConfirmation,
                                          failure: liquidityRemove.failure,
                                        ),
                                        const LiquidityRemoveInProgressTxAddresses(),
                                        const Spacer(),
                                        DexInProgressResumeBtn(
                                          currentStep:
                                              liquidityRemove.currentStep,
                                          isProcessInProgress: liquidityRemove
                                              .isProcessInProgress,
                                          onPressed: () async {
                                            ref
                                                .read(
                                                  LiquidityRemoveFormProvider
                                                      .liquidityRemoveForm
                                                      .notifier,
                                                )
                                                .setResumeProcess(true);

                                            if (!context.mounted) return;
                                            await ref
                                                .read(
                                                  LiquidityRemoveFormProvider
                                                      .liquidityRemoveForm
                                                      .notifier,
                                                )
                                                .remove(context, ref);
                                          },
                                          failure: liquidityRemove.failure,
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
                                  liquidityRemove.isProcessInProgress,
                              warningCloseLabel: liquidityRemove
                                          .isProcessInProgress ==
                                      true
                                  ? AppLocalizations.of(context)!
                                      .liquidityRemoveProcessInterruptionWarning
                                  : '',
                              warningCloseFunction: () {
                                ref.read(
                                  LiquidityRemoveFormProvider
                                      .liquidityRemoveForm.notifier,
                                )
                                  ..setProcessInProgress(false)
                                  ..setFailure(null)
                                  ..setLiquidityRemoveOk(false)
                                  ..setWalletConfirmation(false);
                                ref
                                    .read(
                                      MainScreenWidgetDisplayedProviders
                                          .mainScreenWidgetDisplayedProvider
                                          .notifier,
                                    )
                                    .setWidget(const PoolListSheet(), ref);
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
