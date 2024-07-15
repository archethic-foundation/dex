import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoAddresses extends ConsumerWidget {
  const PoolDetailsInfoAddresses({
    super.key,
    required this.pool,
  });

  final DexPool? pool;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormatAddressLinkCopy(
            address: pool!.poolAddress.toUpperCase(),
            header: AppLocalizations.of(context)!
                .poolDetailsInfoAddressesPoolAddress,
            typeAddress: TypeAddressLinkCopy.chain,
            reduceAddress: true,
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
          ),
          Row(
            children: [
              FormatAddressLinkCopy(
                header: AppLocalizations.of(context)!
                    .poolDetailsInfoAddressesLPAddress,
                address: pool!.lpToken.address!.toUpperCase(),
                typeAddress: TypeAddressLinkCopy.transaction,
                reduceAddress: true,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
              ),
            ],
          ),
          if (pool!.pair.token1.isUCO == false)
            Row(
              children: [
                Tooltip(
                  message: pool!.pair.token1.symbol,
                  child: FormatAddressLinkCopy(
                    header: AppLocalizations.of(context)!
                        .poolDetailsInfoAddressesToken1Address
                        .replaceFirst(
                          '%1',
                          pool!.pair.token1.symbol.reduceSymbol(),
                        ),
                    address: pool!.pair.token1.address!.toUpperCase(),
                    typeAddress: TypeAddressLinkCopy.transaction,
                    reduceAddress: true,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                VerifiedTokenIcon(
                  address: pool!.pair.token1.address!,
                ),
              ],
            )
          else
            const SizedBox(height: 20),
          if (pool!.pair.token2.isUCO == false)
            Row(
              children: [
                Tooltip(
                  message: pool!.pair.token2.symbol,
                  child: FormatAddressLinkCopy(
                    header: AppLocalizations.of(context)!
                        .poolDetailsInfoAddressesToken2Address
                        .replaceFirst(
                          '%1',
                          pool!.pair.token2.symbol.reduceSymbol(),
                        ),
                    address: pool!.pair.token2.address!.toUpperCase(),
                    typeAddress: TypeAddressLinkCopy.transaction,
                    reduceAddress: true,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                VerifiedTokenIcon(
                  address: pool!.pair.token2.address!,
                ),
              ],
            )
          else
            const SizedBox(height: 20),
        ],
      ),
    );
  }
}
