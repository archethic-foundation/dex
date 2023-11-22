/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddInProgressResumeBtn extends ConsumerWidget {
  const LiquidityAddInProgressResumeBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    if (liquidityAdd.isProcessInProgress == false &&
        liquidityAdd.failure != null &&
        liquidityAdd.currentStep > 0) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_resume,
        icon: Iconsax.recovery_convert,
        onPressed: () async {
          ref
              .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
              .add(context, ref);
        },
      );
    }
    return const SizedBox.shrink();
  }
}
