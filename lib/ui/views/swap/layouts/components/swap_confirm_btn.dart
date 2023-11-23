/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap_in_progress/swap_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapConfirmBtn extends ConsumerWidget {
  const SwapConfirmBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_confirm_swap,
      icon: Iconsax.tick_square,
      onPressed: () async {
        final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);
        unawaited(swapNotifier.swap(context, ref));
        await SwapInProgressPopup.getDialog(
          context,
          ref,
        );
      },
    );
  }
}
