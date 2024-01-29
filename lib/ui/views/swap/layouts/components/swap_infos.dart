/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
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
    final tokenAddressRatioPrimary =
        swap.tokenToSwap!.address == null ? 'UCO' : swap.tokenToSwap!.address!;

    final tvlInFiatAsync = ref.watch(
      DexPoolProviders.estimatePoolTVLInFiat(swap.pool!),
    );

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
                  'Fees: ${swap.swapFees.formatNumber()} UCO',
                  style: Theme.of(context).textTheme.bodyLarge,
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
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          if (swap.tokenSwapped != null &&
              swap.tokenToSwap != null &&
              swap.tokenSwappedAmount > 0 &&
              swap.tokenToSwapAmount > 0)
            Text(
              'Price impact: ${swap.priceImpact.formatNumber()}%',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          if (swap.minToReceive > 0 && swap.tokenSwapped != null)
            Row(
              children: [
                Text(
                  'Minimum received: ${swap.minToReceive.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
                  style: Theme.of(context).textTheme.bodyLarge,
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
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          if (swap.pool?.infos != null)
            Text(
              'TVL: \$${tvlInFiatAsync.valueOrNull?.formatNumber(precision: 2) ?? '...'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          if (swap.pool?.infos != null)
            DexRatio(
              ratio: tokenAddressRatioPrimary == swap.pool?.pair.token1.address
                  ? swap.pool!.infos!.ratioToken1Token2
                  : swap.pool!.infos!.ratioToken2Token1,
              token1Symbol:
                  tokenAddressRatioPrimary == swap.pool!.pair.token1.address
                      ? swap.pool!.pair.token1.symbol
                      : swap.pool!.pair.token2.symbol,
              token2Symbol:
                  tokenAddressRatioPrimary == swap.pool!.pair.token1.address
                      ? swap.pool!.pair.token2.symbol
                      : swap.pool!.pair.token1.symbol,
            ),
        ],
      ),
    );
  }
}
