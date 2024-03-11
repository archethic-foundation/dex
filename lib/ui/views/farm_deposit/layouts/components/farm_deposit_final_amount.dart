import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositFinalAmount extends ConsumerWidget {
  const FarmDepositFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.farmDepositOk == false) return const SizedBox.shrink();

    final finalAmount = farmDeposit.finalAmount;
    final timeout = ref.watch(
      FarmDepositFormProvider.farmDepositForm
          .select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            'Amount deposited: ${finalAmount.formatNumber(precision: 8)} ${finalAmount > 1 ? 'LP Tokens' : 'LP Token'}',
          )
        : timeout == false
            ? const Row(
                children: [
                  SelectableText(
                    'Amount deposited: ',
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ],
              )
            : const SelectableText(
                'Amount deposited: The amount could not be recovered',
              );
  }
}
