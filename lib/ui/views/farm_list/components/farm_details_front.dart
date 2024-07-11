import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
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

class FarmDetailsFront extends ConsumerStatefulWidget {
  const FarmDetailsFront({
    super.key,
    required this.farm,
    required this.userBalance,
    this.isInPopup = false,
  });

  final DexFarm farm;
  final double? userBalance;
  final bool? isInPopup;

  @override
  FarmDetailsFrontState createState() => FarmDetailsFrontState();
}

class FarmDetailsFrontState extends ConsumerState<FarmDetailsFront>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);

    final session = ref.watch(SessionProviders.session);
    return Column(
      children: [
        FarmDetailsInfoHeader(farm: widget.farm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FarmDetailsInfoAPR(farm: widget.farm),
            FarmDetailsInfoTokenReward(farm: widget.farm),
          ],
        ),
        const SizedBox(height: 10),
        FarmDetailsInfoPeriod(farm: widget.farm),
        const SizedBox(height: 9),
        if (session.isConnected)
          Column(
            children: [
              FarmDetailsInfoYourDepositedAmount(
                farm: widget.farm,
              ),
              const SizedBox(
                height: 10,
              ),
              FarmDetailsInfoYourRewardAmount(
                farm: widget.farm,
              ),
              const SizedBox(
                height: 10,
              ),
              FarmDetailsInfoYourAvailableLP(
                farm: widget.farm,
                balance: widget.userBalance,
              ),
              FarmDetailsButtons(
                farm: widget.farm,
                rewardAmount: widget.farm.rewardAmount,
                depositedAmount: widget.farm.depositedAmount,
                userBalance: widget.userBalance,
                isInPopup: widget.isInPopup,
              ),
            ],
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 185),
            child: FarmDetailsButtons(
              farm: widget.farm,
              rewardAmount: 0,
              depositedAmount: 0,
              userBalance: 0,
              isInPopup: widget.isInPopup,
            ),
          ),
      ],
    );
  }
}
