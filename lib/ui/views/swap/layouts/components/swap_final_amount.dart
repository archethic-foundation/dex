import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapFinalAmount extends ConsumerWidget {
  const SwapFinalAmount({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.swapOk == false) return const SizedBox.shrink();

    final finalAmount = ref.watch(SwapFormProvider.swapForm).finalAmount;
    final timeout = ref.watch(
      SwapFormProvider.swapForm.select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            'Final amount swapped: ${finalAmount.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
          )
        : timeout == false
            ? const Row(
                children: [
                  SelectableText(
                    'Final amount swapped: ',
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ],
              )
            : const SelectableText(
                'Final amount swapped: The amount could not be recovered',
              );
  }
}
