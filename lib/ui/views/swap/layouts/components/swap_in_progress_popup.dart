/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_circular_step_progress_indicator.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/in_progress_banner.dart';
import 'package:aedex/ui/views/util/components/popup_close_button.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 300,
                                    ),
                                    child: Card(
                                      color: Colors.transparent,
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: WaveWidget(
                                        config: CustomConfig(
                                          gradients: [
                                            [
                                              ArchethicThemeBase.blue800
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple800
                                                  .withOpacity(0.1),
                                            ],
                                            [
                                              ArchethicThemeBase.blue500
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple500
                                                  .withOpacity(0.1),
                                            ],
                                            [
                                              ArchethicThemeBase.blue300
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple300
                                                  .withOpacity(0.1),
                                            ],
                                            [
                                              ArchethicThemeBase.blue200
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple200
                                                  .withOpacity(0.1),
                                            ]
                                          ],
                                          durations: [
                                            35000,
                                            19440,
                                            10800,
                                            6000,
                                          ],
                                          heightPercentages: [
                                            0.20,
                                            0.23,
                                            0.25,
                                            0.30,
                                          ],
                                          gradientBegin: Alignment.bottomLeft,
                                          gradientEnd: Alignment.topRight,
                                        ),
                                        size: Size.infinite,
                                        waveAmplitude: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const SwapCircularStepProgressIndicator(),
                                        InProgressBanner(
                                          stepLabel: swap.isProcessInProgress
                                              ? AppLocalizations.of(context)!
                                                  .swapProcessInProgress
                                              : '',
                                          infoMessage: swap
                                                      .walletConfirmation ==
                                                  true
                                              ? AppLocalizations.of(context)!
                                                  .swapInProgressConfirmAEWallet
                                              : swap.swapOk == true
                                                  ? AppLocalizations.of(
                                                      context,
                                                    )!
                                                      .swapSuccessInfo
                                                  : '',
                                          errorMessage: swap.failure != null
                                              ? FailureMessage(
                                                  context: context,
                                                  failure: swap.failure,
                                                ).getMessage()
                                              : '',
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
                                ref.read(
                                  SwapFormProvider.swapForm.notifier,
                                )
                                  ..setProcessInProgress(false)
                                  ..setFailure(null)
                                  ..setSwapOk(false)
                                  ..setWalletConfirmation(false);
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
