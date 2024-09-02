import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddInProgressTxAddresses extends ConsumerWidget {
  const LiquidityAddInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.liquidityAddOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (liquidityAdd.transactionAddLiquidity != null &&
            liquidityAdd.transactionAddLiquidity!.address != null &&
            liquidityAdd.transactionAddLiquidity!.address!.address != null)
          FormatAddressLinkCopy(
            address: liquidityAdd.transactionAddLiquidity!.address!.address!
                .toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.aeswap_liquidityAddInProgresstxAddresses} ',
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
