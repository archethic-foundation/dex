import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider_item.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_addresses.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_deposited.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_header.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_protocol_fees.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_ratio.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_swap_fees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsBack extends ConsumerStatefulWidget {
  const PoolDetailsBack({
    super.key,
    required this.pool,
  });
  final DexPool pool;

  @override
  PoolDetailsBackState createState() => PoolDetailsBackState();
}

class PoolDetailsBackState extends ConsumerState<PoolDetailsBack>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);
    return Consumer(
      builder: (context, ref, _) {
        final poolItem =
            ref.watch(PoolItemProvider.poolItem(widget.pool.poolAddress));
        if (poolItem.pool == null) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            PoolDetailsInfoHeader(pool: poolItem.pool),
            PoolDetailsInfoAddresses(pool: poolItem.pool),
            PoolDetailsInfoDeposited(pool: poolItem.pool),
            PoolDetailsInfoSwapFees(poolInfos: poolItem.pool!.infos),
            PoolDetailsInfoProtocolFees(poolInfos: poolItem.pool!.infos),
            const SizedBox(height: 10),
            PoolDetailsInfoRatio(pool: poolItem.pool),
          ],
        );
      },
    );
  }
}
