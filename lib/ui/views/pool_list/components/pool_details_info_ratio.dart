import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoRatio extends ConsumerWidget {
  const PoolDetailsInfoRatio({
    super.key,
    required this.pool,
  });

  final DexPool? pool;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (pool == null || pool!.infos == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DexRatio(
              ratio: pool!.infos!.ratioToken1Token2,
              token1Symbol: pool!.pair.token1.symbol,
              token2Symbol: pool!.pair.token2.symbol,
              textStyle: AppTextStyles.bodyLarge(context),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DexRatio(
              ratio: pool!.infos!.ratioToken2Token1,
              token1Symbol: pool!.pair.token2.symbol,
              token2Symbol: pool!.pair.token1.symbol,
              textStyle: AppTextStyles.bodyLarge(context),
            ),
          ],
        ),
      ],
    );
  }
}
