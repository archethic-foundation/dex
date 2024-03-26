import 'dart:convert';

import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider_item.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';

import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';

import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aedex/ui/views/util/components/pool_favorite_icon.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolDetailsFront extends ConsumerStatefulWidget {
  const PoolDetailsFront({
    super.key,
    required this.poolAddress,
    required this.pool,
  });
  final DexPool pool;
  final String poolAddress;

  @override
  PoolDetailsFrontState createState() => PoolDetailsFrontState();
}

class PoolDetailsFrontState extends ConsumerState<PoolDetailsFront>
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
        final poolItem =
            ref.watch(PoolItemProvider.poolItem(widget.pool.poolAddress));

        if (poolItem.pool == null) {
          return const SizedBox.shrink();
        }
        final tvl = ref.watch(
          DexPoolProviders.estimatePoolTVLInFiat(poolItem.pool),
        );

        return Column(
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
                                  token1Address:
                                      poolItem.pool!.pair.token1.address == null
                                          ? 'UCO'
                                          : poolItem.pool!.pair.token1.address!,
                                  token2Address:
                                      poolItem.pool!.pair.token2.address == null
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
                            '\$${tvl.formatNumber(precision: 2)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.headlineMedium!,
                                  ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodySmall!,
                                        ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: SelectableText(
                                  'APR',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
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
                          if (tvl > 0)
                            SelectableText(
                              '${(Decimal.parse(poolItem.fee24h.toString()) * Decimal.parse('365') * Decimal.parse('100') / Decimal.parse(tvl.toString())).toDouble().formatNumber(precision: 2)}%',
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
                                    fontSize: aedappfm.Responsive
                                        .fontSizeFromTextStyle(
                                      context,
                                      Theme.of(context)
                                          .textTheme
                                          .headlineMedium!,
                                    ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodySmall!,
                                        ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: SelectableText(
                                  'Volume',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
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
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SelectableText(
                                  '24h',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodySmall!,
                                        ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: SelectableText(
                                  'Fees',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            '\$${poolItem.volume24h.formatNumber(precision: poolItem.volume24h > 1 ? 2 : 8)}',
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
                            '\$${poolItem.fee24h.formatNumber(precision: poolItem.fee24h > 1 ? 2 : 8)}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SelectableText(
                                  'All',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodySmall!,
                                        ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: SelectableText(
                                  'Volume',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
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
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SelectableText(
                                  'All',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodySmall!,
                                        ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: SelectableText(
                                  'Fees',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            '\$${poolItem.volumeAllTime.formatNumber(precision: poolItem.volumeAllTime > 1 ? 2 : 8)}',
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
                            '\$${poolItem.feeAllTime.formatNumber(precision: poolItem.feeAllTime > 1 ? 2 : 8)}',
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
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      aedappfm.AppButton(
                        fontSize: aedappfm.Responsive.fontSizeFromValue(
                          context,
                          desktopValue: 16,
                        ),
                        background: aedappfm.ArchethicThemeBase.purple500,
                        labelBtn: 'Swap these tokens',
                        onPressed: () {
                          final tokenToSwapJson =
                              jsonEncode(poolItem.pool!.pair.token1.toJson());
                          final tokenSwappedJson =
                              jsonEncode(poolItem.pool!.pair.token2.toJson());
                          final tokenToSwapEncoded =
                              Uri.encodeComponent(tokenToSwapJson);
                          final tokenSwappedEncoded =
                              Uri.encodeComponent(tokenSwappedJson);

                          context.go(
                            Uri(
                              path: SwapSheet.routerPage,
                              queryParameters: {
                                'tokenToSwap': tokenToSwapEncoded,
                                'tokenSwapped': tokenSwappedEncoded,
                              },
                            ).toString(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: aedappfm.ButtonValidate(
                              background: aedappfm.ArchethicThemeBase.purple500,
                              controlOk: true,
                              labelBtn: aedappfm.Responsive.isDesktop(context)
                                  ? 'Add Liquidity'
                                  : 'Add Liquid.',
                              fontSize: aedappfm.Responsive.fontSizeFromValue(
                                context,
                                desktopValue: 16,
                              ),
                              onPressed: () {
                                final poolJson =
                                    jsonEncode(poolItem.pool!.toJson());
                                final pairJson =
                                    jsonEncode(poolItem.pool!.pair.toJson());
                                final poolEncoded =
                                    Uri.encodeComponent(poolJson);
                                final pairEncoded =
                                    Uri.encodeComponent(pairJson);
                                context.go(
                                  Uri(
                                    path: LiquidityAddSheet.routerPage,
                                    queryParameters: {
                                      'pool': poolEncoded,
                                      'pair': pairEncoded,
                                    },
                                  ).toString(),
                                );
                              },
                              isConnected: ref
                                  .watch(SessionProviders.session)
                                  .isConnected,
                              displayWalletConnectOnPressed: () async {
                                final sessionNotifier =
                                    ref.read(SessionProviders.session.notifier);
                                await sessionNotifier.connectToWallet();

                                final session =
                                    ref.read(SessionProviders.session);
                                if (session.error.isNotEmpty) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .snackBarTheme
                                          .backgroundColor,
                                      content: SelectableText(
                                        session.error,
                                        style: Theme.of(context)
                                            .snackBarTheme
                                            .contentTextStyle,
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  context.go(
                                    '/',
                                  );
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: aedappfm.ButtonValidate(
                              background: aedappfm.ArchethicThemeBase.purple500,
                              controlOk: poolItem.pool!.lpTokenInUserBalance,
                              labelBtn: aedappfm.Responsive.isDesktop(context)
                                  ? 'Remove liquidity'
                                  : 'Rmv Liquid.',
                              fontSize: aedappfm.Responsive.fontSizeFromValue(
                                context,
                                desktopValue: 16,
                              ),
                              onPressed: () {
                                final poolJson =
                                    jsonEncode(poolItem.pool!.toJson());
                                final pairJson =
                                    jsonEncode(poolItem.pool!.pair.toJson());
                                final lpTokenJson =
                                    jsonEncode(poolItem.pool!.lpToken.toJson());
                                final poolEncoded =
                                    Uri.encodeComponent(poolJson);
                                final pairEncoded =
                                    Uri.encodeComponent(pairJson);
                                final lpTokenEncoded =
                                    Uri.encodeComponent(lpTokenJson);
                                context.go(
                                  Uri(
                                    path: LiquidityRemoveSheet.routerPage,
                                    queryParameters: {
                                      'pool': poolEncoded,
                                      'pair': pairEncoded,
                                      'lpToken': lpTokenEncoded,
                                    },
                                  ).toString(),
                                );
                              },
                              isConnected: ref
                                  .watch(SessionProviders.session)
                                  .isConnected,
                              displayWalletConnectOnPressed: () async {
                                final sessionNotifier =
                                    ref.read(SessionProviders.session.notifier);
                                await sessionNotifier.connectToWallet();

                                final session =
                                    ref.read(SessionProviders.session);
                                if (session.error.isNotEmpty) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .snackBarTheme
                                          .backgroundColor,
                                      content: SelectableText(
                                        session.error,
                                        style: Theme.of(context)
                                            .snackBarTheme
                                            .contentTextStyle,
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  context.go(
                                    '/',
                                  );
                                }
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
      },
    );
  }
}
