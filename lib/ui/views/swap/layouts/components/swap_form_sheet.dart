import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_btn.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_error_message.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_icon_settings.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_swapped_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_to_swap_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapFormSheet extends ConsumerWidget {
  const SwapFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SelectionArea(
                    child: Text(
                      AppLocalizations.of(context)!.swapFormTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: DexThemeBase.gradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.swap_settings_slippage_tolerance} ${swap.slippageTolerance}%',
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: SwapTokenIconSettings(),
                          ),
                        ],
                      ),
                      const SwapTokenToSwapAmount(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SwapTokenSwappedAmount(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SwapErrorMessage(),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwapButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
