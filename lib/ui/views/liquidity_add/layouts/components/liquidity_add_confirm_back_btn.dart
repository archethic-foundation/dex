/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddConfirmBackButton extends ConsumerWidget {
  const LiquidityAddConfirmBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    return Stack(
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.liquidityAddConfirmTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        TextButton(
          onPressed: liquidityAdd.token1 == null
              ? null
              : () {
                  ref
                      .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
                      .setLiquidityAddProcessStep(
                        LiquidityAddProcessStep.form,
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
