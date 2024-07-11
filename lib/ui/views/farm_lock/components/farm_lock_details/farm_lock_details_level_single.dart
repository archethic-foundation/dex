import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_farm_lock_stats.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/util/config/config.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';

class FarmLockDetailsLevelSingle extends ConsumerWidget {
  const FarmLockDetailsLevelSingle({
    super.key,
    required this.farmLock,
    required this.level,
    required this.farmLockStats,
  });

  final DexFarmLock farmLock;
  final String level;
  final DexFarmLockStats farmLockStats;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final style = TextStyle(
      fontSize: aedappfm.Responsive.fontSizeFromValue(
        context,
        desktopValue: 13,
        ratioMobile: 3,
        ratioTablet: 1,
      ),
    );
    return Container(
      height: 185,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: int.tryParse(level)!.isEven
            ? LinearGradient(
                colors: [
                  aedappfm.AppThemeBase.sheetBackgroundTertiary
                      .withOpacity(0.4),
                  aedappfm.AppThemeBase.sheetBackgroundTertiary,
                ],
                stops: const [0, 1],
              )
            : LinearGradient(
                colors: [
                  aedappfm.AppThemeBase.sheetBackgroundSecondary
                      .withOpacity(0.4),
                  aedappfm.AppThemeBase.sheetBackgroundSecondary,
                ],
                stops: const [0, 1],
              ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              aedappfm.AppThemeBase.sheetBorderTertiary.withOpacity(0.4),
              aedappfm.AppThemeBase.sheetBorderTertiary,
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 6, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  '${AppLocalizations.of(context)!.level}: $level',
                  style: style,
                ),
                SelectableText(
                  '${AppLocalizations.of(context)!.farmDetailsInfoNbDeposit}: ${farmLockStats.depositsCount}',
                  style: style,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SelectableText(
                  '${AppLocalizations.of(context)!.farmDetailsInfoLPDeposited}: ${farmLockStats.lpTokensDeposited.formatNumber(precision: 8)} ${farmLockStats.lpTokensDeposited > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken} ${DEXLPTokenFiatValue().display(ref, farmLock.lpTokenPair!.token1, farmLock.lpTokenPair!.token2, farmLockStats.lpTokensDeposited, farmLock.poolAddress)}',
                  style: style,
                ),
              ],
            ),
            Row(
              children: [
                if (farmLockStats.lpTokensDeposited > 0)
                  FutureBuilder<Map<String, dynamic>?>(
                    future: PoolFactoryRepositoryImpl(
                      farmLock.poolAddress,
                      aedappfm.sl.get<ApiService>(),
                    ).getRemoveAmounts(
                      farmLockStats.lpTokensDeposited,
                    ),
                    builder: (
                      context,
                      snapshotAmounts,
                    ) {
                      if (snapshotAmounts.hasData &&
                          snapshotAmounts.data != null) {
                        final amountToken1 =
                            snapshotAmounts.data!['token1'] == null
                                ? 0.0
                                : snapshotAmounts.data!['token1'] as double;
                        final amountToken2 =
                            snapshotAmounts.data!['token2'] == null
                                ? 0.0
                                : snapshotAmounts.data!['token2'] as double;

                        return SelectableText(
                          '= ${amountToken1.formatNumber(precision: amountToken1 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token1.symbol.reduceSymbol()} / ${amountToken2.formatNumber(precision: amountToken2 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token2.symbol.reduceSymbol()}',
                          style: style,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .farmLockDetailsLevelSingleRewardsAllocated,
                      style: style,
                    ),
                    SelectableText(
                      '${AppLocalizations.of(context)!.farmLockDetailsLevelSingleWeight}: ${(farmLockStats.weight * 100).toInt()}%',
                      style: style,
                    ),
                  ],
                ),
                Column(
                  children: List.generate(farmLockStats.rewardsAllocated.length,
                      (index) {
                    final reward = farmLockStats.rewardsAllocated[index];
                    final dateFormat = DateFormat(
                      Config.kSecondsInDay == 86400
                          ? 'yyyy-MM-dd'
                          : 'yyyy-MM-dd HH:mm:ss',
                    );
                    final startDate = dateFormat.format(
                      DateTime.fromMillisecondsSinceEpoch(
                        reward.startPeriod * 1000,
                      ),
                    );
                    final endDate = dateFormat.format(
                      DateTime.fromMillisecondsSinceEpoch(
                        reward.endPeriod * 1000,
                      ),
                    );
                    final rewardsAllocatedFormatted =
                        reward.rewardsAllocated.formatNumber(
                      precision: reward.rewardsAllocated > 1 ? 2 : 8,
                    );

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectableText(
                          '$startDate - $endDate',
                          style: style,
                        ),
                        SelectableText(
                          '$rewardsAllocatedFormatted ${farmLock.rewardToken!.symbol}',
                          style: style,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
