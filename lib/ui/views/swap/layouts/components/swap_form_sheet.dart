import 'package:aedex/ui/views/swap/layouts/components/swap_balance_max_btn.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_conversion_info.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_icon_direction.dart';
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
import 'package:gradient_borders/gradient_borders.dart';

class SwapFormSheet extends ConsumerWidget {
  const SwapFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            border: const GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Color(0x003C89B9),
                  Color(0xFFCC00FF),
                ],
                stops: [0, 1],
              ),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Container(
          width: 500,
          height: 450,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background.withOpacity(0.4),
                Theme.of(context).colorScheme.background.withOpacity(0.1),
              ],
              stops: const [0, 1],
            ),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.background.withOpacity(0.4),
                  Theme.of(context).colorScheme.background.withOpacity(0.9),
                ],
                stops: const [0, 1],
              ),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
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
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x003C89B9),
                              Color(0xFFCC00FF),
                            ],
                            stops: [0, 1],
                            begin: AlignmentDirectional.centerEnd,
                            end: AlignmentDirectional.centerStart,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 50, right: 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
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
                        )
                      ],
                    ),
                    SwapTokenIconDirection(),
                    Stack(
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SwapTokenSwappedAmountFiat(),
                        SwapTokenSwappedBalance(),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SwapConversionInfo(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SwapValidationButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
