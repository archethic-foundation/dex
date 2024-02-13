/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddAddCacheIcon extends ConsumerWidget {
  const PoolAddAddCacheIcon({
    required this.poolAddress,
    this.iconSize = 14,
    this.withLabel = false,
    super.key,
  });

  final String poolAddress;
  final double iconSize;
  final bool withLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(
          DexPoolProviders.putPoolToCache(
            poolAddress,
            isFavorite: true,
          ),
        );
      },
      child: Tooltip(
        message: 'Add this pool in my favorites tab',
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    ArchethicThemeBase.brightPurpleHoverBorder.withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color:
                ArchethicThemeBase.brightPurpleHoverBackground.withOpacity(1),
            child: const Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                Iconsax.star,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
