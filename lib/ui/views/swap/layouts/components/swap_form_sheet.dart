import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_balance_max_btn.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_conversion_info.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_icon_direction.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_icon_settings.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_pool_address.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_to_swap_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_to_swapped_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_swapped_amount_fiat.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_swapped_balance.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_swapped_selection.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_to_swap_amount_fiat.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_to_swap_balance.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_to_swap_selection.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_validation_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapFormSheet extends ConsumerWidget {
  const SwapFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.read(SwapFormProvider.swapForm);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
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
            padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
            child: Column(
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
                const Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    SwapTokenToSwapAmount(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: SwapTokenToSwapSelection(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SwapTokenToSwapAmountFiat(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SwapTokenToSwapBalance(),
                        SizedBox(
                          width: 5,
                        ),
                        SwapBalanceMaxButton(),
                      ],
                    ),
                  ],
                ),
                const SwapTokenIconDirection(),
                const SizedBox(
                  height: 10,
                ),
                const Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    SwapTokenSwappedAmount(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: SwapTokenSwappedSelection(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SwapTokenSwappedAmountFiat(),
                    SwapTokenSwappedBalance(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SwapConversionInfo(),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SwapPoolAddress(),
                ),
                const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                const SwapValidationButton(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
