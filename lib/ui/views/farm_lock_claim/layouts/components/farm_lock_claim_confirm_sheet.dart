/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_lock_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_claim/layouts/components/farm_lock_claim_confirm_infos.dart';
import 'package:aedex/ui/views/farm_lock_claim/layouts/components/farm_lock_claim_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockClaimConfirmSheet extends ConsumerStatefulWidget {
  const FarmLockClaimConfirmSheet({super.key});

  @override
  ConsumerState<FarmLockClaimConfirmSheet> createState() =>
      FarmLockClaimConfirmSheetState();
}

class FarmLockClaimConfirmSheetState
    extends ConsumerState<FarmLockClaimConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final farmLockClaim =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm);
    if (farmLockClaim.rewardAmount == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title:
                AppLocalizations.of(context)!.aeswap_farmLockClaimConfirmTitle,
            onPressed: farmLockClaim.rewardAmount == null
                ? null
                : () {
                    ref
                        .read(
                          FarmLockClaimFormProvider.farmLockClaimForm.notifier,
                        )
                        .setFarmLockClaimProcessStep(
                          aedappfm.ProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmLockClaimConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (farmLockClaim.consentDateTime == null)
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
              consentDateTime: farmLockClaim.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!
                .aeswap_btn_confirm_farm_lock_claim,
            disabled: !consentChecked && farmLockClaim.consentDateTime == null,
            onPressed: () async {
              final farmLockClaimNotifier = ref
                  .read(FarmLockClaimFormProvider.farmLockClaimForm.notifier);
              unawaited(farmLockClaimNotifier.claim(context, ref));
              await FarmLockClaimInProgressPopup.getDialog(
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
