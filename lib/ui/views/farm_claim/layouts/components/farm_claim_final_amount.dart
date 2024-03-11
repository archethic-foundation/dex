import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimFinalAmount extends ConsumerWidget {
  const FarmClaimFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    if (farmClaim.farmClaimOk == false) return const SizedBox.shrink();

    final finalAmount = farmClaim.finalAmount;
    final timeout = ref.watch(
      FarmClaimFormProvider.farmClaimForm
          .select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            'Amount claimed: ${finalAmount.formatNumber(precision: 8)} ${farmClaim.rewardToken!.symbol}',
          )
        : timeout == false
            ? const Row(
                children: [
                  SelectableText(
                    'Amount claimed: ',
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ],
              )
            : const SelectableText(
                'Amount claimed: The amount could not be recovered',
              );
  }
}
