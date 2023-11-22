/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/remove_liquidity.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveInProgressCurrentStep extends ConsumerWidget {
  const LiquidityRemoveInProgressCurrentStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.token1 == null) {
      return const SizedBox(
        height: 30,
      );
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        RemoveLiquidityCase()
            .getAEStepLabel(context, liquidityRemove.currentStep),
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
