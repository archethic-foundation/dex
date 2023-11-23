/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapRatio extends ConsumerWidget {
  const SwapRatio({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.tokenToSwap == null ||
        swap.tokenSwapped == null ||
        swap.ratio == 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      child: Text(
        '1 ${swap.tokenToSwap!.symbol} = ${swap.ratio} ${swap.tokenSwapped!.symbol}',
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
