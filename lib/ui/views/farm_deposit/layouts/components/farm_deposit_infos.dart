import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositInfos extends ConsumerWidget {
  const FarmDepositInfos({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.dexFarmInfos == null) {
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
