/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapButton extends ConsumerWidget {
  const SwapButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.isControlsOk == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_swap,
        icon: Iconsax.arrange_circle_2,
        disabled: true,
      );
    }

    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_swap,
        icon: Iconsax.arrange_circle_2,
        disabled: true,
      );
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_swap,
      icon: Iconsax.arrange_circle_2,
      onPressed: () {
        ref.read(SwapFormProvider.swapForm.notifier).validateForm(context);
      },
    );
  }
}
