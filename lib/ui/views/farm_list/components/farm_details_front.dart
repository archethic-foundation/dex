import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_buttons.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_apr.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_header.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_period.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_token_reward.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_your_available_lp.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_your_deposited_amount.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_info_your_reward_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsFront extends ConsumerWidget {
  const FarmDetailsFront({
    super.key,
    required this.farm,
    required this.userInfos,
    required this.userBalance,
  });

  final DexFarm farm;
  final DexFarmUserInfos? userInfos;
  final double? userBalance;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);
    return Column(
      children: [
        FarmDetailsInfoHeader(farm: farm),
        FarmDetailsInfoAPR(farm: farm),
        FarmDetailsInfoTokenReward(farm: farm),
        const SizedBox(height: 20),
        FarmDetailsInfoPeriod(farm: farm),
        const SizedBox(height: 9),
        if (session.isConnected)
          Column(
            children: [
              FarmDetailsInfoYourDepositedAmount(
                farm: farm,
                userInfos: userInfos,
              ),
              const SizedBox(
                height: 10,
              ),
              FarmDetailsInfoYourRewardAmount(
                farm: farm,
                userInfos: userInfos,
              ),
              const SizedBox(
                height: 10,
              ),
              FarmDetailsInfoYourAvailableLP(
                farm: farm,
                balance: userBalance,
              ),
              FarmDetailsButtons(
                farm: farm,
                rewardAmount: userInfos?.rewardAmount ?? 0,
                depositedAmount: userInfos?.depositedAmount ?? 0,
                userBalance: userBalance,
              ),
            ],
          )
        else
          FarmDetailsButtons(
            farm: farm,
            rewardAmount: 0,
            depositedAmount: 0,
            userBalance: 0,
          ),
      ],
    );
  }
}
