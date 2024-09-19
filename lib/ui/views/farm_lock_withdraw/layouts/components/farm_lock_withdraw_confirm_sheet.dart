/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_lock_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/components/farm_lock_withdraw_confirm_infos.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/components/farm_lock_withdraw_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockWithdrawConfirmSheet extends ConsumerStatefulWidget {
  const FarmLockWithdrawConfirmSheet({super.key});

  @override
  ConsumerState<FarmLockWithdrawConfirmSheet> createState() =>
      FarmLockWithdrawConfirmSheetState();
}

class FarmLockWithdrawConfirmSheetState
    extends ConsumerState<FarmLockWithdrawConfirmSheet> {
  bool consentChecked = false;
  @override
  Widget build(BuildContext context) {
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.farmLockWithdrawConfirmTitle,
            onPressed: () {
              ref
                  .read(
                    farmLockWithdrawFormNotifierProvider.notifier,
                  )
                  .setFarmLockWithdrawProcessStep(
                    aedappfm.ProcessStep.form,
                  );
            },
          ),
          const SizedBox(height: 15),
          const FarmLockWithdrawConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (farmLockWithdraw.consentDateTime == null)
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
              consentDateTime: farmLockWithdraw.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_farm_withdraw,
            disabled:
                !consentChecked && farmLockWithdraw.consentDateTime == null,
            onPressed: () async {
              final farmLockWithdrawNotifier = ref.read(
                farmLockWithdrawFormNotifierProvider.notifier,
              );
              unawaited(farmLockWithdrawNotifier.withdraw(context));
              await FarmLockWithdrawInProgressPopup.getDialog(
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
