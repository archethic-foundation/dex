/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap_confirmation/swap_confirmation_popup.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapValidationButton extends ConsumerWidget {
  const SwapValidationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.isControlsOk == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!
            .btn_swap_insufficient_balance
            .replaceAll('%1', swap.tokenToSwap),
        icon: Iconsax.empty_wallet,
        disabled: true,
      );
    }

    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_connect_wallet,
        icon: Iconsax.empty_wallet,
      );
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_swap,
      icon: Iconsax.arrange_circle_2,
      onPressed: () {
        SwapConfirmationPopup.getDialog(
          context,
        );
      },
    );
  }
}
