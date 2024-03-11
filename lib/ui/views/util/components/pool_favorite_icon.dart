/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
      return const SizedBox(
        height: 16,
      );
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Tooltip(
            message: 'Favorite pool',
            child: Icon(
              aedappfm.Iconsax.star,
              color: aedappfm.ArchethicThemeBase.systemWarning600,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
