/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/icon_animated.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
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
    final dexPools = ref.watch(DexPoolProviders.getPoolList);

    var _sortColumnIndex = 0;
    var _isAscending = true;

    void _sort<T>(
      Comparable<T> Function(DexPool d) getField,
      int columnIndex,
    ) {
      final ascending = _sortColumnIndex != columnIndex || !_isAscending;

      dexPools.map(
        data: (data) {
          data.value.sort((a, b) {
            final aValue = getField(a);
            final bValue = getField(b);
            return ascending
                ? Comparable.compare(aValue, bValue)
                : Comparable.compare(bValue, aValue);
          });
        },
        error: (error) {},
        loading: (loading) {},
      );

      setState(() {
        _sortColumnIndex = columnIndex;
        _isAscending = ascending;
      });
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 900,
                height: MediaQuery.of(context).size.height - 100,
                child: ArchethicScrollbar(
                  child: dexPools.when(
                    data: (pools) {
                      if (pools.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return DataTable(
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _isAscending,
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
                            onSort: (columnIndex, ascending) => _sort(
                              (DexPool pool) => pool.pair!.token1.name,
                              columnIndex,
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
                                    .poolListHeaderLPTokenName,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onSort: (columnIndex, ascending) => _sort(
                              (DexPool pool) => pool.lpToken!.name,
                              columnIndex,
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .poolListHeaderLPTokenSupply,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            numeric: true,
                            onSort: (columnIndex, ascending) => _sort(
                              (DexPool pool) => pool.lpToken!.supply,
                              columnIndex,
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
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Text(
                                                pool.pair!.token1.name,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (pool.pair!.token1.isUCO ==
                                                  false)
                                                FormatAddressLink(
                                                  address: pool
                                                      .pair!.token1.address!,
                                                ),
                                              const Text(' / '),
                                              Text(
                                                pool.pair!.token2.name,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (pool.pair!.token2.isUCO ==
                                                  false)
                                                FormatAddressLink(
                                                  address: pool
                                                      .pair!.token2.address!,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: SizedBox(
                                          width: 150,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${pool.pair!.token1.reserve.formatNumber()} ${pool.pair!.token1.symbol}',
                                                  ),
                                                  Text(
                                                    '${pool.pair!.token2.reserve.formatNumber()} ${pool.pair!.token2.symbol}',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              FormatAddressLink(
                                                address: pool.poolAddress,
                                                typeAddress: TypeAddress.chain,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        child: SizedBox(
                                          width: 150,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                pool.lpToken!.name,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              FormatAddressLink(
                                                address: pool.lpToken!.address!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: SizedBox(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                pool.lpToken!.supply
                                                    .formatNumber(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
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
                                                      icon:
                                                          Iconsax.wallet_add_1,
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
                                                      icon:
                                                          Iconsax.wallet_minus,
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
