/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInfos extends ConsumerWidget {
  const SwapInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.swapFees <= 0 && swap.priceImpact <= 0) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            height: 5,
          ),
          if (swap.swapFees > 0 && swap.tokenToSwap != null)
            Row(
              children: [
                Text(
                  'Fees: ${swap.swapFees.formatNumber()} ${swap.tokenToSwap!.symbol}',
                ),
                const SizedBox(
                  width: 5,
                ),
                FutureBuilder<String>(
                  future: FiatValue().display(
                    ref,
                    swap.tokenToSwap!.symbol,
                    swap.swapFees,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          if (swap.priceImpact > 0)
            Text('Price impact: ${swap.priceImpact.formatNumber()}%'),
          if (swap.minToReceive > 0 && swap.tokenSwapped != null)
            Row(
              children: [
                Text(
                  'Minimum received: ${swap.minToReceive.formatNumber()} ${swap.tokenSwapped!.symbol}',
                ),
                const SizedBox(
                  width: 5,
                ),
                FutureBuilder<String>(
                  future: FiatValue().display(
                    ref,
                    swap.tokenSwapped!.symbol,
                    swap.minToReceive,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
