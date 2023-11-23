/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenToSwapBalance extends ConsumerWidget {
  const SwapTokenToSwapBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.tokenToSwap == null) {
      return const SizedBox(
        height: 30,
      );
    }

    return SizedBox(
      height: 30,
      child: Text(
        '${AppLocalizations.of(context)!.balance_title_infos} ${swap.tokenToSwapBalance.formatNumber()} ${swap.tokenToSwap!.symbol}',
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
