/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapConversionInfo extends ConsumerWidget {
  const SwapConversionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.tokenToSwap == null || swap.tokenSwapped == null) {
      return const SizedBox();
    }
    return Text(
      '1 ${swap.tokenToSwap!.symbol} = ???? ${swap.tokenSwapped!.symbol}',
    );
  }
}
