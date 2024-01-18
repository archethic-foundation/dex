import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawInfos extends ConsumerWidget {
  const FarmWithdrawInfos({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.dexFarmInfos == null) {
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
