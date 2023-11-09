/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveConfirmBackButton extends ConsumerWidget {
  const LiquidityRemoveConfirmBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    return Stack(
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.liquidityRemoveConfirmTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        TextButton(
          onPressed: liquidityRemove.lpToken == null
              ? null
              : () {
                  ref
                      .read(
                        LiquidityRemoveFormProvider
                            .liquidityRemoveForm.notifier,
                      )
                      .setLiquidityRemoveProcessStep(
                        LiquidityRemoveProcessStep.form,
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
