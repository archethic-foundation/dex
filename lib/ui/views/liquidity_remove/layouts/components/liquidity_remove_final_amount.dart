import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveFinalAmount extends ConsumerWidget {
  const LiquidityRemoveFinalAmount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.liquidityRemoveOk == false) {
      return const SizedBox.shrink();
    }

    final finalAmountToken1 = liquidityRemove.finalAmountToken1;
    final finalAmountToken2 = liquidityRemove.finalAmountToken2;
    final finalAmountLPToken = liquidityRemove.finalAmountLPToken;
    final timeout = ref.watch(
      LiquidityRemoveFormProvider.liquidityRemoveForm
          .select((value) => value.failure != null),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (timeout == false)
          if (finalAmountToken1 != null)
            SelectableText(
              'Token obtained: ${finalAmountToken1.formatNumber(precision: 8)} ${liquidityRemove.token1!.symbol}',
            )
          else
            const Row(
              children: [
                SelectableText(
                  'Token obtained: ',
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ],
            ),
        if (timeout == false)
          if (finalAmountToken2 != null)
            SelectableText(
              'Token obtained: ${finalAmountToken2.formatNumber(precision: 8)} ${liquidityRemove.token2!.symbol}',
            )
          else
            const Row(
              children: [
                SelectableText(
                  'Token obtained: ',
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ],
            ),
        if (timeout == false)
          if (finalAmountLPToken != null)
            SelectableText(
              'LP Token burned: ${finalAmountLPToken.formatNumber(precision: 8)} ${finalAmountLPToken > 1 ? 'LP Tokens' : 'LP Token'}',
            )
          else
            const Row(
              children: [
                SelectableText(
                  'LP Token burned: ',
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ],
            ),
        if (timeout == true)
          const SelectableText(
            'Token obtained: The amounts could not be recovered',
          ),
      ],
    );
  }
}
