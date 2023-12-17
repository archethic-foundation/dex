/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityPositionsIcon extends ConsumerWidget {
  const LiquidityPositionsIcon({
    required this.lpTokenInUserBalance,
    this.iconSize = 14,
    this.withLabel = false,
    super.key,
  });

  final bool lpTokenInUserBalance;
  final double iconSize;
  final bool withLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (lpTokenInUserBalance == false) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Tooltip(
            message: 'You have liquidity positions',
            child: Icon(
              Iconsax.star,
              color: ArchethicThemeBase.systemWarning500,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
