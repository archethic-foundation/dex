import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_addresses.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_distributed_rewards.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_header.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_lp_deposited.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_nb_deposit.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_remaining_reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsBack extends ConsumerStatefulWidget {
  const FarmDetailsBack({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  FarmDetailsBackState createState() => FarmDetailsBackState();
}

class FarmDetailsBackState extends ConsumerState<FarmDetailsBack>
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
        FarmDetailsInfoHeader(farm: widget.farm),
        FarmDetailsInfoAddresses(farm: widget.farm),
        const SizedBox(height: 40),
        FarmDetailsInfoRemainingReward(farm: widget.farm),
        const SizedBox(height: 10),
        FarmDetailsInfoLPDeposited(farm: widget.farm),
        const SizedBox(height: 10),
        FarmDetailsInfoNbDeposit(farm: widget.farm),
        const SizedBox(height: 10),
        FarmDetailsInfoDistributedRewards(farm: widget.farm),
      ],
    );
  }
}
