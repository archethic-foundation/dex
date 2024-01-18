import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimInfos extends ConsumerWidget {
  const FarmClaimInfos({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    if (farmClaim.dexFarmInfos == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '???',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
