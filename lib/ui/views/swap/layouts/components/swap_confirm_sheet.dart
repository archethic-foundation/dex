/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_confirm_infos.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/low_uco_warning_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapConfirmSheet extends ConsumerStatefulWidget {
  const SwapConfirmSheet({super.key});

  @override
  ConsumerState<SwapConfirmSheet> createState() => SwapConfirmSheetState();
}

class SwapConfirmSheetState extends ConsumerState<SwapConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final swap = ref.watch(swapFormNotifierProvider);
    if (swap.tokenToSwap == null || swap.tokenSwapped == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.liquidityAddConfirmTitle,
            onPressed: swap.tokenToSwap == null
                ? null
                : () {
                    ref.read(
                      swapFormNotifierProvider.notifier,
                    )
                      ..setSwapProcessStep(
                        aedappfm.ProcessStep.form,
                      )
                      ..setMessageMaxHalfUCO(false);
                  },
          ),
          const SizedBox(height: 15),
          const SwapConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (swap.consentDateTime == null)
            aedappfm.ConsentToCheck(
              consentChecked: consentChecked,
              onToggleConsent: (newValue) {
                setState(() {
                  consentChecked = newValue!;
                });
              },
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            )
          else
            aedappfm.ConsentAlready(
              consentDateTime: swap.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_swap,
            disabled: !consentChecked && swap.consentDateTime == null,
            onPressed: () async {
              if (swap.tokenToSwap != null &&
                  swap.tokenToSwap!.isUCO &&
                  (Decimal.parse(
                                swap.tokenToSwapBalance.toString(),
                              ) -
                              Decimal.parse(swap.tokenToSwapAmount.toString()))
                          .toDouble() <
                      kLowUCOWarningValue) {
                final result = await LowUCOWarningPopup.getDialog(context);
                if (result != null && result == false) {
                  return;
                }
              }

              final swapNotifier = ref.read(swapFormNotifierProvider.notifier);
              unawaited(swapNotifier.swap(AppLocalizations.of(context)!));
              await SwapInProgressPopup.getDialog(
                context,
                ref,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
