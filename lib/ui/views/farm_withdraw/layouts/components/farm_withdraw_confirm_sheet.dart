/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/state.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_confirm_infos.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawConfirmSheet extends ConsumerWidget {
  const FarmWithdrawConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.dexFarmInfos == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DexButtonConfirmBack(
            title: AppLocalizations.of(context)!.farmWithdrawConfirmTitle,
            onPressed: farmWithdraw.dexFarmInfos == null
                ? null
                : () {
                    ref
                        .read(
                          FarmWithdrawFormProvider.farmWithdrawForm.notifier,
                        )
                        .setFarmWithdrawProcessStep(
                          FarmWithdrawProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmWithdrawConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          DexButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_farm_withdraw,
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
