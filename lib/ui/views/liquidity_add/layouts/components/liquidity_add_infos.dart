import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddInfos extends ConsumerWidget {
  const LiquidityAddInfos({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null ||
        liquidityAdd.token1minAmount <= 0 ||
        liquidityAdd.token2 == null ||
        liquidityAdd.token2minAmount <= 0 ||
        liquidityAdd.expectedTokenLP <= 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mininum amount for ${liquidityAdd.token1!.symbol}: +${liquidityAdd.token1minAmount.formatNumber()} ${liquidityAdd.token1!.symbol}',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          'Mininum amount for ${liquidityAdd.token2!.symbol}: +${liquidityAdd.token2minAmount.formatNumber()} ${liquidityAdd.token2!.symbol}',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          'Expected LP Token: +${liquidityAdd.expectedTokenLP.formatNumber()}',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
