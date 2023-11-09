/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddToken2MaxButton extends ConsumerWidget {
  const LiquidityAddToken2MaxButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token2Balance <= 0) {
      return const SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        ref
            .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
            .setToken2AmountMax();
      },
      child: Text(
        AppLocalizations.of(context)!.btn_max,
        style: TextStyle(color: DexThemeBase.maxButtonColor),
      )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 500),
          )
          .scale(
            duration: const Duration(milliseconds: 500),
          ),
    );
  }
}
