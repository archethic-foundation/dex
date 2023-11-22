/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove_in_progress/liquidity_remove_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveConfirmBtn extends ConsumerWidget {
  const LiquidityRemoveConfirmBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_confirm_liquidity_remove,
      icon: Iconsax.tick_square,
      onPressed: () async {
        final liquidityRemoveNotifier =
            ref.read(LiquidityRemoveFormProvider.liquidityRemoveForm.notifier);
        unawaited(liquidityRemoveNotifier.remove(context, ref));
        await LiquidityRemoveInProgressPopup.getDialog(
          context,
          ref,
        );
      },
    );
  }
}
