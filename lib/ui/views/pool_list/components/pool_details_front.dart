import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider_item.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_apr.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_buttons.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_fees.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_header.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_tvl.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_volume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsFront extends ConsumerStatefulWidget {
  const PoolDetailsFront({
    super.key,
    required this.pool,
    required this.tab,
  });
  final DexPool pool;
  final PoolsListTab tab;

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
    return Consumer(
      builder: (context, ref, _) {
        final poolItem =
            ref.watch(PoolItemProvider.poolItem(widget.pool.poolAddress));

        if (poolItem.pool == null) {
          return const SizedBox.shrink();
        }
        final tvl = ref.watch(
          DexPoolProviders.estimatePoolTVLInFiat(poolItem.pool),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PoolDetailsInfoHeader(pool: poolItem.pool),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoolDetailsInfoTVL(tvl: tvl),
                PoolDetailsInfoAPR(tvl: tvl, fee24h: poolItem.fee24h),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoolDetailsInfoVolume(
                  volume24h: poolItem.volume24h,
                  volumeAllTime: poolItem.volumeAllTime,
                ),
                PoolDetailsInfoFees(
                  fees24h: poolItem.fee24h,
                  feesAllTime: poolItem.feeAllTime,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            PoolDetailsInfoButtons(poolItem: poolItem, tab: widget.tab),
          ],
        );
      },
    );
  }
}
