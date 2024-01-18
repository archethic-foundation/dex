/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/bloc/state.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_confirm_infos.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimConfirmSheet extends ConsumerWidget {
  const FarmClaimConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    if (farmClaim.dexFarmInfos == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DexButtonConfirmBack(
            title: AppLocalizations.of(context)!.farmClaimConfirmTitle,
            onPressed: farmClaim.dexFarmInfos == null
                ? null
                : () {
                    ref
                        .read(
                          FarmClaimFormProvider.farmClaimForm.notifier,
                        )
                        .setFarmClaimProcessStep(
                          FarmClaimProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmClaimConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          DexButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_farm_claim,
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
