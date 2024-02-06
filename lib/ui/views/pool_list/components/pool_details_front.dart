import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aedex/ui/views/util/components/pool_favorite_icon.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final tvlAndApr = ref.watch(
      DexPoolProviders.estimatePoolTVLandAPRInFiat(pool),
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
                        '\$${tvlAndApr.tvl.formatNumber(precision: 2)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: DexThemeBase.secondaryColor,
                            ),
                      ),
                    ],
                  ),
                  /*Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectableText(
                            'APR',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SelectableText(
                            '${asyncTvlInFiat.valueOrNull?.apr.formatNumber(precision: 2) ?? '...'}%',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: DexThemeBase.secondaryColor,
                                ),
                          ),
                        ],
                      ),*/
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
                      SelectableText(
                        'Volume (24h)',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SelectableText(
                        'Fees (24h)',
                        style: Theme.of(context).textTheme.bodyLarge,
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
                      SelectableText(
                        'Volume (All)',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SelectableText(
                        'Fees (All)',
                        style: Theme.of(context).textTheme.bodyLarge,
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
                  AppButton(
                    background: ArchethicThemeBase.purple500,
                    labelBtn: 'Swap these tokens',
                    onPressed: () {
                      ref
                          .read(
                            MainScreenWidgetDisplayedProviders
                                .mainScreenWidgetDisplayedProvider.notifier,
                          )
                          .setWidget(
                            SwapSheet(
                              tokenToSwap: pool.pair.token1,
                              tokenSwapped: pool.pair.token2,
                            ),
                            ref,
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
                          background: ArchethicThemeBase.purple500,
                          controlOk: true,
                          labelBtn: 'Add Liquidity',
                          onPressed: () {
                            ref
                                .read(
                                  MainScreenWidgetDisplayedProviders
                                      .mainScreenWidgetDisplayedProvider
                                      .notifier,
                                )
                                .setWidget(
                                  LiquidityAddSheet(
                                    pool: pool,
                                    pair: pool.pair,
                                  ),
                                  ref,
                                );
                          },
                        ),
                      ),
                      Expanded(
                        child: DexButtonValidate(
                          background: ArchethicThemeBase.purple500,
                          controlOk: pool.lpTokenInUserBalance,
                          labelBtn: 'Remove liquidity',
                          onPressed: () {
                            ref
                                .read(
                                  MainScreenWidgetDisplayedProviders
                                      .mainScreenWidgetDisplayedProvider
                                      .notifier,
                                )
                                .setWidget(
                                  LiquidityRemoveSheet(
                                    pool: pool,
                                    lpToken: pool.lpToken,
                                    pair: pool.pair,
                                  ),
                                  ref,
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
