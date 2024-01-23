import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_all_info_popup.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetails extends ConsumerWidget {
  const PoolDetails({
    super.key,
    required this.pool,
    this.allInfo = false,
  });
  final DexPool pool;
  final bool allInfo;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
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
                                '${pool.pair!.token1.symbol}/${pool.pair!.token2.symbol}',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: DexPairIcons(
                                  token1Address:
                                      pool.pair!.token1.address == null
                                          ? 'UCO'
                                          : pool.pair!.token1.address!,
                                  token2Address:
                                      pool.pair!.token2.address == null
                                          ? 'UCO'
                                          : pool.pair!.token2.address!,
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
                                width: 5,
                              ),
                              LiquidityPositionsIcon(
                                lpTokenInUserBalance: pool.lpTokenInUserBalance,
                              ),
                            ],
                          ),
                          if (allInfo)
                            FormatAddressLinkCopy(
                              address: pool.poolAddress.toUpperCase(),
                              header: '',
                              typeAddress: TypeAddressLinkCopy.chain,
                              reduceAddress: true,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .fontSize!,
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'TVL',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '\$${pool.estimatePoolTVLInFiat.formatNumber(precision: 2)}',
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
                      if (allInfo == false)
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
                                          color:
                                              ArchethicThemeBase.raspberry300,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                await PoolDetailsAllInfoPopup.getDialog(
                                  context,
                                  pool,
                                );
                              },
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
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Deposited',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FormatAddressLink(
                            address: pool.poolAddress,
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
                                      VerifiedTokenIcon(
                                        address: pool.pair!.token1.address!,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${pool.pair!.token1.reserve.formatNumber()} ${pool.pair!.token1.symbol}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<String>(
                                    future: FiatValue().display(
                                      ref,
                                      pool.pair!.token1.symbol,
                                      pool.pair!.token1.reserve,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
                                      VerifiedTokenIcon(
                                        address: pool.pair!.token2.address!,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${pool.pair!.token2.reserve.formatNumber()} ${pool.pair!.token2.symbol}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<String>(
                                    future: FiatValue().display(
                                      ref,
                                      pool.pair!.token2.symbol,
                                      pool.pair!.token2.reserve,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
                      Text(
                        'Swap fees',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${pool.fees}%',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  if (allInfo == false)
                    const SizedBox(
                      height: 30,
                    ),
                  if (allInfo == false)
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
                                      .mainScreenWidgetDisplayedProvider
                                      .notifier,
                                )
                                .setWidget(
                                  SwapSheet(
                                    tokenToSwap: pool.pair!.token1,
                                    tokenSwapped: pool.pair!.token2,
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
                                          poolGenesisAddress: pool.poolAddress,
                                          pair: pool.pair!,
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
                                          poolGenesisAddress: pool.poolAddress,
                                          lpToken: pool.lpToken!,
                                          pair: pool.pair!,
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
