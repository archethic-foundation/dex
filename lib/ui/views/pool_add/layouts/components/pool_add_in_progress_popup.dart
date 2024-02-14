/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aedex/domain/usecases/add_pool.usecase.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolAddInProgressPopup {
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
                  final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
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
                                              currentStep: poolAdd.currentStep,
                                              totalSteps: 6,
                                              isProcessInProgress:
                                                  poolAdd.isProcessInProgress,
                                              failure: poolAdd.failure,
                                            ),
                                            aedappfm.InProgressCurrentStep(
                                              steplabel:
                                                  AddPoolCase().getAEStepLabel(
                                                context,
                                                poolAdd.currentStep,
                                              ),
                                            ),
                                            aedappfm.InProgressInfosBanner(
                                              isProcessInProgress:
                                                  poolAdd.isProcessInProgress,
                                              walletConfirmation:
                                                  poolAdd.walletConfirmation,
                                              failure: poolAdd.failure,
                                              inProgressTxt:
                                                  AppLocalizations.of(context)!
                                                      .poolAddProcessInProgress,
                                              walletConfirmationTxt:
                                                  AppLocalizations.of(context)!
                                                      .poolAddInProgressConfirmAEWallet,
                                              successTxt:
                                                  AppLocalizations.of(context)!
                                                      .poolAddSuccessInfo,
                                            ),
                                            const PoolAddInProgressTxAddresses(),
                                            const Spacer(),
                                            aedappfm.InProgressResumeBtn(
                                              currentStep: poolAdd.currentStep,
                                              isProcessInProgress:
                                                  poolAdd.isProcessInProgress,
                                              onPressed: () async {
                                                ref
                                                    .read(
                                                      PoolAddFormProvider
                                                          .poolAddForm.notifier,
                                                    )
                                                    .setResumeProcess(true);

                                                if (!context.mounted) return;
                                                await ref
                                                    .read(
                                                      PoolAddFormProvider
                                                          .poolAddForm.notifier,
                                                    )
                                                    .add(context, ref);
                                              },
                                              failure: poolAdd.failure,
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
                              warningCloseWarning: poolAdd.isProcessInProgress,
                              warningCloseLabel:
                                  poolAdd.isProcessInProgress == true
                                      ? AppLocalizations.of(context)!
                                          .poolAddProcessInterruptionWarning
                                      : '',
                              warningCloseFunction: () {
                                ref.read(
                                  PoolAddFormProvider.poolAddForm.notifier,
                                )
                                  ..setProcessInProgress(false)
                                  ..setFailure(null)
                                  ..setPoolAddOk(false)
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
