import 'package:aedex/domain/models/dex_pool_infos.dart';
import 'package:aedex/ui/views/util/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoSwapFees extends ConsumerWidget {
  const PoolDetailsInfoSwapFees({
    super.key,
    required this.poolInfos,
  });

  final DexPoolInfos? poolInfos;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectableText(
            AppLocalizations.of(context)!.poolDetailsInfoSwapFees,
            style: AppTextStyles.bodyLarge(context),
          ),
          SelectableText(
            '${poolInfos?.fees ?? '-- '}%',
            style: AppTextStyles.bodyLarge(context),
          ),
        ],
      ),
    );
  }
}
