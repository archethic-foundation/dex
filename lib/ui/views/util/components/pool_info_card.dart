import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
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

class PoolInfoCard extends ConsumerStatefulWidget {
  const PoolInfoCard({
    required this.poolGenesisAddress,
    required this.tokenAddressRatioPrimary,
    super.key,
  });

  final String poolGenesisAddress;
  final String tokenAddressRatioPrimary;

  @override
  ConsumerState<PoolInfoCard> createState() => _PoolInfoCardState();
}

class _PoolInfoCardState extends ConsumerState<PoolInfoCard> {
  bool _isExpanded = false;
  DexPool? pool;
  double? tvl;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await loadInfo();
    });
    super.initState();
  }

  Future<void> loadInfo({bool forceLoadFromBC = false}) async {
    pool = await ref
        .read(DexPoolProviders.getPool(widget.poolGenesisAddress).future);
    pool = await ref.read(DexPoolProviders.loadPoolCard(pool!).future);
    tvl = ref.read(
      DexPoolProviders.estimatePoolTVLInFiat(pool),
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    if (widget.poolGenesisAddress.isEmpty ||
        pool == null ||
        pool!.infos == null ||
        tvl == null) {
      return const SizedBox.shrink();
    }

    return aedappfm.Responsive.isDesktop(context) ||
            aedappfm.Responsive.isTablet(context)
        ? DecoratedBox(
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
                      _getPairName(context, pool!),
                      const SizedBox(
                        height: 10,
                      ),
                      _getRatio(context, pool!),
                      const SizedBox(
                        height: 10,
                      ),
                      VerifiedPoolIcon(
                        isVerified: pool!.isVerified,
                        withLabel: true,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getPairValues(context, pool!),
                      SelectableText(
                        '${AppLocalizations.of(context)!.poolInfoCardTVL} \$${tvl!.formatNumber(precision: 2)}',
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      DexFees(
                        fees: pool!.infos!.fees,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
                    border: Border.all(
                      color: aedappfm.AppThemeBase.sheetBorderSecondary,
                    ),
                  ),
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isExpanded = isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: Colors.transparent,
                        headerBuilder: (
                          BuildContext context,
                          bool isExpanded,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Column(
                              children: [
                                _getPairName(context, pool!),
                                _getRatio(context, pool!),
                              ],
                            ),
                          );
                        },
                        body: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _getPairValues(context, pool!),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  VerifiedPoolIcon(
                                    isVerified: pool!.isVerified,
                                    withLabel: true,
                                  ),
                                  SelectableText(
                                    '${AppLocalizations.of(context)!.poolInfoCardTVL} \$${tvl!.formatNumber(precision: 2)}',
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
                                  DexFees(
                                    fees: pool!.infos!.fees,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        isExpanded: _isExpanded,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
            .animate()
            .fade(duration: const Duration(milliseconds: 200))
            .scale(duration: const Duration(milliseconds: 200));
  }

  Widget _getPairName(
    BuildContext context,
    DexPool pool,
  ) {
    return Row(
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
    );
  }

  Widget _getRatio(BuildContext context, DexPool pool) {
    return pool.infos != null
        ? DexRatio(
            ratio: widget.tokenAddressRatioPrimary.toUpperCase() ==
                    pool.pair.token1.address!.toUpperCase()
                ? pool.infos!.ratioToken1Token2
                : pool.infos!.ratioToken2Token1,
            token1Symbol: widget.tokenAddressRatioPrimary.toUpperCase() ==
                    pool.pair.token1.address!.toUpperCase()
                ? pool.pair.token1.symbol.reduceSymbol()
                : pool.pair.token2.symbol.reduceSymbol(),
            token2Symbol: widget.tokenAddressRatioPrimary.toUpperCase() ==
                    pool.pair.token1.address!.toUpperCase()
                ? pool.pair.token2.symbol.reduceSymbol()
                : pool.pair.token1.symbol.reduceSymbol(),
          )
        : const SizedBox.shrink();
  }

  Widget _getPairValues(BuildContext context, DexPool pool) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SelectableText(
                  AppLocalizations.of(context)!.poolCardPooled,
                  style: AppTextStyles.bodyLarge(context),
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
    );
  }
}
