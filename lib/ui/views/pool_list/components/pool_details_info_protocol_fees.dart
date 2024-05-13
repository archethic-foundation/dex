import 'package:aedex/domain/models/dex_pool_infos.dart';
import 'package:aedex/ui/views/util/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoProtocolFees extends ConsumerWidget {
  const PoolDetailsInfoProtocolFees({
    super.key,
    required this.poolInfos,
  });

  final DexPoolInfos? poolInfos;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          AppLocalizations.of(context)!.poolDetailsInfoProtocolFees,
          style: AppTextStyles.bodyLarge(context),
        ),
        SelectableText(
          '${poolInfos?.protocolFees ?? '-- '}%',
          style: AppTextStyles.bodyLarge(context),
        ),
      ],
    );
  }
}
