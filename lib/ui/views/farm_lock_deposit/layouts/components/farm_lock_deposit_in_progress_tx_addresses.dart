import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositInProgressTxAddresses extends ConsumerWidget {
  const FarmLockDepositInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockDeposit =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);
    if (farmLockDeposit.farmLockDepositOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (farmLockDeposit.transactionFarmLockDeposit != null &&
            farmLockDeposit.transactionFarmLockDeposit!.address != null &&
            farmLockDeposit.transactionFarmLockDeposit!.address!.address !=
                null)
          FormatAddressLinkCopy(
            address: farmLockDeposit
                .transactionFarmLockDeposit!.address!.address!
                .toUpperCase(),
            header: AppLocalizations.of(context)!.farmLockDepositTxAddress,
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
