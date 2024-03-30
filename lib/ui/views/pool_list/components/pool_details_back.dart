import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider_item.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aedex/ui/views/util/components/pool_favorite_icon.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsBack extends ConsumerStatefulWidget {
  const PoolDetailsBack({
    super.key,
    required this.pool,
  });
  final DexPool pool;

  @override
  PoolDetailsBackState createState() => PoolDetailsBackState();
}

class PoolDetailsBackState extends ConsumerState<PoolDetailsBack>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);
    return Consumer(
      builder: (context, ref, _) {
        final session = ref.watch(SessionProviders.session);
        final poolItem =
            ref.watch(PoolItemProvider.poolItem(widget.pool.poolAddress));
        if (poolItem.pool == null) {
          return const SizedBox.shrink();
        }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                    message: poolItem.pool!.pair.token1.symbol,
                                    child: SelectableText(
                                      poolItem.pool!.pair.token1.symbol
                                          .reduceSymbol(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: aedappfm.Responsive
                                                .fontSizeFromTextStyle(
                                              context,
                                              Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!,
                                            ),
                                          ),
                                    ),
                                  ),
                                  const SelectableText('/'),
                                  Tooltip(
                                    message: poolItem.pool!.pair.token2.symbol,
                                    child: SelectableText(
                                      poolItem.pool!.pair.token2.symbol
                                          .reduceSymbol(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: aedappfm.Responsive
                                                .fontSizeFromTextStyle(
                                              context,
                                              Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!,
                                            ),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: DexPairIcons(
                                      token1Address: poolItem
                                                  .pool!.pair.token1.address ==
                                              null
                                          ? 'UCO'
                                          : poolItem.pool!.pair.token1.address!,
                                      token2Address: poolItem
                                                  .pool!.pair.token2.address ==
                                              null
                                          ? 'UCO'
                                          : poolItem.pool!.pair.token2.address!,
                                      iconSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  VerifiedPoolIcon(
                                    isVerified: poolItem.pool!.isVerified,
                                  ),
                                  LiquidityPositionsIcon(
                                    lpTokenInUserBalance:
                                        poolItem.pool!.lpTokenInUserBalance,
                                  ),
                                  LiquidityFavoriteIcon(
                                    isFavorite: poolItem.pool!.isFavorite,
                                  ),
                                ],
                              ),
                              FormatAddressLinkCopy(
                                address:
                                    poolItem.pool!.poolAddress.toUpperCase(),
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
                                    address: poolItem.pool!.lpToken.address!
                                        .toUpperCase(),
                                    typeAddress:
                                        TypeAddressLinkCopy.transaction,
                                    reduceAddress: true,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .fontSize!,
                                  ),
                                ],
                              ),
                              if (poolItem.pool!.pair.token1.isUCO == false)
                                Row(
                                  children: [
                                    Tooltip(
                                      message:
                                          poolItem.pool!.pair.token1.symbol,
                                      child: FormatAddressLinkCopy(
                                        header:
                                            'Token ${poolItem.pool!.pair.token1.symbol.reduceSymbol()} address: ',
                                        address: poolItem
                                            .pool!.pair.token1.address!
                                            .toUpperCase(),
                                        typeAddress:
                                            TypeAddressLinkCopy.transaction,
                                        reduceAddress: true,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .fontSize!,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    VerifiedTokenIcon(
                                      address:
                                          poolItem.pool!.pair.token1.address!,
                                    ),
                                  ],
                                )
                              else
                                const SizedBox(
                                  height: 20,
                                ),
                              if (poolItem.pool!.pair.token2.isUCO == false)
                                Row(
                                  children: [
                                    Tooltip(
                                      message:
                                          poolItem.pool!.pair.token2.symbol,
                                      child: FormatAddressLinkCopy(
                                        header:
                                            'Token ${poolItem.pool!.pair.token2.symbol.reduceSymbol()} address: ',
                                        address: poolItem
                                            .pool!.pair.token2.address!
                                            .toUpperCase(),
                                        typeAddress:
                                            TypeAddressLinkCopy.transaction,
                                        reduceAddress: true,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .fontSize!,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    VerifiedTokenIcon(
                                      address:
                                          poolItem.pool!.pair.token2.address!,
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
                        height: 18,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SelectableText(
                                'Deposited',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context).textTheme.bodyLarge!,
                                      ),
                                    ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FormatAddressLink(
                                address: poolItem.pool!.poolAddress,
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
                                          Tooltip(
                                            message: poolItem
                                                .pool!.pair.token1.symbol,
                                            child: SelectableText(
                                              '${poolItem.pool!.pair.token1.reserve.formatNumber()} ${poolItem.pool!.pair.token1.symbol.reduceSymbol()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontSize: aedappfm
                                                            .Responsive
                                                        .fontSizeFromTextStyle(
                                                      context,
                                                      Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      FutureBuilder<String>(
                                        future: FiatValue().display(
                                          ref,
                                          poolItem.pool!.pair.token1,
                                          poolItem.pool!.pair.token1.reserve,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return SelectableText(
                                              snapshot.data!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: aedappfm
                                                            .Responsive
                                                        .fontSizeFromTextStyle(
                                                      context,
                                                      Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!,
                                                    ),
                                                  ),
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
                                          Tooltip(
                                            message: poolItem
                                                .pool!.pair.token2.symbol,
                                            child: SelectableText(
                                              '${poolItem.pool!.pair.token2.reserve.formatNumber()} ${poolItem.pool!.pair.token2.symbol.reduceSymbol()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontSize: aedappfm
                                                            .Responsive
                                                        .fontSizeFromTextStyle(
                                                      context,
                                                      Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      FutureBuilder<String>(
                                        future: FiatValue().display(
                                          ref,
                                          poolItem.pool!.pair.token2,
                                          poolItem.pool!.pair.token2.reserve,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return SelectableText(
                                              snapshot.data!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: aedappfm
                                                            .Responsive
                                                        .fontSizeFromTextStyle(
                                                      context,
                                                      Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!,
                                                    ),
                                                  ),
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
                                      FutureBuilder<double>(
                                        future: ref.watch(
                                          BalanceProviders.getBalance(
                                            session.genesisAddress,
                                            poolItem.pool!.lpToken.address!,
                                          ).future,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var percentage = 0.0;
                                            if (poolItem.pool!.lpToken.supply >
                                                0) {
                                              percentage =
                                                  (Decimal.parse('100') *
                                                          Decimal.parse(
                                                            '${snapshot.data!}',
                                                          ) /
                                                          Decimal.parse(
                                                            '${poolItem.pool!.lpToken.supply}',
                                                          ))
                                                      .toDouble();
                                            }
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    SelectableText(
                                                      snapshot.data!
                                                          .formatNumber(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                            fontSize: aedappfm
                                                                    .Responsive
                                                                .fontSizeFromTextStyle(
                                                              context,
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge!,
                                                            ),
                                                          ),
                                                    ),
                                                    if (poolItem.pool!.lpToken
                                                            .supply >
                                                        0)
                                                      SelectableText(
                                                        ' / ${poolItem.pool!.lpToken.supply.formatNumber()} ${poolItem.pool!.lpToken.supply > 1 ? 'LP Tokens' : 'LP Token'}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: aedappfm
                                                                      .Responsive
                                                                  .fontSizeFromTextStyle(
                                                                context,
                                                                Theme.of(
                                                                  context,
                                                                )
                                                                    .textTheme
                                                                    .bodyLarge!,
                                                              ),
                                                            ),
                                                      )
                                                    else
                                                      SelectableText(
                                                        poolItem.pool!.lpToken
                                                                    .supply >
                                                                1
                                                            ? 'LP Tokens'
                                                            : 'LP Token',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: aedappfm
                                                                      .Responsive
                                                                  .fontSizeFromTextStyle(
                                                                context,
                                                                Theme.of(
                                                                  context,
                                                                )
                                                                    .textTheme
                                                                    .bodyLarge!,
                                                              ),
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                                SelectableText(
                                                  '(${percentage.formatNumber(precision: 8)}%)',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        fontSize: aedappfm
                                                                .Responsive
                                                            .fontSizeFromTextStyle(
                                                          context,
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!,
                                                        ),
                                                      ),
                                                ),
                                              ],
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          ),
                          SelectableText(
                            '${poolItem.pool!.infos?.fees ?? '-- '}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            'Protocol fees',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          ),
                          SelectableText(
                            '${poolItem.pool!.infos?.protocolFees ?? '-- '}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
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
                            ratio: poolItem.pool!.infos!.ratioToken1Token2,
                            token1Symbol: poolItem.pool!.pair.token1.symbol,
                            token2Symbol: poolItem.pool!.pair.token2.symbol,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DexRatio(
                            ratio: poolItem.pool!.infos!.ratioToken2Token1,
                            token1Symbol: poolItem.pool!.pair.token2.symbol,
                            token2Symbol: poolItem.pool!.pair.token1.symbol,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
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
      },
    );
  }
}
