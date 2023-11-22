/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddInProgressResumeBtn extends ConsumerWidget {
  const PoolAddInProgressResumeBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    if (poolAdd.isProcessInProgress == false &&
        poolAdd.failure != null &&
        poolAdd.currentStep > 0) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_resume,
        icon: Iconsax.recovery_convert,
        onPressed: () async {
          ref
              .read(PoolAddFormProvider.poolAddForm.notifier)
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(PoolAddFormProvider.poolAddForm.notifier)
              .add(context, ref);
        },
      );
    }
    return const SizedBox.shrink();
  }
}
