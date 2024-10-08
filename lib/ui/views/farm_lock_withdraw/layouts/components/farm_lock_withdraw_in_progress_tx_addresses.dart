import 'package:aedex/ui/views/farm_lock_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockWithdrawInProgressTxAddresses extends ConsumerWidget {
  const FarmLockWithdrawInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
    if (farmLockWithdraw.farmLockWithdrawOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (farmLockWithdraw.transactionWithdrawFarmLock != null &&
            farmLockWithdraw.transactionWithdrawFarmLock!.address != null &&
            farmLockWithdraw.transactionWithdrawFarmLock!.address!.address !=
                null)
          FormatAddressLinkCopy(
            address: farmLockWithdraw
                .transactionWithdrawFarmLock!.address!.address!
                .toUpperCase(),
            header: AppLocalizations.of(context)!.farmLockWithdrawTxAddress,
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
