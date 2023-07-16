/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapBalanceMaxButton extends ConsumerWidget {
  const SwapBalanceMaxButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    // TODO(reddwarf03): Change the condition
    if (swap.tokenToSwapBalance > 0) {
      return const SizedBox();
    }

    return InkWell(
      onTap: () {},
      child: Text(
        AppLocalizations.of(context)!.btn_max,
        style: TextStyle(color: ThemeBase.maxButtonColor),
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
