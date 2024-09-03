/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_confirm_infos.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositConfirmSheet extends ConsumerStatefulWidget {
  const FarmDepositConfirmSheet({super.key});

  @override
  ConsumerState<FarmDepositConfirmSheet> createState() =>
      FarmDepositConfirmSheetState();
}

class FarmDepositConfirmSheetState
    extends ConsumerState<FarmDepositConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.dexFarmInfo == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.aeswap_farmDepositConfirmTitle,
            onPressed: farmDeposit.dexFarmInfo == null
                ? null
                : () {
                    ref
                        .read(
                          FarmDepositFormProvider.farmDepositForm.notifier,
                        )
                        .setFarmDepositProcessStep(
                          aedappfm.ProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmDepositConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (farmDeposit.consentDateTime == null)
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
              consentDateTime: farmDeposit.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn:
                AppLocalizations.of(context)!.aeswap_btn_confirm_farm_deposit,
            disabled: !consentChecked && farmDeposit.consentDateTime == null,
            onPressed: () async {
              final farmDepositNotifier =
                  ref.read(FarmDepositFormProvider.farmDepositForm.notifier);
              unawaited(farmDepositNotifier.deposit(context, ref));
              await FarmDepositInProgressPopup.getDialog(
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
