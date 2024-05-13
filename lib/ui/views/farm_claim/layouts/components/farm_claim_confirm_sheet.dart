/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_confirm_infos.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimConfirmSheet extends ConsumerStatefulWidget {
  const FarmClaimConfirmSheet({super.key});

  @override
  ConsumerState<FarmClaimConfirmSheet> createState() =>
      FarmClaimConfirmSheetState();
}

class FarmClaimConfirmSheetState extends ConsumerState<FarmClaimConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    if (farmClaim.rewardAmount == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.farmClaimConfirmTitle,
            onPressed: farmClaim.rewardAmount == null
                ? null
                : () {
                    ref
                        .read(
                          FarmClaimFormProvider.farmClaimForm.notifier,
                        )
                        .setFarmClaimProcessStep(
                          aedappfm.ProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmClaimConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (farmClaim.consentDateTime == null)
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
              consentDateTime: farmClaim.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_farm_claim,
            disabled: !consentChecked && farmClaim.consentDateTime == null,
            onPressed: () async {
              final farmClaimNotifier =
                  ref.read(FarmClaimFormProvider.farmClaimForm.notifier);
              unawaited(farmClaimNotifier.claim(context, ref));
              await FarmClaimInProgressPopup.getDialog(
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
