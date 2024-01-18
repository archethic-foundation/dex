/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/state.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_confirm_infos.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositConfirmSheet extends ConsumerWidget {
  const FarmDepositConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.dexFarmInfos == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DexButtonConfirmBack(
            title: AppLocalizations.of(context)!.farmDepositConfirmTitle,
            onPressed: farmDeposit.dexFarmInfos == null
                ? null
                : () {
                    ref
                        .read(
                          FarmDepositFormProvider.farmDepositForm.notifier,
                        )
                        .setFarmDepositProcessStep(
                          FarmDepositProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          const FarmDepositConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          DexButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_farm_deposit,
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
