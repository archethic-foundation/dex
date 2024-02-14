/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aedex/domain/usecases/withdraw_farm.usecase.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_final_amount.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_circular_step_progress_indicator.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_current_step.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_infos_banner.dart';
import 'package:aedex/ui/views/util/components/dex_in_progress_resume_btn.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                                            DexInProgressCircularStepProgressIndicator(
                                              currentStep:
                                                  farmWithdraw.currentStep,
                                              totalSteps: 3,
                                              isProcessInProgress: farmWithdraw
                                                  .isProcessInProgress,
                                              failure: farmWithdraw.failure,
                                            ),
                                            DexInProgressCurrentStep(
                                              steplabel: WithdrawFarmCase()
                                                  .getAEStepLabel(
                                                context,
                                                farmWithdraw.currentStep,
                                              ),
                                            ),
                                            DexInProgressInfosBanner(
                                              isProcessInProgress: farmWithdraw
                                                  .isProcessInProgress,
                                              walletConfirmation: farmWithdraw
                                                  .walletConfirmation,
                                              failure: farmWithdraw.failure,
                                              inProgressTxt: AppLocalizations
                                                      .of(
                                                context,
                                              )!
                                                  .farmWithdrawProcessInProgress,
                                              walletConfirmationTxt:
                                                  AppLocalizations.of(context)!
                                                      .farmWithdrawInProgressConfirmAEWallet,
                                              successTxt:
                                                  AppLocalizations.of(context)!
                                                      .farmWithdrawSuccessInfo,
                                            ),
                                            const FarmWithdrawInProgressTxAddresses(),
                                            if (farmWithdraw.transactionWithdrawFarm != null &&
                                                farmWithdraw
                                                        .transactionWithdrawFarm!
                                                        .address !=
                                                    null &&
                                                farmWithdraw
                                                        .transactionWithdrawFarm!
                                                        .address!
                                                        .address !=
                                                    null)
                                              FarmWithdrawFinalAmount(
                                                address: farmWithdraw
                                                    .transactionWithdrawFarm!
                                                    .address!
                                                    .address!,
                                              ),
                                            const Spacer(),
                                            DexInProgressResumeBtn(
                                              currentStep:
                                                  farmWithdraw.currentStep,
                                              isProcessInProgress: farmWithdraw
                                                  .isProcessInProgress,
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
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: aedappfm.PopupCloseButton(
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
                                      navigationIndexMainScreenProvider
                                          .notifier,
                                    )
                                    .state = 2;
                                context.go(FarmListSheet.routerPage);
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
