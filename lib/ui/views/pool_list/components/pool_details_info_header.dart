import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aedex/ui/views/util/components/pool_farm_available.dart';
import 'package:aedex/ui/views/util/components/pool_favorite_icon.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoHeader extends ConsumerWidget {
  const PoolDetailsInfoHeader({
    super.key,
    required this.pool,
  });

  final DexPool? pool;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final contextAddresses = PoolFarmAvailableState().getContextAddresses(ref);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tooltip(
                  message: pool!.pair.token1.symbol,
                  child: SelectableText(
                    pool!.pair.token1.symbol.reduceSymbol(lengthMax: 6),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.headlineMedium!,
                          ),
                        ),
                  ),
                ),
                const SelectableText('/'),
                Tooltip(
                  message: pool!.pair.token2.symbol,
                  child: SelectableText(
                    pool!.pair.token2.symbol.reduceSymbol(lengthMax: 6),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.headlineMedium!,
                          ),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: DexPairIcons(
                    token1Address: pool!.pair.token1.address == null
                        ? 'UCO'
                        : pool!.pair.token1.address!,
                    token2Address: pool!.pair.token2.address == null
                        ? 'UCO'
                        : pool!.pair.token2.address!,
                    iconSize: 22,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                VerifiedPoolIcon(
                  isVerified: pool!.isVerified,
                ),
                LiquidityPositionsIcon(
                  lpTokenInUserBalance: pool!.lpTokenInUserBalance,
                ),
                LiquidityFavoriteIcon(
                  isFavorite: pool!.isFavorite,
                ),
                if (contextAddresses.aeETHUCOPoolAddress.toUpperCase() ==
                    pool!.poolAddress.toUpperCase())
                  const PoolFarmAvailable(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
