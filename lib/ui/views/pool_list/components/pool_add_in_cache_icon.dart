/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddInCacheIcon extends ConsumerWidget {
  const PoolAddInCacheIcon({
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
    return ref.watch(DexPoolProviders.getPoolListFromCache).maybeWhen(
          orElse: SizedBox.shrink,
          data: (pools) {
            var exists = false;
            for (final pool in pools) {
              if (pool.poolAddress.toUpperCase() == poolAddress.toUpperCase()) {
                exists = true;
                break;
              }
            }
            if (exists == false) {
              return InkWell(
                onTap: () {
                  ref.read(
                    DexPoolProviders.putPoolToCache(poolAddress),
                  );
                },
                child: Tooltip(
                  message: 'Add this pool in my pools tab',
                  child: SizedBox(
                    height: 40,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: DexThemeBase.backgroundPopupColor,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      color: DexThemeBase.backgroundPopupColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: ArchethicThemeBase.raspberry300,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
  }
}
