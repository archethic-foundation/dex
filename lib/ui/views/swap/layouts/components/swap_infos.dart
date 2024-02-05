/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_price_impact.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInfos extends ConsumerWidget {
  const SwapInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.tokenToSwap == null ||
        swap.tokenSwappedAmount == 0 ||
        swap.tokenSwapped == null ||
        swap.tokenSwappedAmount == 0) {
      return const SizedBox.shrink();
    }
    final tokenAddressRatioPrimary =
        swap.tokenToSwap!.address == null ? 'UCO' : swap.tokenToSwap!.address!;

    final tvlAndApr = ref.watch(
      DexPoolProviders.estimatePoolTVLandAPRInFiat(swap.pool),
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
          if (swap.swapTotalFees > 0 && swap.tokenToSwap != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fees',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      '${(swap.swapTotalFees * swap.tokenToSwapAmount / 100).formatNumber()} ${swap.tokenToSwap!.symbol}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        swap.tokenToSwap!,
                        swap.swapTotalFees * swap.tokenToSwapAmount / 100,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (swap.pool != null)
                      Tooltip(
                        message:
                            'Liquidity Provider fees (${swap.pool!.infos!.fees}%): ${(swap.swapFees * swap.tokenToSwapAmount / 100).toStringAsFixed(8)} ${swap.tokenToSwap!.symbol} \nProtocol fees (${swap.pool!.infos!.protocolFees}%): ${(swap.swapProtocolFees * swap.tokenToSwapAmount / 100).toStringAsFixed(8)} ${swap.tokenToSwap!.symbol}',
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Icon(
                            Iconsax.info_circle,
                            size: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          if (swap.tokenSwapped != null &&
              swap.tokenToSwap != null &&
              swap.tokenSwappedAmount > 0 &&
              swap.tokenToSwapAmount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price impact',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                DexPriceImpact(
                  priceImpact: swap.priceImpact,
                  withLabel: false,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (swap.minToReceive > 0 && swap.tokenSwapped != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Minimum received',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      '${swap.minToReceive.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        swap.tokenSwapped!,
                        swap.minToReceive,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ],
            ),
          if (swap.pool?.infos != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TVL',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '\$${tvlAndApr.tvl.formatNumber(precision: 2)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (swap.pool?.infos != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ratio',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                DexRatio(
                  ratio: tokenAddressRatioPrimary.toUpperCase() ==
                          swap.pool?.pair.token1.address!.toUpperCase()
                      ? swap.pool!.infos!.ratioToken1Token2
                      : swap.pool!.infos!.ratioToken2Token1,
                  token1Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                          swap.pool!.pair.token1.address!.toUpperCase()
                      ? swap.pool!.pair.token1.symbol
                      : swap.pool!.pair.token2.symbol,
                  token2Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                          swap.pool!.pair.token1.address!.toUpperCase()
                      ? swap.pool!.pair.token2.symbol
                      : swap.pool!.pair.token1.symbol,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
