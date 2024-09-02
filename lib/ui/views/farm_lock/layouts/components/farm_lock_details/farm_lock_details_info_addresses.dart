import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoAddresses extends ConsumerWidget {
  const FarmLockDetailsInfoAddresses({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormatAddressLinkCopy(
              address: farmLock.farmAddress.toUpperCase(),
              header: AppLocalizations.of(context)!
                  .aeswap_farmDetailsInfoAddressesFarmAddress,
              typeAddress: TypeAddressLinkCopy.chain,
              reduceAddress: true,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
            const SizedBox(
              width: 10,
            ),
            FormatAddressLinkCopy(
              address: farmLock.lpToken!.address!.toUpperCase(),
              header: AppLocalizations.of(context)!
                  .aeswap_farmDetailsInfoAddressesLPAddress,
              typeAddress: TypeAddressLinkCopy.chain,
              reduceAddress: true,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
          ],
        ),
      ],
    );
  }
}
