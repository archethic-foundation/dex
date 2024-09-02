import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInProgressTxAddresses extends ConsumerWidget {
  const SwapInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.swapOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (swap.recoveryTransactionSwap != null &&
            swap.recoveryTransactionSwap!.address != null &&
            swap.recoveryTransactionSwap!.address!.address != null)
          FormatAddressLinkCopy(
            address:
                swap.recoveryTransactionSwap!.address!.address!.toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.aeswap_swapInProgressTxAddresses} ',
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
