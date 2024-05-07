import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_addresses.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_distributed_rewards.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_header.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_lp_deposited.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_nb_deposit.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_remaining_reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsBack extends ConsumerWidget {
  const FarmDetailsBack({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      children: [
        FarmDetailsInfoHeader(farm: farm),
        FarmDetailsInfoAddresses(farm: farm),
        const SizedBox(height: 40),
        FarmDetailsInfoRemainingReward(farm: farm),
        const SizedBox(height: 10),
        FarmDetailsInfoLPDeposited(farm: farm),
        const SizedBox(height: 10),
        FarmDetailsInfoNbDeposit(farm: farm),
        const SizedBox(height: 10),
        FarmDetailsInfoDistributedRewards(farm: farm),
      ],
    );
  }
}
