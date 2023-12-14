/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_confirm_infos.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm_back.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapConfirmSheet extends ConsumerWidget {
  const SwapConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.tokenToSwap == null || swap.tokenSwapped == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DexButtonConfirmBack(
            title: AppLocalizations.of(context)!.liquidityAddConfirmTitle,
            onPressed: swap.tokenToSwap == null
                ? null
                : () {
                    ref
                        .read(
                          SwapFormProvider.swapForm.notifier,
                        )
                        .setSwapProcessStep(
                          SwapProcessStep.form,
                        );
                  },
          ),
          const SizedBox(height: 15),
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: SwapConfirmInfos(),
              ),
              if (swap.tokenToSwap != null)
                PoolInfoCard(
                  poolGenesisAddress: swap.poolGenesisAddress,
                  tokenAddressRatioPrimary: swap.tokenToSwap!.address == null
                      ? 'UCO'
                      : swap.tokenToSwap!.address!,
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          DexButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_swap,
            onPressed: () async {
              final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);
              unawaited(swapNotifier.swap(context, ref));
              await SwapInProgressPopup.getDialog(
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
