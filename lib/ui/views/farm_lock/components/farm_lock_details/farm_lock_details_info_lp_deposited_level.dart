import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_farm_lock_stats.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FarmLockDetailsInfoLPDepositedLevel extends ConsumerWidget {
  const FarmLockDetailsInfoLPDepositedLevel({
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
    return Padding(
      padding: const EdgeInsets.all(5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.10,
                child: Align(
                  child: SelectableText(
                    level,
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.15,
                child: Align(
                  child: SelectableText(
                    farmLockStats.depositsCount.toString(),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.75,
                child: Align(
                  child: Column(
                    children: [
                      SelectableText(
                        '${farmLockStats.lpTokensDeposited.formatNumber(precision: 8)} ${farmLockStats.lpTokensDeposited > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken} ${DEXLPTokenFiatValue().display(ref, farmLock.lpTokenPair!.token1, farmLock.lpTokenPair!.token2, farmLockStats.lpTokensDeposited, farmLock.poolAddress)}',
                        style: AppTextStyles.bodyMedium(context),
                      ),
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
                                      : snapshotAmounts.data!['token1']
                                          as double;
                              final amountToken2 =
                                  snapshotAmounts.data!['token2'] == null
                                      ? 0.0
                                      : snapshotAmounts.data!['token2']
                                          as double;

                              return SelectableText(
                                '= ${amountToken1.formatNumber(precision: amountToken1 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token1.symbol.reduceSymbol()} / ${amountToken2.formatNumber(precision: amountToken2 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token2.symbol.reduceSymbol()}',
                                style: AppTextStyles.bodyMedium(context),
                              );
                            }
                            return SelectableText(
                              ' ',
                              style: AppTextStyles.bodyMedium(context),
                            );
                          },
                        )
                      else
                        SelectableText(
                          ' ',
                          style: AppTextStyles.bodyMedium(context),
                        ),
                      SelectableText(
                        '${DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            farmLockStats.rewardsAllocated[0].startPeriod *
                                1000,
                          ),
                        )} - ${DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            farmLockStats.rewardsAllocated[0].endPeriod * 1000,
                          ),
                        )}: ${farmLockStats.rewardsAllocated[0].rewardsAllocated.formatNumber(precision: farmLockStats.rewardsAllocated[0].rewardsAllocated > 1 ? 2 : 8)} ${farmLock.rewardToken!.symbol}',
                        style: AppTextStyles.bodyMedium(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
