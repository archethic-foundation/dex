import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider_item.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolRefreshIcon extends ConsumerWidget {
  const PoolRefreshIcon({
    required this.poolAddress,
    super.key,
  });

  final String poolAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref
          ..invalidate(DexPoolProviders.getPool(poolAddress))
          ..invalidate(PoolItemProvider.poolItem(poolAddress));
      },
      child: Tooltip(
        message: 'Refresh information',
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                    .withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                .withOpacity(1),
            child: const Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                aedappfm.Iconsax.refresh,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
