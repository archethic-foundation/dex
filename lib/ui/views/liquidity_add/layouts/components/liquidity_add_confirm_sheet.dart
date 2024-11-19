/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aedex/application/low_uco_in_dollars_warning_value.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_confirm_infos.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/low_uco_warning_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddConfirmSheet extends ConsumerStatefulWidget {
  const LiquidityAddConfirmSheet({super.key});

  @override
  ConsumerState<LiquidityAddConfirmSheet> createState() =>
      LiquidityAddConfirmSheetState();
}

class LiquidityAddConfirmSheetState
    extends ConsumerState<LiquidityAddConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);
    if (liquidityAdd.token1 == null) {
      return const SizedBox.shrink();
    }
    final lowUCOInDollarsWarningValue =
        ref.watch(lowUCOInDollarsWarningValueProvider);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.liquidityAddConfirmTitle,
            onPressed: liquidityAdd.token1 == null
                ? null
                : () {
                    ref.read(
                      liquidityAddFormNotifierProvider.notifier,
                    )
                      ..setLiquidityAddProcessStep(
                        aedappfm.ProcessStep.form,
                      )
                      ..setMessageMaxHalfUCO(false);
                  },
          ),
          const SizedBox(height: 15),
          const LiquidityAddConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (liquidityAdd.consentDateTime == null)
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
              consentDateTime: liquidityAdd.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_liquidity_add,
            disabled: !consentChecked && liquidityAdd.consentDateTime == null,
            onPressed: () async {
              if (liquidityAdd.token1 != null &&
                  liquidityAdd.token1!.isUCO &&
                  (Decimal.parse(
                                liquidityAdd.token1Balance.toString(),
                              ) -
                              Decimal.parse(
                                liquidityAdd.token1Amount.toString(),
                              ))
                          .toDouble() <
                      lowUCOInDollarsWarningValue) {
                final result = await LowUCOWarningPopup.getDialog(context);
                if (result != null && result == false) {
                  return;
                }
              }
              if (liquidityAdd.token2 != null &&
                  liquidityAdd.token2!.isUCO &&
                  (Decimal.parse(
                                liquidityAdd.token2Balance.toString(),
                              ) -
                              Decimal.parse(
                                liquidityAdd.token2Amount.toString(),
                              ))
                          .toDouble() <
                      lowUCOInDollarsWarningValue) {
                if (context.mounted) {
                  final result = await LowUCOWarningPopup.getDialog(context);
                  if (result != null && result == false) {
                    return;
                  }
                }
              }

              final liquidityAddNotifier =
                  ref.read(liquidityAddFormNotifierProvider.notifier);
              if (context.mounted) {
                unawaited(
                  liquidityAddNotifier.add(AppLocalizations.of(context)!),
                );
                await LiquidityAddInProgressPopup.getDialog(
                  context,
                  ref,
                );
              }
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
