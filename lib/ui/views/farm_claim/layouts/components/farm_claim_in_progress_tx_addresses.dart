import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimInProgressTxAddresses extends ConsumerWidget {
  const FarmClaimInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    if (farmClaim.farmClaimOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (farmClaim.transactionClaimFarm != null &&
            farmClaim.transactionClaimFarm!.address != null &&
            farmClaim.transactionClaimFarm!.address!.address != null)
          FormatAddressLinkCopy(
            address:
                farmClaim.transactionClaimFarm!.address!.address!.toUpperCase(),
            header: AppLocalizations.of(context)!.aeswap_farmClaimTxAddress,
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
