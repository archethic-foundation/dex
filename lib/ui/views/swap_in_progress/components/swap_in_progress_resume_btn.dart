/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInProgressResumeBtn extends ConsumerWidget {
  const SwapInProgressResumeBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.isProcessInProgress == false &&
        swap.failure != null &&
        swap.currentStep > 0) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_resume,
        icon: Iconsax.recovery_convert,
        onPressed: () async {
          ref.read(SwapFormProvider.swapForm.notifier).setResumeProcess(true);

          if (!context.mounted) return;
          await ref.read(SwapFormProvider.swapForm.notifier).swap(context, ref);
        },
      );
    }
    return const SizedBox.shrink();
  }
}
