import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveInProgressTxAddresses extends ConsumerWidget {
  const LiquidityRemoveInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    if (liquidityRemove.liquidityRemoveOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (liquidityRemove.transactionRemoveLiquidity != null &&
            liquidityRemove.transactionRemoveLiquidity!.address != null &&
            liquidityRemove.transactionRemoveLiquidity!.address!.address !=
                null)
          FormatAddressLinkCopy(
            address: liquidityRemove
                .transactionRemoveLiquidity!.address!.address!
                .toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.liquidityRemoveInProgressTxAddresses} ',
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
