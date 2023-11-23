import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/dex_fees.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolInfoCard extends ConsumerWidget {
  const PoolInfoCard({
    required this.poolGenesisAddress,
    super.key,
  });

  final String poolGenesisAddress;

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
                      Text(
                        pool.pair!.token1.symbol,
                        style: textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            pool.pair!.token1.name,
                            style: textTheme.labelSmall,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (pool.pair!.token1.isUCO == false)
                            FormatAddressLink(
                              address: pool.pair!.token1.address!,
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        pool.pair!.token2.symbol,
                        style: textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            pool.pair!.token2.name,
                            style: textTheme.labelSmall,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (pool.pair!.token2.isUCO == false)
                            FormatAddressLink(
                              address: pool.pair!.token2.address!,
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DexRatio(
                        ratio: pool.ratio,
                        token1Symbol:
                            pool.pair == null ? '' : pool.pair!.token1.symbol,
                        token2Symbol:
                            pool.pair == null ? '' : pool.pair!.token2.symbol,
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
