/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_confirm_infos.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_in_progress_popup.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmSheet extends ConsumerStatefulWidget {
  const PoolAddConfirmSheet({super.key});

  @override
  ConsumerState<PoolAddConfirmSheet> createState() =>
      PoolAddConfirmSheetState();
}

class PoolAddConfirmSheetState extends ConsumerState<PoolAddConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final poolAdd = ref.watch(poolAddFormNotifierProvider);
    if (poolAdd.token1 == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.poolAddConfirmTitle,
            onPressed: poolAdd.token1 == null
                ? null
                : () {
                    ref.read(poolAddFormNotifierProvider.notifier)
                      ..setPoolAddProcessStep(
                        aedappfm.ProcessStep.form,
                      )
                      ..setMessageMaxHalfUCO(false);
                  },
          ),
          const SizedBox(height: 15),
          const PoolAddConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          if (poolAdd.consentDateTime == null)
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
              consentDateTime: poolAdd.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_pool_add,
            disabled: !consentChecked && poolAdd.consentDateTime == null,
            onPressed: () async {
              final poolAddNotifier =
                  ref.read(poolAddFormNotifierProvider.notifier);
              unawaited(poolAddNotifier.add(AppLocalizations.of(context)!));
              await PoolAddInProgressPopup.getDialog(
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
