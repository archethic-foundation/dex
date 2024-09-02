import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositInProgressTxAddresses extends ConsumerWidget {
  const FarmDepositInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.farmDepositOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (farmDeposit.transactionDepositFarm != null &&
            farmDeposit.transactionDepositFarm!.address != null &&
            farmDeposit.transactionDepositFarm!.address!.address != null)
          FormatAddressLinkCopy(
            address: farmDeposit.transactionDepositFarm!.address!.address!
                .toUpperCase(),
            header: AppLocalizations.of(context)!.aeswap_farmDepositTxAddress,
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
