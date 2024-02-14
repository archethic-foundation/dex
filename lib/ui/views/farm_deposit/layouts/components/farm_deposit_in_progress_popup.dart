/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aedex/domain/usecases/deposit_farm.usecase.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_final_amount.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_in_progress_tx_addresses.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                                              currentStep:
                                                  farmDeposit.currentStep,
                                              totalSteps: 3,
                                              isProcessInProgress: farmDeposit
                                                  .isProcessInProgress,
                                              failure: farmDeposit.failure,
                                            ),
                                            aedappfm.InProgressCurrentStep(
                                              steplabel: DepositFarmCase()
                                                  .getAEStepLabel(
                                                context,
                                                farmDeposit.currentStep,
                                              ),
                                            ),
                                            aedappfm.InProgressInfosBanner(
                                              isProcessInProgress: farmDeposit
                                                  .isProcessInProgress,
                                              walletConfirmation: farmDeposit
                                                  .walletConfirmation,
                                              failure: farmDeposit.failure,
                                              inProgressTxt: AppLocalizations
                                                      .of(
                                                context,
                                              )!
                                                  .farmDepositProcessInProgress,
                                              walletConfirmationTxt:
                                                  AppLocalizations.of(context)!
                                                      .farmDepositInProgressConfirmAEWallet,
                                              successTxt:
                                                  AppLocalizations.of(context)!
                                                      .farmDepositSuccessInfo,
                                            ),
                                            const FarmDepositInProgressTxAddresses(),
                                            if (farmDeposit.transactionDepositFarm != null &&
                                                farmDeposit
                                                        .transactionDepositFarm!
                                                        .address !=
                                                    null &&
                                                farmDeposit
                                                        .transactionDepositFarm!
                                                        .address!
                                                        .address !=
                                                    null)
                                              FarmDepositFinalAmount(
                                                address: farmDeposit
                                                    .transactionDepositFarm!
                                                    .address!
                                                    .address!,
                                              ),
                                            const Spacer(),
                                            aedappfm.InProgressResumeBtn(
                                              currentStep:
                                                  farmDeposit.currentStep,
                                              isProcessInProgress: farmDeposit
                                                  .isProcessInProgress,
                                              onPressed: () async {
                                                ref
                                                    .read(
                                                      FarmDepositFormProvider
                                                          .farmDepositForm
                                                          .notifier,
                                                    )
                                                    .setResumeProcess(true);

                                                if (!context.mounted) return;
                                                await ref
                                                    .read(
                                                      FarmDepositFormProvider
                                                          .farmDepositForm
                                                          .notifier,
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
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: aedappfm.PopupCloseButton(
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
