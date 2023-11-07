/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddButton extends ConsumerWidget {
  const PoolAddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
    if (refund.evmWallet == null ||
        refund.evmWallet!.isConnected == false ||
        refund.htlcAddress.isEmpty ||
        refund.refundTxAddress != null ||
        (refund.isAlreadyRefunded != null &&
            refund.isAlreadyRefunded == true)) {
      return const SizedBox.shrink();
    }

    return poolAdd.htlcCanRefund == false
        ? AppButton(
            labelBtn: AppLocalizations.of(context)!.btn_pool_add,
            icon: Iconsax.empty_wallet_change,
            disabled: true,
          )
        : AppButton(
            labelBtn: AppLocalizations.of(context)!.btn_pool_add,
            icon: Iconsax.empty_wallet_change,
            onPressed: () async {
              final refundNotifier =
                  ref.read(RefundFormProvider.refundForm.notifier);
              unawaited(refundNotifier.refund(context, ref));
              await RefundInProgressPopup.getDialog(
                context,
                ref,
              );
            },
          );
  }
}
