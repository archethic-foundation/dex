import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddInProgressTxAddresses extends ConsumerWidget {
  const PoolAddInProgressTxAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
    if (poolAdd.poolAddOk == false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (poolAdd.recoveryPoolGenesisAddress != null)
          FormatAddressLinkCopy(
            address: poolAdd.recoveryPoolGenesisAddress!.toUpperCase(),
            header: 'Pool genesis address: ',
            typeAddress: TypeAddressLinkCopy.chain,
            reduceAddress: true,
          ),
        if (poolAdd.recoveryTransactionAddPool != null &&
            poolAdd.recoveryTransactionAddPool!.address != null &&
            poolAdd.recoveryTransactionAddPool!.address!.address != null)
          FormatAddressLinkCopy(
            address: poolAdd.recoveryTransactionAddPool!.address!.address!
                .toUpperCase(),
            header: 'Pool registration transaction address: ',
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
        if (poolAdd.recoveryTransactionAddPoolTransfer != null &&
            poolAdd.recoveryTransactionAddPoolTransfer!.address != null &&
            poolAdd.recoveryTransactionAddPoolTransfer!.address!.address !=
                null)
          FormatAddressLinkCopy(
            address: poolAdd
                .recoveryTransactionAddPoolTransfer!.address!.address!
                .toUpperCase(),
            header: 'Pool funds transfer transaction address: ',
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
        if (poolAdd.recoveryTransactionAddPoolLiquidity != null &&
            poolAdd.recoveryTransactionAddPoolLiquidity!.address != null &&
            poolAdd.recoveryTransactionAddPoolLiquidity!.address!.address !=
                null)
          FormatAddressLinkCopy(
            address: poolAdd
                .recoveryTransactionAddPoolLiquidity!.address!.address!
                .toUpperCase(),
            header: 'Liquidity addition transaction address: ',
            typeAddress: TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
      ],
    );
  }
}
