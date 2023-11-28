import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/dex_fees.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolInfoCard extends ConsumerWidget {
  const PoolInfoCard({
    required this.poolGenesisAddress,
    required this.tokenAddressRatioPrimary,
    super.key,
  });

  final String poolGenesisAddress;
  final String tokenAddressRatioPrimary;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    if (poolGenesisAddress.isEmpty) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<DexPool?>(
      future:
          ref.watch(DexPoolProviders.getPoolInfos(poolGenesisAddress).future),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pool = snapshot.data;
          if (pool == null) {
            return const SizedBox.shrink();
          }
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  ArchethicThemeBase.blue800,
                  BlendMode.modulate,
                ),
                image: const AssetImage(
                  'assets/images/background-sub-menu.png',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: ArchethicThemeBase.neutral900,
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DexTokenIcon(
                            tokenAddress: pool.pair!.token1.address == null
                                ? 'UCO'
                                : pool.pair!.token1.address!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            pool.pair!.token1.symbol,
                            style: textTheme.titleLarge,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text('/'),
                          ),
                          DexTokenIcon(
                            tokenAddress: pool.pair!.token2.address == null
                                ? 'UCO'
                                : pool.pair!.token2.address!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            pool.pair!.token2.symbol,
                            style: textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DexRatio(
                        ratio: tokenAddressRatioPrimary ==
                                pool.pair!.token1.address
                            ? pool.ratioToken1Token2
                            : pool.ratioToken2Token1,
                        token1Symbol: tokenAddressRatioPrimary ==
                                pool.pair!.token1.address
                            ? pool.pair!.token1.symbol
                            : pool.pair!.token2.symbol,
                        token2Symbol: tokenAddressRatioPrimary ==
                                pool.pair!.token1.address
                            ? pool.pair!.token2.symbol
                            : pool.pair!.token1.symbol,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VerifiedPoolIcon(
                        address: pool.poolAddress,
                        withLabel: true,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.poolCardPooled,
                            style: textTheme.labelSmall,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (pool.pair!.token1.isUCO == false)
                                    FormatAddressLink(
                                      address: pool.pair!.token1.address!,
                                    )
                                  else
                                    const SizedBox(
                                      width: 12,
                                    ),
                                ],
                              ),
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
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (pool.pair!.token2.isUCO == false)
                                    FormatAddressLink(
                                      address: pool.pair!.token2.address!,
                                    )
                                  else
                                    const SizedBox(
                                      width: 12,
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
                        children: [
                          Text(
                            AppLocalizations.of(context)!.poolCardLPToken,
                            style: textTheme.labelSmall,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FormatAddressLink(
                            address: pool.lpToken!.address!,
                            typeAddress: TypeAddress.transaction,
                          ),
                        ],
                      ),
                      Text(
                        '${AppLocalizations.of(context)!.poolCardLPTokenSupply}: ${pool.lpToken!.supply.formatNumber()}',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DexFees(
                        fees: pool.fees,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fade(duration: const Duration(milliseconds: 200))
              .scale(duration: const Duration(milliseconds: 200));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
