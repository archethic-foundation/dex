import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_addresses.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_deposited.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_fees.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_header.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_protocol_fees.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_ratio.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_swap_fees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsBack extends ConsumerStatefulWidget {
  const PoolDetailsBack({
    super.key,
    required this.pool,
    this.poolWithFarm = false,
  });
  final DexPool pool;
  final bool poolWithFarm;

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
    return Column(
      children: [
        PoolDetailsInfoHeader(pool: widget.pool),
        PoolDetailsInfoAddresses(pool: widget.pool),
        PoolDetailsInfoDeposited(pool: widget.pool),
        PoolDetailsInfoSwapFees(poolInfos: widget.pool.infos),
        PoolDetailsInfoProtocolFees(poolInfos: widget.pool.infos),
        PoolDetailsInfoFees(
          fees24h: widget.pool.stats?.fee24h,
          feesAllTime: widget.pool.stats?.feeAllTime,
          poolWithFarm: widget.poolWithFarm,
        ),
        const SizedBox(height: 10),
        PoolDetailsInfoRatio(pool: widget.pool),
      ],
    );
  }
}
