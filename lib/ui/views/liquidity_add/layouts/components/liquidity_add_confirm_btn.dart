/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddConfirmBtn extends ConsumerWidget {
  const LiquidityAddConfirmBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_confirm_liquidity_add,
      icon: Iconsax.tick_square,
      onPressed: () async {
        final liquidityAddNotifier =
            ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier);
        unawaited(liquidityAddNotifier.add(context, ref));
        await LiquidityAddInProgressPopup.getDialog(
          context,
          ref,
        );
      },
    );
  }
}
