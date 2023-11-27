/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/state.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_infos.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm_back.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveConfirmSheet extends ConsumerWidget {
  const LiquidityRemoveConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.lpToken == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DexButtonConfirmBack(
            title: AppLocalizations.of(context)!.liquidityRemoveConfirmTitle,
            onPressed: liquidityRemove.lpToken == null
                ? null
                : () {
                    ref
                        .read(
                          LiquidityRemoveFormProvider
                              .liquidityRemoveForm.notifier,
                        )
                        .setLiquidityRemoveProcessStep(
                          LiquidityRemoveProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: LiquidityRemoveConfirmInfos(),
              ),
              if (liquidityRemove.token1 != null)
                PoolInfoCard(
                  poolGenesisAddress: liquidityRemove.poolGenesisAddress,
                  tokenAddressRatioPrimary:
                      liquidityRemove.token1!.address == null
                          ? 'UCO'
                          : liquidityRemove.token1!.address!,
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          DexButtonConfirm(
            labelBtn:
                AppLocalizations.of(context)!.btn_confirm_liquidity_remove,
            onPressed: () async {
              final liquidityRemoveNotifier = ref.read(
                LiquidityRemoveFormProvider.liquidityRemoveForm.notifier,
              );
              unawaited(liquidityRemoveNotifier.remove(context, ref));
              await LiquidityRemoveInProgressPopup.getDialog(
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
