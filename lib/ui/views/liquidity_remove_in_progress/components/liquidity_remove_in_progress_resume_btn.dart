/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveInProgressResumeBtn extends ConsumerWidget {
  const LiquidityRemoveInProgressResumeBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    if (liquidityRemove.isProcessInProgress == false &&
        liquidityRemove.failure != null &&
        liquidityRemove.currentStep > 0) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_resume,
        icon: Iconsax.recovery_convert,
        onPressed: () async {
          ref
              .read(LiquidityRemoveFormProvider.liquidityRemoveForm.notifier)
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(LiquidityRemoveFormProvider.liquidityRemoveForm.notifier)
              .remove(context, ref);
        },
      );
    }
    return const SizedBox.shrink();
  }
}
