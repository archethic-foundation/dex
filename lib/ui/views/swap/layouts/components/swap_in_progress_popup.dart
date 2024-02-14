/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aedex/domain/usecases/swap.usecase.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_final_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                          aedappfm.ArchethicScrollbar(
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
                                  width: aedappfm
                                      .AppThemeBase.sizeBoxComponentWidth,
                                  decoration: BoxDecoration(
                                    color:
                                        aedappfm.AppThemeBase.sheetBackground,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: aedappfm.AppThemeBase.sheetBorder,
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
                                          child: aedappfm.PopupWaves(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            aedappfm
                                                .InProgressCircularStepProgressIndicator(
                                              currentStep: swap.currentStep,
                                              totalSteps: 4,
                                              isProcessInProgress:
                                                  swap.isProcessInProgress,
                                              failure: swap.failure,
                                            ),
                                            aedappfm.InProgressCurrentStep(
                                              steplabel:
                                                  SwapCase().getAEStepLabel(
                                                context,
                                                swap.currentStep,
                                              ),
                                            ),
                                            aedappfm.InProgressInfosBanner(
                                              isProcessInProgress:
                                                  swap.isProcessInProgress,
                                              walletConfirmation:
                                                  swap.walletConfirmation,
                                              failure: swap.failure,
                                              inProgressTxt:
                                                  AppLocalizations.of(context)!
                                                      .swapProcessInProgress,
                                              walletConfirmationTxt:
                                                  AppLocalizations.of(context)!
                                                      .swapInProgressConfirmAEWallet,
                                              successTxt:
                                                  AppLocalizations.of(context)!
                                                      .swapSuccessInfo,
                                            ),
                                            const SwapInProgressTxAddresses(),
                                            if (swap.recoveryTransactionSwap !=
                                                    null &&
                                                swap.recoveryTransactionSwap!
                                                        .address !=
                                                    null &&
                                                swap.recoveryTransactionSwap!
                                                        .address!.address !=
                                                    null)
                                              SwapFinalAmount(
                                                address: swap
                                                    .recoveryTransactionSwap!
                                                    .address!
                                                    .address!,
                                              ),
                                            const Spacer(),
                                            aedappfm.InProgressResumeBtn(
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
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: aedappfm.PopupCloseButton(
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
                                      navigationIndexMainScreenProvider
                                          .notifier,
                                    )
                                    .state = 0;
                                context.go(SwapSheet.routerPage);
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
