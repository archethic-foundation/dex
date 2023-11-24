/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm_back.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
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

    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: DexButtonConfirmBack(
              title: AppLocalizations.of(context)!.poolAddConfirmTitle,
              onPressed: swap.tokenToSwap == null
                  ? null
                  : () {
                      ref
                          .read(SwapFormProvider.swapForm.notifier)
                          .setSwapProcessStep(
                            SwapProcessStep.form,
                          );
                    },
            ),
          ),
          Text(
            AppLocalizations.of(context)!.swap_confirmation_you_pay,
          ),
          Text(
            '${swap.tokenToSwapAmount} ${swap.tokenToSwap!.symbol}',
            style: textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.swap_confirmation_you_receive,
          ),
          Text(
            '${swap.tokenSwappedAmount} ${swap.tokenSwapped!.symbol}',
            style: textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 50,
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: DexThemeBase.gradient,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          DexRatio(
            ratio: swap.ratio,
            token1Symbol:
                swap.tokenToSwap == null ? '' : swap.tokenToSwap!.symbol,
            token2Symbol:
                swap.tokenSwapped == null ? '' : swap.tokenSwapped!.symbol,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.swap_confirmation_swap_fee,
              ),
              Text(
                swap.swapFees.toString(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!
                    .swap_confirmation_minimum_received,
              ),
              Text(
                swap.minToReceive.toString(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.swap_confirmation_price_impact,
              ),
              Text(
                '${swap.priceImpact}%',
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!
                    .swap_confirmation_estimated_received,
              ),
              Text(
                swap.estimatedReceived.toString(),
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
