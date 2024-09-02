/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_confirm_infos.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawConfirmSheet extends ConsumerStatefulWidget {
  const FarmWithdrawConfirmSheet({super.key});

  @override
  ConsumerState<FarmWithdrawConfirmSheet> createState() =>
      FarmWithdrawConfirmSheetState();
}

class FarmWithdrawConfirmSheetState
    extends ConsumerState<FarmWithdrawConfirmSheet> {
  bool consentChecked = false;
  @override
  Widget build(BuildContext context) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.dexFarmInfo == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title:
                AppLocalizations.of(context)!.aeswap_farmWithdrawConfirmTitle,
            onPressed: farmWithdraw.dexFarmInfo == null
                ? null
                : () {
                    ref
                        .read(
                          FarmWithdrawFormProvider.farmWithdrawForm.notifier,
                        )
                        .setFarmWithdrawProcessStep(
                          aedappfm.ProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmWithdrawConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (farmWithdraw.consentDateTime == null)
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
              consentDateTime: farmWithdraw.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn:
                AppLocalizations.of(context)!.aeswap_btn_confirm_farm_withdraw,
            disabled: !consentChecked && farmWithdraw.consentDateTime == null,
            onPressed: () async {
              final farmWithdrawNotifier =
                  ref.read(FarmWithdrawFormProvider.farmWithdrawForm.notifier);
              unawaited(farmWithdrawNotifier.withdraw(context, ref));
              await FarmWithdrawInProgressPopup.getDialog(
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
