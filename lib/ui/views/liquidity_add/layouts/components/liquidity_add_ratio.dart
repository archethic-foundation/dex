/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddRatio extends ConsumerWidget {
  const LiquidityAddRatio({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    if (liquidityAdd.token1 == null ||
        liquidityAdd.token2 == null ||
        liquidityAdd.ratio == 0) {
      return const SizedBox(
        height: 40,
      );
    }

    return SizedBox(
      height: 40,
      child: Text(
        '1 ${liquidityAdd.token1!.name} = ${liquidityAdd.ratio} ${liquidityAdd.token2!.name}',
      ),
    )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 500),
        )
        .scale(
          duration: const Duration(milliseconds: 500),
        );
  }
}
