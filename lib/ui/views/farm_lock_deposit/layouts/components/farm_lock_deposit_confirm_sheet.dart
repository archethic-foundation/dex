/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_infos.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmLockDepositConfirmSheet extends ConsumerStatefulWidget {
  const FarmLockDepositConfirmSheet({super.key});

  @override
  ConsumerState<FarmLockDepositConfirmSheet> createState() =>
      FarmLockDepositConfirmSheetState();
}

class FarmLockDepositConfirmSheetState
    extends ConsumerState<FarmLockDepositConfirmSheet> {
  bool consentChecked = false;
  bool warningChecked = false;

  @override
  void initState() {
    final farmLockDeposit =
        ref.read(FarmLockDepositFormProvider.farmLockDepositForm);
    if (farmLockDeposit.farmLockDepositDuration ==
        FarmLockDepositDurationType.flexible) {
      warningChecked = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final farmLockDeposit =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);
    if (farmLockDeposit.pool == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!
                .aeswap_farmLockDepositConfirmTitle,
            onPressed: farmLockDeposit.pool == null
                ? null
                : () {
                    ref
                        .read(
                          FarmLockDepositFormProvider
                              .farmLockDepositForm.notifier,
                        )
                        .setFarmLockDepositProcessStep(
                          aedappfm.ProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmLockDepositConfirmInfos(),
          if (farmLockDeposit.farmLockDepositDuration !=
              FarmLockDepositDurationType.flexible)
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Wrap(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .aeswap_farmLockDepositConfirmCheckBoxUnderstand,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyMedium!,
                                ),
                                color: aedappfm
                                    .ArchethicThemeBase.systemWarning500,
                              ),
                        ),
                      ],
                    ),
                    dense: true,
                    value: warningChecked,
                    onChanged: (newValue) {
                      setState(() {
                        warningChecked = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    subtitle: InkWell(
                      onTap: () async {
                        final uri = Uri.parse(kURIFarmLockFarmTuto);
                        if (!await canLaunchUrl(uri)) return;
                        await launchUrl(uri);
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .aeswap_farmLockDepositConfirmMoreInfo,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyMedium!,
                              ),
                              color:
                                  aedappfm.ArchethicThemeBase.systemWarning500,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (farmLockDeposit.consentDateTime == null)
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
              consentDateTime: farmLockDeposit.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn:
                AppLocalizations.of(context)!.aeswap_btn_confirm_farm_add_lock,
            disabled: !warningChecked ||
                (!consentChecked && farmLockDeposit.consentDateTime == null),
            onPressed: () async {
              final farmLockDepositNotifier = ref.read(
                FarmLockDepositFormProvider.farmLockDepositForm.notifier,
              );
              unawaited(farmLockDepositNotifier.lock(context, ref));
              await FarmLockDepositInProgressPopup.getDialog(
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
