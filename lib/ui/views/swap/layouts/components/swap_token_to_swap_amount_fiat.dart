/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenToSwapAmountFiat extends ConsumerWidget {
  const SwapTokenToSwapAmountFiat({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    return FutureBuilder<String>(
      future: FiatValue().display(
        ref,
        'UCO',
        swap.tokenToSwapAmount,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            '${swap.tokenToSwapAmount.formatNumber()} UCO',
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
