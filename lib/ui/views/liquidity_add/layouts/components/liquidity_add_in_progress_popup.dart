/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_circular_step_progress_indicator.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/in_progress_banner.dart';
import 'package:aedex/ui/views/util/components/popup_close_button.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                right: 15,
                                left: 8,
                              ),
                              padding: const EdgeInsets.all(20),
                              height: 300,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const LiquidityAddCircularStepProgressIndicator(),
                                  InProgressBanner(
                                    stepLabel: liquidityAdd.isProcessInProgress
                                        ? AppLocalizations.of(context)!
                                            .liquidityAddProcessInProgress
                                        : '',
                                    infoMessage: liquidityAdd
                                                .walletConfirmation ==
                                            true
                                        ? AppLocalizations.of(context)!
                                            .liquidityAddInProgressConfirmAEWallet
                                        : liquidityAdd.liquidityAddOk == true
                                            ? AppLocalizations.of(context)!
                                                .liquidityAddSuccessInfo
                                            : '',
                                    errorMessage: liquidityAdd.failure != null
                                        ? FailureMessage(
                                            context: context,
                                            failure: liquidityAdd.failure,
                                          ).getMessage()
                                        : '',
                                  ),
                                ],
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