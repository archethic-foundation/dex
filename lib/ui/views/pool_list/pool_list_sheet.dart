/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_fees.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/icon_animated.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
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

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 850,
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
                                    .poolListHeaderLPTokenSupply,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.feesLbl,
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
                                              DexPairIcons(
                                                token1Address:
                                                    pool.pair!.token1.address ==
                                                            null
                                                        ? 'UCO'
                                                        : pool.pair!.token1
                                                            .address!,
                                                token2Address:
                                                    pool.pair!.token2.address ==
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
                                              if (pool.pair!.token1.isUCO ==
                                                  false)
                                                FormatAddressLink(
                                                  address: pool
                                                      .pair!.token1.address!,
                                                ),
                                              const Text(' / '),
                                              Text(
                                                pool.pair!.token2.symbol,
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
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              VerifiedPoolIcon(
                                                address: pool.poolAddress,
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
                                                  Row(
                                                    children: [
                                                      VerifiedTokenIcon(
                                                        address: pool.pair!
                                                            .token1.address!,
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
                                                        address: pool.pair!
                                                            .token2.address!,
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
                                                typeAddress: TypeAddress.chain,
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    pool.lpToken!.supply
                                                        .formatNumber(),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  FormatAddressLink(
                                                    address:
                                                        pool.lpToken!.address!,
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
                                          width: 50,
                                          child: Row(
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
