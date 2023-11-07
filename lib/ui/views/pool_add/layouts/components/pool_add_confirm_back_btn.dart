/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmBackButton extends ConsumerWidget {
  const PoolAddConfirmBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    return Stack(
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.poolAddConfirmTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        TextButton(
          onPressed: poolAdd.token1 == null
              ? null
              : () {
                  ref
                      .read(PoolAddFormProvider.poolAddForm.notifier)
                      .setPoolAddProcessStep(
                        PoolAddProcessStep.form,
                      );
                },
          child: Text(
            '< ${AppLocalizations.of(context)!.btn_back}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
