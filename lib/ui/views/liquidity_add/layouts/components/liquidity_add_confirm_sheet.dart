/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_confirm_infos.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null) {
      return const SizedBox.shrink();
    }

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
                      LiquidityAddFormProvider.liquidityAddForm.notifier,
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
              final liquidityAddNotifier =
                  ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier);
              unawaited(liquidityAddNotifier.add(context, ref));
              await LiquidityAddInProgressPopup.getDialog(
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
