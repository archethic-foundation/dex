import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_apr.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_apr_farm.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_buttons.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_fees.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_header.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_tvl.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_volume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsFront extends ConsumerStatefulWidget {
  const PoolDetailsFront({
    super.key,
    required this.pool,
    this.tab,
    this.poolWithFarm = false,
  });
  final DexPool pool;
  final PoolsListTab? tab;
  final bool poolWithFarm;

  @override
  PoolDetailsFrontState createState() => PoolDetailsFrontState();
}

class PoolDetailsFrontState extends ConsumerState<PoolDetailsFront>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            PoolDetailsInfoHeader(
              pool: widget.pool,
              displayPoolFarmAvailable: widget.tab != null,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoolDetailsInfoTVL(tvl: widget.pool.infos?.tvl ?? 0),
                if (widget.poolWithFarm == false)
                  PoolDetailsInfoAPR(
                    tvl: widget.pool.infos?.tvl ?? 0,
                    fee24h: widget.pool.infos?.fee24h ?? 0,
                  )
                else
                  PoolDetailsInfoAPRFarm(poolAddress: widget.pool.poolAddress),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoolDetailsInfoVolume(
                  volume24h: widget.pool.infos?.volume24h,
                  volumeAllTime: widget.pool.infos?.volumeAllTime,
                ),
                if (widget.poolWithFarm == false)
                  PoolDetailsInfoFees(
                    fees24h: widget.pool.infos?.fee24h,
                    feesAllTime: widget.pool.infos?.feeAllTime,
                  ),
              ],
            ),
          ],
        ),
        PoolDetailsInfoButtons(pool: widget.pool, tab: widget.tab),
      ],
    );
  }
}
