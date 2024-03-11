import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/util/components/dex_fees.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/verified_pool_icon.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    const cardHeight = 125.0;

    if (poolGenesisAddress.isEmpty) {
      return const SizedBox(height: cardHeight);
    }

    return FutureBuilder<DexPool?>(
      future: ref.watch(DexPoolProviders.getPool(poolGenesisAddress).future),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pool = snapshot.data;
          if (pool == null) {
            return const SizedBox(height: cardHeight);
          }

          final tvl = ref.watch(
            DexPoolProviders.estimatePoolTVLInFiat(pool),
          );
          return Container(
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
              border: Border.all(
                color: aedappfm.AppThemeBase.sheetBorderSecondary,
              ),
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
                            tokenAddress: pool.pair.token1.address == null
                                ? 'UCO'
                                : pool.pair.token1.address!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Tooltip(
                            message: pool.pair.token1.symbol,
                            child: SelectableText(
                              pool.pair.token1.symbol.reduceSymbol(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: SelectableText('/'),
                          ),
                          DexTokenIcon(
                            tokenAddress: pool.pair.token2.address == null
                                ? 'UCO'
                                : pool.pair.token2.address!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Tooltip(
                            message: pool.pair.token2.symbol,
                            child: SelectableText(
                              pool.pair.token2.symbol.reduceSymbol(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DexRatio(
                        ratio: tokenAddressRatioPrimary.toUpperCase() ==
                                pool.pair.token1.address!.toUpperCase()
                            ? pool.infos!.ratioToken1Token2
                            : pool.infos!.ratioToken2Token1,
                        token1Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                                pool.pair.token1.address!.toUpperCase()
                            ? pool.pair.token1.symbol.reduceSymbol()
                            : pool.pair.token2.symbol.reduceSymbol(),
                        token2Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                                pool.pair.token1.address!.toUpperCase()
                            ? pool.pair.token2.symbol.reduceSymbol()
                            : pool.pair.token1.symbol.reduceSymbol(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VerifiedPoolIcon(
                        isVerified: pool.isVerified,
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
                          SelectableText(
                            AppLocalizations.of(context)!.poolCardPooled,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FormatAddressLink(
                            address: pool.poolAddress,
                            typeAddress: TypeAddressLink.chain,
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
                                    address: pool.pair.token1.address!,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Tooltip(
                                    message: pool.pair.token1.symbol,
                                    child: SelectableText(
                                      '${pool.pair.token1.reserve.formatNumber()} ${pool.pair.token1.symbol.reduceSymbol()}',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (pool.pair.token1.isUCO == false)
                                    FormatAddressLink(
                                      address: pool.pair.token1.address!,
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
                                    address: pool.pair.token2.address!,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Tooltip(
                                    message: pool.pair.token2.symbol,
                                    child: SelectableText(
                                      '${pool.pair.token2.reserve.formatNumber()} ${pool.pair.token2.symbol.reduceSymbol()}',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (pool.pair.token2.isUCO == false)
                                    FormatAddressLink(
                                      address: pool.pair.token2.address!,
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
                      SelectableText(
                        'TVL: \$${tvl.formatNumber(precision: 2)}',
                      ),
                      DexFees(
                        fees: pool.infos!.fees,
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
        return const SizedBox(height: cardHeight);
      },
    );
  }
}
