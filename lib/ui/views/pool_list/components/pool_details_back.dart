import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
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

class PoolDetailsBack extends ConsumerWidget {
  const PoolDetailsBack({
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
                        ],
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
                                Icons.home,
                                size: 16,
                                color: ArchethicThemeBase.raspberry300,
                              ),
                            ),
                          ),
                        ),
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}