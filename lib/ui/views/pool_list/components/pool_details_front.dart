import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
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
    final asyncTvlInFiat = ref.watch(
      DexPoolProviders.estimatePoolTVLandAPRInFiat(pool),
    );
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
                          Text(
                            '${pool.pair.token1.symbol}/${pool.pair.token2.symbol}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
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
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          VerifiedPoolIcon(
                            isVerified: pool.isVerified,
                          ),
                          const SizedBox(
                            height: 17,
                            width: 5,
                          ),
                          LiquidityPositionsIcon(
                            lpTokenInUserBalance: pool.lpTokenInUserBalance,
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
                      Text(
                        'TVL',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '\$${asyncTvlInFiat.valueOrNull?.tvl.formatNumber(precision: 2) ?? '...'}',
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
                          Text(
                            'APR',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
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
              FutureBuilder<
                  ({
                    double volume24h,
                    double fee24h,
                    double volumeAllTime,
                    double feeAllTime
                  })>(
                future: ref.watch(DexPoolProviders.estimateStats(pool).future),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Volume (24h)',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Fees (24h)',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${snapshot.data!.volume24h.formatNumber(precision: snapshot.data!.volume24h > 1 ? 2 : 8)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '\$${snapshot.data!.fee24h.formatNumber(precision: snapshot.data!.fee24h > 1 ? 2 : 8)}',
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
                            Text(
                              'Volume (All)',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Fees (All)',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${snapshot.data!.volumeAllTime.formatNumber(precision: snapshot.data!.volumeAllTime > 1 ? 2 : 8)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '\$${snapshot.data!.feeAllTime.formatNumber(precision: snapshot.data!.feeAllTime > 1 ? 2 : 8)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Volume (24h)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Fees (24h)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 5),
                            child: SizedBox(
                              width: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              height: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              child: const CircularProgressIndicator(
                                strokeWidth: 0.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 5),
                            child: SizedBox(
                              width: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              height: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              child: const CircularProgressIndicator(
                                strokeWidth: 0.5,
                                color: Colors.white,
                              ),
                            ),
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
                            'Volume (All)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Fees (All)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 5),
                            child: SizedBox(
                              width: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              height: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              child: const CircularProgressIndicator(
                                strokeWidth: 0.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 5),
                            child: SizedBox(
                              width: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              height: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              child: const CircularProgressIndicator(
                                strokeWidth: 0.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  DexButtonValidate(
                    background: ArchethicThemeBase.purple500,
                    controlOk: true,
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
