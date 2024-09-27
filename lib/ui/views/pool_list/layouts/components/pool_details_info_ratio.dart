import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool_infos.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoRatio extends ConsumerWidget {
  const PoolDetailsInfoRatio({
    super.key,
    required this.pool,
    required this.poolInfos,
  });

  final DexPool pool;
  final DexPoolInfos poolInfos;
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DexRatio(
                ratio: poolInfos.ratioToken1Token2,
                token1Symbol: pool.pair.token1.symbol,
                token2Symbol: pool.pair.token2.symbol,
                textStyle: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DexRatio(
                ratio: poolInfos.ratioToken2Token1,
                token1Symbol: pool.pair.token2.symbol,
                token2Symbol: pool.pair.token1.symbol,
                textStyle: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
