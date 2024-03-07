import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddFinalAmount extends ConsumerWidget {
  const LiquidityAddFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.liquidityAddOk == false) return const SizedBox.shrink();

    final finalAmount = liquidityAdd.finalAmount;
    final timeout = ref.watch(
      LiquidityAddFormProvider.liquidityAddForm
          .select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            'LP Tokens obtained: ${finalAmount.formatNumber(precision: 8)} ${finalAmount > 1 ? 'LP Tokens' : 'LP Token'}',
          )
        : timeout == false
            ? const Row(
                children: [
                  SelectableText(
                    'LP Tokens obtained: ',
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ],
              )
            : const SelectableText(
                'LP Tokens obtained: The amount could not be recovered',
              );
  }
}
