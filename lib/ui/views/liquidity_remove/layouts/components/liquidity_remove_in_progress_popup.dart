/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_circular_step_progress_indicator.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/in_progress_banner.dart';
import 'package:aedex/ui/views/util/components/popup_close_button.dart';
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
                                  const LiquidityRemoveCircularStepProgressIndicator(),
                                  InProgressBanner(
                                    stepLabel: liquidityRemove
                                            .isProcessInProgress
                                        ? AppLocalizations.of(context)!
                                            .liquidityRemoveProcessInProgress
                                        : '',
                                    infoMessage: liquidityRemove
                                                .walletConfirmation ==
                                            true
                                        ? AppLocalizations.of(context)!
                                            .liquidityRemoveInProgressConfirmAEWallet
                                        : liquidityRemove.liquidityRemoveOk ==
                                                true
                                            ? AppLocalizations.of(context)!
                                                .liquidityRemoveSuccessInfo
                                            : '',
                                    errorMessage: liquidityRemove.failure !=
                                            null
                                        ? FailureMessage(
                                            context: context,
                                            failure: liquidityRemove.failure,
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
