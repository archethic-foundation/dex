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
        liquidityAdd.token2 == null ||
        (liquidityAdd.token1minAmount == 0 &&
            liquidityAdd.token2minAmount == 0 &&
            liquidityAdd.expectedTokenLP == 0)) {
      return const SizedBox.shrink();
    }

    if (liquidityAdd.calculationInProgress) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'Mininum amount for ${liquidityAdd.token1!.symbol}: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 5,
                width: 5,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'Mininum amount for ${liquidityAdd.token2!.symbol}: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 5,
                width: 5,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                'Expected LP Token',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 5,
                width: 5,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              'Mininum amount for ${liquidityAdd.token1!.symbol}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SelectableText(
              '+ ${liquidityAdd.token1minAmount.formatNumber()} ${liquidityAdd.token1!.symbol}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              'Mininum amount for ${liquidityAdd.token2!.symbol}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SelectableText(
              '+ ${liquidityAdd.token2minAmount.formatNumber()} ${liquidityAdd.token2!.symbol}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              'Expected LP Token',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SelectableText(
              '+ ${liquidityAdd.expectedTokenLP.formatNumber()} ${liquidityAdd.expectedTokenLP > 1 ? 'LP Tokens' : 'LP Token'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
