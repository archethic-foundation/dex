/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_fees.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/icon_animated.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSheet extends ConsumerStatefulWidget {
  const PoolListSheet({
    super.key,
  });

  @override
  PoolListSheetState createState() => PoolListSheetState();
}

class PoolListSheetState extends ConsumerState<PoolListSheet> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final poolListForm = ref.watch(PoolListFormProvider.poolListForm);
    final dexPools = ref.watch(
      DexPoolProviders.getPoolListFromCache(poolListForm.onlyVerifiedPools),
    );
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: const PoolListSearch(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 950,
                    height: MediaQuery.of(context).size.height - 160,
                    child: ArchethicScrollbar(
                      child: dexPools.map(
                        data: (pools) {
                          if (pools.value.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return DataTable(
                            columnSpacing: 0,
                            horizontalMargin: 0,
                            dividerThickness: 1,
                            columns: [
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .poolListHeaderName,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .poolListHeaderTokensPooled,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .poolListHeaderTVL,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.swapFeesLbl,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .poolListHeaderLiquidity,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .poolListHeaderSwap,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                            rows: pools.value
                                .asMap()
                                .map(
                                  (index, pool) {
                                    return MapEntry(
                                      index,
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Align(
                                              child: SizedBox(
                                                width: 250,
                                                child: Row(
                                                  children: [
                                                    DexPairIcons(
                                                      token1Address: pool
                                                                  .pair!
                                                                  .token1
                                                                  .address ==
                                                              null
                                                          ? 'UCO'
                                                          : pool.pair!.token1
                                                              .address!,
                                                      token2Address: pool
                                                                  .pair!
                                                                  .token2
                                                                  .address ==
                                                              null
                                                          ? 'UCO'
                                                          : pool.pair!.token2
                                                              .address!,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      pool.pair!.token1.symbol,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    if (pool.pair!.token1
                                                            .isUCO ==
                                                        false)
                                                      FormatAddressLink(
                                                        address: pool.pair!
                                                            .token1.address!,
                                                        tooltipLink:
                                                            AppLocalizations.of(
                                                          context,
                                                        )!
                                                                .localHistoryTooltipLinkToken,
                                                      ),
                                                    const Text(' / '),
                                                    Text(
                                                      pool.pair!.token2.symbol,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    if (pool.pair!.token2
                                                            .isUCO ==
                                                        false)
                                                      FormatAddressLink(
                                                        address: pool.pair!
                                                            .token2.address!,
                                                        tooltipLink:
                                                            AppLocalizations.of(
                                                          context,
                                                        )!
                                                                .localHistoryTooltipLinkToken,
                                                      ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    VerifiedPoolIcon(
                                                      isVerified:
                                                          pool.isVerified,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 20,
                                              ),
                                              child: SizedBox(
                                                width: 200,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            VerifiedTokenIcon(
                                                              address: pool
                                                                  .pair!
                                                                  .token1
                                                                  .address!,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              '${pool.pair!.token1.reserve.formatNumber()} ${pool.pair!.token1.symbol}',
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            VerifiedTokenIcon(
                                                              address: pool
                                                                  .pair!
                                                                  .token2
                                                                  .address!,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              '${pool.pair!.token2.reserve.formatNumber()} ${pool.pair!.token2.symbol}',
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    FormatAddressLink(
                                                      address: pool.poolAddress,
                                                      typeAddress:
                                                          TypeAddress.chain,
                                                      tooltipLink: AppLocalizations
                                                              .of(
                                                        context,
                                                      )!
                                                          .localHistoryTooltipLinkPool,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 20,
                                              ),
                                              child: SizedBox(
                                                width: 150,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          '\$${pool.estimatePoolTVLInFiat.formatNumber()}',
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Align(
                                              child: SizedBox(
                                                width: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    DexFees(
                                                      fees: pool.fees,
                                                      withLabel: false,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  child: SizedBox(
                                                    width: 50,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            ref
                                                                .read(
                                                                  MainScreenWidgetDisplayedProviders
                                                                      .mainScreenWidgetDisplayedProvider
                                                                      .notifier,
                                                                )
                                                                .setWidget(
                                                                  LiquidityAddSheet(
                                                                    poolGenesisAddress:
                                                                        pool.poolAddress,
                                                                    pair: pool
                                                                        .pair!,
                                                                  ),
                                                                  ref,
                                                                );
                                                          },
                                                          child:
                                                              const IconAnimated(
                                                            icon: Iconsax
                                                                .wallet_add_1,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  child: SizedBox(
                                                    width: 50,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            ref
                                                                .read(
                                                                  MainScreenWidgetDisplayedProviders
                                                                      .mainScreenWidgetDisplayedProvider
                                                                      .notifier,
                                                                )
                                                                .setWidget(
                                                                  LiquidityRemoveSheet(
                                                                    poolGenesisAddress:
                                                                        pool.poolAddress,
                                                                    lpToken: pool
                                                                        .lpToken!,
                                                                    pair: pool
                                                                        .pair!,
                                                                  ),
                                                                  ref,
                                                                );
                                                          },
                                                          child:
                                                              const IconAnimated(
                                                            icon: Iconsax
                                                                .wallet_minus,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  child: SizedBox(
                                                    width: 50,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            ref
                                                                .read(
                                                                  MainScreenWidgetDisplayedProviders
                                                                      .mainScreenWidgetDisplayedProvider
                                                                      .notifier,
                                                                )
                                                                .setWidget(
                                                                  SwapSheet(
                                                                    tokenToSwap: pool
                                                                        .pair!
                                                                        .token1,
                                                                    tokenSwapped: pool
                                                                        .pair!
                                                                        .token2,
                                                                  ),
                                                                  ref,
                                                                );
                                                          },
                                                          child:
                                                              const IconAnimated(
                                                            icon: Iconsax
                                                                .arrange_circle_2,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                                .values
                                .toList(),
                          );
                        },
                        error: (error) => const Text('error'),
                        loading: (loading) => const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 230,
                          ),
                          child: LinearProgressIndicator(
                            minHeight: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: Responsive.isMobile(context)
              ? const EdgeInsets.only(left: 20, right: 20, bottom: 80)
              : const EdgeInsets.all(20),
          child: FloatingActionButton.extended(
            onPressed: () {
              ref
                  .read(
                    MainScreenWidgetDisplayedProviders
                        .mainScreenWidgetDisplayedProvider.notifier,
                  )
                  .setWidget(const PoolAddSheet(), ref);
            },
            icon: const Icon(Icons.add),
            label: Text(
              AppLocalizations.of(context)!.addPool,
            ),
          ),
        ),
      ],
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  const TitlePlaceholder({
    super.key,
    required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
