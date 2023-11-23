/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveButton extends ConsumerWidget {
  const LiquidityRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    if (liquidityRemove.isControlsOk == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_liquidity_remove,
        icon: Iconsax.wallet_money,
        disabled: true,
      );
    }

    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_liquidity_remove,
        icon: Iconsax.wallet_money,
        disabled: true,
      );
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_liquidity_remove,
      icon: Iconsax.wallet_money,
      onPressed: () {
        ref
            .read(LiquidityRemoveFormProvider.liquidityRemoveForm.notifier)
            .validateForm(context);
      },
    );
  }
}
