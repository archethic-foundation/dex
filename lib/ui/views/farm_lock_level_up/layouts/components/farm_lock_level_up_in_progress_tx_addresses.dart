import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockLevelUpInProgressTxAddresses extends ConsumerWidget {
  const FarmLockLevelUpInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockLevelUp =
        ref.watch(FarmLockLevelUpFormProvider.farmLockLevelUpForm);
    if (farmLockLevelUp.farmLockLevelUpOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (farmLockLevelUp.transactionFarmLockLevelUp != null &&
            farmLockLevelUp.transactionFarmLockLevelUp!.address != null &&
            farmLockLevelUp.transactionFarmLockLevelUp!.address!.address !=
                null)
          FormatAddressLinkCopy(
            address: farmLockLevelUp
                .transactionFarmLockLevelUp!.address!.address!
                .toUpperCase(),
            header: AppLocalizations.of(context)!.farmLockLevelUpTxAddress,
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
