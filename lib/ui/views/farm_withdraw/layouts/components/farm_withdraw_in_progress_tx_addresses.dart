import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawInProgressTxAddresses extends ConsumerWidget {
  const FarmWithdrawInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.farmWithdrawOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (farmWithdraw.transactionWithdrawFarm != null &&
            farmWithdraw.transactionWithdrawFarm!.address != null &&
            farmWithdraw.transactionWithdrawFarm!.address!.address != null)
          FormatAddressLinkCopy(
            address: farmWithdraw.transactionWithdrawFarm!.address!.address!
                .toUpperCase(),
            header: AppLocalizations.of(context)!.farmWithdrawTxAddress,
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
