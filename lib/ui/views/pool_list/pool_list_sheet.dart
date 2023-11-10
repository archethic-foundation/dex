/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/components/icon_animated.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSheet extends ConsumerWidget {
  const PoolListSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dexPools = ref.watch(DexPoolProviders.getPoolList);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                height: MediaQuery.of(context).size.height - 100,
                child: ArchethicScrollbar(
                  child: dexPools.when(
                    data: (pools) {
                      if (pools.isEmpty) {
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
                                    .poolListHeaderPoolAddress,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .poolListHeaderTokensAddress,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .poolListHeaderLPTokenAddress,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: Text(
                                '',
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: Text(
                                '',
                              ),
                            ),
                          ),
                        ],
                        rows: pools
                            .asMap()
                            .map(
                              (index, pool) => MapEntry(
                                index,
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Align(
                                        child: SizedBox(
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${pool.pair!.token1.symbol}-${pool.pair!.token2.symbol}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        width: 250,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FormatAddressLinkCopy(
                                              address: pool.poolAddress,
                                              reduceAddress: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        child: SizedBox(
                                          width: 250,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FormatAddressLinkCopy(
                                                address:
                                                    pool.pair!.token1.address!,
                                                reduceAddress: true,
                                              ),
                                              FormatAddressLinkCopy(
                                                address:
                                                    pool.pair!.token2.address!,
                                                reduceAddress: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        child: SizedBox(
                                          width: 250,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FormatAddressLinkCopy(
                                                address: pool.lpToken!.address!,
                                                reduceAddress: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        child: SizedBox(
                                          width: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                          pair: pool.pair!,
                                                        ),
                                                        ref,
                                                      );
                                                },
                                                child: const IconAnimated(
                                                  icon: Iconsax.wallet_add_1,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        child: SizedBox(
                                          width: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                          lpToken:
                                                              pool.lpToken!,
                                                          pair: pool.pair!,
                                                        ),
                                                        ref,
                                                      );
                                                },
                                                child: const IconAnimated(
                                                  icon: Iconsax.wallet_minus,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      );
                    },
                    error: (error, stacktrace) => const SizedBox(),
                    loading: () => const Padding(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
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
