/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_confirm_infos.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmLockLevelUpConfirmSheet extends ConsumerStatefulWidget {
  const FarmLockLevelUpConfirmSheet({super.key});

  @override
  ConsumerState<FarmLockLevelUpConfirmSheet> createState() =>
      FarmLockLevelUpConfirmSheetState();
}

class FarmLockLevelUpConfirmSheetState
    extends ConsumerState<FarmLockLevelUpConfirmSheet> {
  bool consentChecked = false;
  bool warningChecked = false;

  @override
  void initState() {
    final farmLockLevelUp = ref.read(farmLockLevelUpFormNotifierProvider);
    if (farmLockLevelUp.farmLockLevelUpDuration ==
        FarmLockDepositDurationType.flexible) {
      warningChecked = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    if (farmLockLevelUp.pool == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.farmLockLevelUpConfirmTitle,
            onPressed: farmLockLevelUp.pool == null
                ? null
                : () {
                    ref
                        .read(
                          farmLockLevelUpFormNotifierProvider.notifier,
                        )
                        .setFarmLockLevelUpProcessStep(
                          aedappfm.ProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmLockLevelUpConfirmInfos(),
          if (farmLockLevelUp.farmLockLevelUpDuration !=
              FarmLockDepositDurationType.flexible)
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Wrap(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .farmLockLevelUpConfirmCheckBoxUnderstand,
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
                            .farmLockLevelUpConfirmMoreInfo,
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
          if (farmLockLevelUp.consentDateTime == null)
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
              consentDateTime: farmLockLevelUp.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_farm_add_lock,
            disabled: !warningChecked ||
                (!consentChecked && farmLockLevelUp.consentDateTime == null),
            onPressed: () async {
              final farmLockLevelUpNotifier = ref.read(
                farmLockLevelUpFormNotifierProvider.notifier,
              );
              unawaited(
                farmLockLevelUpNotifier.lock(AppLocalizations.of(context)!),
              );
              await FarmLockLevelUpInProgressPopup.getDialog(
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
