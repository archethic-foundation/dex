/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_infos.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveConfirmSheet extends ConsumerStatefulWidget {
  const LiquidityRemoveConfirmSheet({super.key});

  @override
  ConsumerState<LiquidityRemoveConfirmSheet> createState() =>
      LiquidityRemoveConfirmSheetState();
}

class LiquidityRemoveConfirmSheetState
    extends ConsumerState<LiquidityRemoveConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    if (liquidityRemove.lpToken == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.liquidityRemoveConfirmTitle,
            onPressed: liquidityRemove.lpToken == null
                ? null
                : () {
                    ref
                        .read(
                          liquidityRemoveFormNotifierProvider.notifier,
                        )
                        .setLiquidityRemoveProcessStep(
                          aedappfm.ProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const LiquidityRemoveConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (liquidityRemove.consentDateTime == null)
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
              consentDateTime: liquidityRemove.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn:
                AppLocalizations.of(context)!.btn_confirm_liquidity_remove,
            disabled:
                !consentChecked && liquidityRemove.consentDateTime == null,
            onPressed: () async {
              final liquidityRemoveNotifier = ref.read(
                liquidityRemoveFormNotifierProvider.notifier,
              );
              unawaited(liquidityRemoveNotifier.remove(context));
              await LiquidityRemoveInProgressPopup.getDialog(
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
