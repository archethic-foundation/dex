import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aedex/ui/views/util/components/pool_favorite_icon.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsBack extends ConsumerWidget {
  const PoolDetailsBack({
    super.key,
    required this.pool,
  });
  final DexPool pool;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SelectableText(
                                '${pool.pair.token1.symbol}/${pool.pair.token2.symbol}',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: DexPairIcons(
                                  token1Address:
                                      pool.pair.token1.address == null
                                          ? 'UCO'
                                          : pool.pair.token1.address!,
                                  token2Address:
                                      pool.pair.token2.address == null
                                          ? 'UCO'
                                          : pool.pair.token2.address!,
                                  iconSize: 22,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              VerifiedPoolIcon(
                                isVerified: pool.isVerified,
                              ),
                              LiquidityPositionsIcon(
                                lpTokenInUserBalance: pool.lpTokenInUserBalance,
                              ),
                              LiquidityFavoriteIcon(
                                isFavorite: pool.isFavorite,
                              ),
                            ],
                          ),
                          FormatAddressLinkCopy(
                            address: pool.poolAddress.toUpperCase(),
                            header: 'Pool address: ',
                            typeAddress: TypeAddressLinkCopy.chain,
                            reduceAddress: true,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize!,
                          ),
                          Row(
                            children: [
                              FormatAddressLinkCopy(
                                header: 'LP Token address: ',
                                address: pool.lpToken.address!.toUpperCase(),
                                typeAddress: TypeAddressLinkCopy.transaction,
                                reduceAddress: true,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontSize!,
                              ),
                            ],
                          ),
                          if (pool.pair.token1.isUCO == false)
                            Row(
                              children: [
                                FormatAddressLinkCopy(
                                  header:
                                      'Token ${pool.pair.token1.symbol} address: ',
                                  address:
                                      pool.pair.token1.address!.toUpperCase(),
                                  typeAddress: TypeAddressLinkCopy.transaction,
                                  reduceAddress: true,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize!,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                VerifiedTokenIcon(
                                  address: pool.pair.token1.address!,
                                ),
                              ],
                            )
                          else
                            const SizedBox(
                              height: 20,
                            ),
                          if (pool.pair.token2.isUCO == false)
                            Row(
                              children: [
                                FormatAddressLinkCopy(
                                  header:
                                      'Token ${pool.pair.token2.symbol} address: ',
                                  address:
                                      pool.pair.token2.address!.toUpperCase(),
                                  typeAddress: TypeAddressLinkCopy.transaction,
                                  reduceAddress: true,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize!,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                VerifiedTokenIcon(
                                  address: pool.pair.token2.address!,
                                ),
                              ],
                            )
                          else
                            const SizedBox(
                              height: 20,
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SelectableText(
                            'Deposited',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FormatAddressLink(
                            address: pool.poolAddress,
                            typeAddress: TypeAddressLink.chain,
                            tooltipLink: AppLocalizations.of(
                              context,
                            )!
                                .localHistoryTooltipLinkPool,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      SelectableText(
                                        '${pool.pair.token1.reserve.formatNumber()} ${pool.pair.token1.symbol}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<String>(
                                    future: FiatValue().display(
                                      ref,
                                      pool.pair.token1,
                                      pool.pair.token1.reserve,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SelectableText(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      SelectableText(
                                        '${pool.pair.token2.reserve.formatNumber()} ${pool.pair.token2.symbol}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<String>(
                                    future: FiatValue().display(
                                      ref,
                                      pool.pair.token2,
                                      pool.pair.token2.reserve,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SelectableText(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        'Swap fees',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SelectableText(
                        '${pool.infos?.fees ?? '-- '}%',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        'Protocol fees',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SelectableText(
                        '${pool.infos?.protocolFees ?? '-- '}%',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DexRatio(
                        ratio: pool.infos!.ratioToken1Token2,
                        token1Symbol: pool.pair.token1.symbol,
                        token2Symbol: pool.pair.token2.symbol,
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DexRatio(
                        ratio: pool.infos!.ratioToken2Token1,
                        token1Symbol: pool.pair.token2.symbol,
                        token2Symbol: pool.pair.token1.symbol,
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
