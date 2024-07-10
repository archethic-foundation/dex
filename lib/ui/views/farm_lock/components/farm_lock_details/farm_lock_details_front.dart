import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_addresses.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_distributed_rewards.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_header.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_lp_deposited.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_period.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_remaining_reward.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_token_reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsFront extends ConsumerStatefulWidget {
  const FarmLockDetailsFront({
    super.key,
    required this.farmLock,
    required this.userBalance,
  });

  final DexFarmLock farmLock;
  final double? userBalance;

  @override
  FarmDetailsFrontState createState() => FarmDetailsFrontState();
}

class FarmDetailsFrontState extends ConsumerState<FarmLockDetailsFront>
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
        FarmLockDetailsInfoHeader(farmLock: widget.farmLock),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FarmLockDetailsInfoAddresses(farmLock: widget.farmLock),
            FarmLockDetailsInfoTokenReward(farmLock: widget.farmLock),
          ],
        ),
        const SizedBox(height: 10),
        FarmLockDetailsInfoPeriod(farmLock: widget.farmLock),
        const SizedBox(height: 40),
        FarmLockDetailsInfoRemainingReward(farmLock: widget.farmLock),
        const SizedBox(height: 10),
        FarmLockDetailsInfoDistributedRewards(farmLock: widget.farmLock),
        const SizedBox(height: 10),
        FarmLockDetailsInfoLPDeposited(farmLock: widget.farmLock),
      ],
    );
  }
}
