import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawFinalAmount extends ConsumerWidget {
  const FarmWithdrawFinalAmount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.farmWithdrawOk == false) return const SizedBox.shrink();

    final finalAmountReward = farmWithdraw.finalAmountReward;
    final finalAmountWithdraw = farmWithdraw.finalAmountWithdraw;
    final timeout = ref.watch(
      FarmWithdrawFormProvider.farmWithdrawForm
          .select((value) => value.failure != null),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (finalAmountWithdraw != null)
          SelectableText(
            'Amount withdrawed: ${finalAmountWithdraw.formatNumber(precision: 8)} ${finalAmountWithdraw > 1 ? 'LP Tokens' : 'LP Token'}',
          )
        else if (timeout == false)
          const Row(
            children: [
              SelectableText(
                'Amount withdrawed: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          )
        else
          const SelectableText(
            'Amount withdrawed: The amount could not be recovered',
          ),
        if (finalAmountReward != null)
          SelectableText(
            'Amount rewarded: ${finalAmountReward.formatNumber(precision: 8)} ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol}',
          )
        else if (timeout == false)
          const Row(
            children: [
              SelectableText(
                'Amount rewarded: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          )
        else
          const SelectableText(
            'Amount rewarded: The amount could not be recovered',
          ),
      ],
    );
  }
}
