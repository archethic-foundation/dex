import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_add_liquidity.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_balances_summary.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_earn_rewards.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_farmed_tokens_summary.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockBlockHeader extends ConsumerWidget {
  const FarmLockBlockHeader({
    required this.pool,
    required this.farmLock,
    required this.farm,
    required this.sortCriteria,
    super.key,
  });

  final DexPool? pool;
  final DexFarmLock? farmLock;
  final DexFarm? farm;
  final String sortCriteria;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (pool == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: aedappfm.Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 50)
          : const EdgeInsets.symmetric(horizontal: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (aedappfm.Responsive.isDesktop(context))
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FarmLockBlockAddLiquidity(
                      pool: pool!,
                      width: constraints.maxWidth * 0.32,
                      height: 300,
                      sortCriteria: sortCriteria,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.02,
                    ),
                    FarmLockBlockEarnRewards(
                      pool: pool!,
                      farmLock: farmLock,
                      farm: farm,
                      width: constraints.maxWidth * 0.32,
                      height: 300,
                      sortCriteria: sortCriteria,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            FarmLockBlockBalanceSummary(
                              width: constraints.maxWidth * 0.32,
                              height: 140,
                            ),
                            FarmLockBlockFarmedTokensSummary(
                              width: constraints.maxWidth * 0.32,
                              height: 145,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              else if (aedappfm.Responsive.isTablet(context))
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FarmLockBlockAddLiquidity(
                          pool: pool!,
                          width: constraints.maxWidth * 0.49,
                          height: 300,
                          sortCriteria: sortCriteria,
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.02,
                        ),
                        FarmLockBlockEarnRewards(
                          pool: pool!,
                          farmLock: farmLock,
                          farm: farm,
                          width: constraints.maxWidth * 0.49,
                          height: 300,
                          sortCriteria: sortCriteria,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FarmLockBlockBalanceSummary(
                          width: constraints.maxWidth * 0.49,
                          height: 145,
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.02,
                        ),
                        FarmLockBlockFarmedTokensSummary(
                          width: constraints.maxWidth * 0.49,
                          height: 145,
                        ),
                      ],
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FarmLockBlockAddLiquidity(
                      pool: pool!,
                      width: constraints.maxWidth,
                      height: 290,
                      sortCriteria: sortCriteria,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FarmLockBlockEarnRewards(
                      pool: pool!,
                      farmLock: farmLock,
                      farm: farm,
                      width: constraints.maxWidth,
                      height: 320,
                      sortCriteria: sortCriteria,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FarmLockBlockBalanceSummary(
                          width: constraints.maxWidth,
                          height: 140,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FarmLockBlockFarmedTokensSummary(
                          width: constraints.maxWidth,
                          height: 140,
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }
}
