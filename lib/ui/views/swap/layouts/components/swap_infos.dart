/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_price_impact.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
        swap.tokenSwapped == null ||
        swap.pool == null ||
        swap.pool!.poolAddress.isEmpty) {
      return const SizedBox.shrink();
    }
    final tokenAddressRatioPrimary =
        swap.tokenToSwap!.address == null ? 'UCO' : swap.tokenToSwap!.address!;

    final tvl = ref.watch(
      DexPoolProviders.estimatePoolTVLInFiat(swap.pool),
    );

    if (swap.calculationInProgress) {
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
                      gradient: aedappfm.AppThemeBase.gradient,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  'Fees',
                  style: AppTextStyles.bodyMedium(context),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  'Price impact',
                  style: AppTextStyles.bodyMedium(context),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  'Minimum received',
                  style: AppTextStyles.bodyMedium(context),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  'TVL',
                  style: AppTextStyles.bodyMedium(context),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  'Ratio',
                  style: AppTextStyles.bodyMedium(context),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    if (swap.tokenSwapped == null ||
        swap.tokenToSwap == null ||
        swap.pool == null) {
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
                    gradient: aedappfm.AppThemeBase.gradient,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'Fees',
                style: AppTextStyles.bodyMedium(context),
              ),
              Row(
                children: [
                  Tooltip(
                    message: swap.tokenToSwap!.symbol,
                    child: SelectableText(
                      '${swap.swapTotalFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol.reduceSymbol()}',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      swap.tokenToSwap!,
                      swap.swapTotalFees,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SelectableText(
                          snapshot.data!,
                          style: AppTextStyles.bodyMedium(context),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (swap.pool != null &&
                      swap.pool!.infos != null &&
                      swap.tokenToSwap != null)
                    Tooltip(
                      message:
                          'Liquidity Provider fees (${swap.pool!.infos!.fees}%): ${swap.swapFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol} \nProtocol fees (${swap.pool!.infos!.protocolFees}%): ${swap.swapProtocolFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol}',
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Icon(
                          aedappfm.Iconsax.info_circle,
                          size: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'Price impact',
                style: AppTextStyles.bodyMedium(context),
              ),
              DexPriceImpact(
                priceImpact: swap.priceImpact,
                withLabel: false,
                textStyle: AppTextStyles.bodyMedium(context),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'Minimum received',
                style: AppTextStyles.bodyMedium(context),
              ),
              Row(
                children: [
                  Tooltip(
                    message: swap.tokenSwapped!.symbol,
                    child: SelectableText(
                      '${swap.minToReceive.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol.reduceSymbol()}',
                      style: AppTextStyles.bodyMedium(context),
                    ),
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
                        return SelectableText(
                          snapshot.data!,
                          style: AppTextStyles.bodyMedium(context),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'TVL',
                style: AppTextStyles.bodyMedium(context),
              ),
              SelectableText(
                '\$${tvl.formatNumber(precision: 2)}',
                style: AppTextStyles.bodyMedium(context),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'Ratio',
                style: AppTextStyles.bodyMedium(context),
              ),
              if (swap.pool != null && swap.pool!.infos != null)
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
                  textStyle: AppTextStyles.bodyMedium(context),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
