import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aedex/ui/views/util/components/pool_favorite_icon.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolDetailsFront extends ConsumerWidget {
  const PoolDetailsFront({
    super.key,
    required this.pool,
  });
  final DexPool pool;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final tvl = ref.watch(
      DexPoolProviders.estimatePoolTVLInFiat(pool),
    );

    final stats = ref.watch(DexPoolProviders.estimateStats(pool));
    return Column(
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
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: DexPairIcons(
                              token1Address: pool.pair.token1.address == null
                                  ? 'UCO'
                                  : pool.pair.token1.address!,
                              token2Address: pool.pair.token2.address == null
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
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        'TVL',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SelectableText(
                        '\$${tvl.formatNumber(precision: 2)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: aedappfm.AppThemeBase.secondaryColor,
                            ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SelectableText(
                              '24h',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: SelectableText(
                              'APR',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      if (tvl > 0)
                        SelectableText(
                          '${(Decimal.parse(stats.fee24h.toString()) * Decimal.parse('365') * Decimal.parse('100') / Decimal.parse(tvl.toString())).toDouble().formatNumber(precision: 2)}%',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: aedappfm.AppThemeBase.secondaryColor,
                              ),
                        )
                      else
                        SelectableText(
                          '0.00%',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: aedappfm.AppThemeBase.secondaryColor,
                              ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SelectableText(
                              '24h',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: SelectableText(
                              'Volume',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SelectableText(
                              '24h',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: SelectableText(
                              'Fees',
                              style: Theme.of(context).textTheme.bodyLarge,
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
                        '\$${stats.volume24h.formatNumber(precision: stats.volume24h > 1 ? 2 : 8)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SelectableText(
                        '\$${stats.fee24h.formatNumber(precision: stats.fee24h > 1 ? 2 : 8)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SelectableText(
                              'All',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: SelectableText(
                              'Volume',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SelectableText(
                              'All',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: SelectableText(
                              'Fees',
                              style: Theme.of(context).textTheme.bodyLarge,
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
                        '\$${stats.volumeAllTime.formatNumber(precision: stats.volumeAllTime > 1 ? 2 : 8)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SelectableText(
                        '\$${stats.feeAllTime.formatNumber(precision: stats.feeAllTime > 1 ? 2 : 8)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  aedappfm.AppButton(
                    background: aedappfm.ArchethicThemeBase.purple500,
                    labelBtn: 'Swap these tokens',
                    onPressed: () {
                      ref
                          .read(
                            navigationIndexMainScreenProvider.notifier,
                          )
                          .state = 0;
                      context.go(
                        SwapSheet.routerPage,
                        extra: {
                          'tokenToSwap': pool.pair.token1,
                          'tokenSwapped': pool.pair.token2,
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DexButtonValidate(
                          background: aedappfm.ArchethicThemeBase.purple500,
                          controlOk: true,
                          labelBtn: 'Add Liquidity',
                          onPressed: () {
                            ref
                                .read(
                                  navigationIndexMainScreenProvider.notifier,
                                )
                                .state = 1;
                            context.go(
                              LiquidityAddSheet.routerPage,
                              extra: {
                                'pool': pool,
                                'pair': pool.pair,
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: DexButtonValidate(
                          background: aedappfm.ArchethicThemeBase.purple500,
                          controlOk: pool.lpTokenInUserBalance,
                          labelBtn: 'Remove liquidity',
                          onPressed: () {
                            ref
                                .read(
                                  navigationIndexMainScreenProvider.notifier,
                                )
                                .state = 1;
                            context.go(
                              LiquidityRemoveSheet.routerPage,
                              extra: {
                                'pool': pool,
                                'lpToken': pool.lpToken,
                                'pair': pool.pair,
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
