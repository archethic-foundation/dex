/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/add_pool.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInProgressCurrentStep extends ConsumerWidget {
  const SwapInProgressCurrentStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.tokenToSwap == null) {
      return const SizedBox(
        height: 30,
      );
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        AddPoolCase().getAEStepLabel(context, swap.currentStep),
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
