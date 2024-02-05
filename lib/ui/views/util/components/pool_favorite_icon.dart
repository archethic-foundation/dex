/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityFavoriteIcon extends ConsumerWidget {
  const LiquidityFavoriteIcon({
    required this.isFavorite,
    this.iconSize = 14,
    super.key,
  });

  final double iconSize;
  final bool isFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isFavorite == false) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Tooltip(
            message: 'Favorite pool',
            child: Icon(
              Iconsax.star,
              color: ArchethicThemeBase.systemWarning800,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
