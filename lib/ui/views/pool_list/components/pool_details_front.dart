import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_add_in_cache_icon.dart';
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
    required this.toggleCard,
  });
  final DexPool pool;
  final VoidCallback toggleCard;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final poolListForm = ref.watch(PoolListFormProvider.poolListForm);
    final asyncTvlInFiat = ref.watch(
      DexPoolProviders.estimatePoolTVLandAPRInFiat(pool),
    );
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
                              Text(
                                '${pool.pair.token1.symbol}/${pool.pair.token2.symbol}',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
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
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: DexThemeBase.backgroundPopupColor,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                              color: ArchethicThemeBase.purple500,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 7,
                                  bottom: 5,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  'Pool',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: ArchethicThemeBase.raspberry300,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: toggleCard,
                            child: SizedBox(
                              height: 40,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: DexThemeBase.backgroundPopupColor,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                color: DexThemeBase.backgroundPopupColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 16,
                                    color: ArchethicThemeBase.raspberry300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (poolListForm.isResultTabSelected)
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: PoolAddInCacheIcon(
                                poolAddress: pool.poolAddress,
                              ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'APR',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '\$${asyncTvlInFiat.valueOrNull?.apr.formatNumber(precision: 2) ?? '...'}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: DexThemeBase.secondaryColor,
                                ),
                          ),
                        ],
                      ),
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
                    future:
                        ref.watch(DexPoolProviders.estimateStats(pool).future),
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
                      return const SizedBox(
                        height: 109,
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
        ),
      ],
    );
  }
}
