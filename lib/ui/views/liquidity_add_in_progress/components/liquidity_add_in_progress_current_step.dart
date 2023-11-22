/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/add_liquidity.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddInProgressCurrentStep extends ConsumerWidget {
  const LiquidityAddInProgressCurrentStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null) {
      return const SizedBox(
        height: 30,
      );
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        AddLiquidityCase().getAEStepLabel(context, liquidityAdd.currentStep),
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
