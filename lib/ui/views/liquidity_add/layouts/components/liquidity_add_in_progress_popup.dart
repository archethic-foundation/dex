/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aedex/domain/usecases/add_liquidity.usecase.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
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
import 'package:go_router/go_router.dart';

class LiquidityAddInProgressPopup {
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
                  final liquidityAdd =
                      ref.watch(LiquidityAddFormProvider.liquidityAddForm);
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
                                                  liquidityAdd.currentStep,
                                              totalSteps: 3,
                                              isProcessInProgress: liquidityAdd
                                                  .isProcessInProgress,
                                              failure: liquidityAdd.failure,
                                            ),
                                            DexInProgressCurrentStep(
                                              steplabel: AddLiquidityCase()
                                                  .getAEStepLabel(
                                                context,
                                                liquidityAdd.currentStep,
                                              ),
                                            ),
                                            DexInProgressInfosBanner(
                                              isProcessInProgress: liquidityAdd
                                                  .isProcessInProgress,
                                              walletConfirmation: liquidityAdd
                                                  .walletConfirmation,
                                              failure: liquidityAdd.failure,
                                              inProgressTxt: AppLocalizations
                                                      .of(
                                                context,
                                              )!
                                                  .liquidityAddProcessInProgress,
                                              walletConfirmationTxt:
                                                  AppLocalizations.of(context)!
                                                      .liquidityAddInProgressConfirmAEWallet,
                                              successTxt:
                                                  AppLocalizations.of(context)!
                                                      .liquidityAddSuccessInfo,
                                            ),
                                            const LiquidityAddInProgressTxAddresses(),
                                            const Spacer(),
                                            DexInProgressResumeBtn(
                                              currentStep:
                                                  liquidityAdd.currentStep,
                                              isProcessInProgress: liquidityAdd
                                                  .isProcessInProgress,
                                              onPressed: () async {
                                                ref
                                                    .read(
                                                      LiquidityAddFormProvider
                                                          .liquidityAddForm
                                                          .notifier,
                                                    )
                                                    .setResumeProcess(true);

                                                if (!context.mounted) return;
                                                await ref
                                                    .read(
                                                      LiquidityAddFormProvider
                                                          .liquidityAddForm
                                                          .notifier,
                                                    )
                                                    .add(context, ref);
                                              },
                                              failure: liquidityAdd.failure,
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
                                  liquidityAdd.isProcessInProgress,
                              warningCloseLabel: liquidityAdd
                                          .isProcessInProgress ==
                                      true
                                  ? AppLocalizations.of(context)!
                                      .liquidityAddProcessInterruptionWarning
                                  : '',
                              warningCloseFunction: () {
                                ref.read(
                                  LiquidityAddFormProvider
                                      .liquidityAddForm.notifier,
                                )
                                  ..setProcessInProgress(false)
                                  ..setFailure(null)
                                  ..setLiquidityAddOk(false)
                                  ..setWalletConfirmation(false);
                                ref
                                    .read(
                                      navigationIndexMainScreenProvider
                                          .notifier,
                                    )
                                    .state = 1;
                                context.go(PoolListSheet.routerPage);
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
