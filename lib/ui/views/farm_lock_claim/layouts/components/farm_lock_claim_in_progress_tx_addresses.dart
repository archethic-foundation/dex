import 'package:aedex/ui/views/farm_lock_claim/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockClaimInProgressTxAddresses extends ConsumerWidget {
  const FarmLockClaimInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockClaim =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm);
    if (farmLockClaim.farmLockClaimOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (farmLockClaim.transactionClaimFarm != null &&
            farmLockClaim.transactionClaimFarm!.address != null &&
            farmLockClaim.transactionClaimFarm!.address!.address != null)
          FormatAddressLinkCopy(
            address: farmLockClaim.transactionClaimFarm!.address!.address!
                .toUpperCase(),
            header: AppLocalizations.of(context)!.farmLockClaimTxAddress,
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
