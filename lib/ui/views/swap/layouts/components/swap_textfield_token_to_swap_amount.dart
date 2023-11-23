/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_to_swap_balance.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_to_swap_selection.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenToSwapAmount extends ConsumerStatefulWidget {
  const SwapTokenToSwapAmount({
    super.key,
  });

  @override
  ConsumerState<SwapTokenToSwapAmount> createState() =>
      _SwapTokenToSwapAmountState();
}

class _SwapTokenToSwapAmountState extends ConsumerState<SwapTokenToSwapAmount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final swap = ref.read(SwapFormProvider.swapForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: swap.tokenToSwapAmount == 0
            ? ''
            : swap.tokenToSwapAmount.toString(),
      ),
    );
  }

  @override
  void dispose() {
    tokenAmountFocusNode.dispose();
    tokenAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    final swapNotifier = ref.watch(SwapFormProvider.swapForm.notifier);

    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.tokenFormSelected == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tokenAmountFocusNode.requestFocus();
      });
    }

    final textNum = double.tryParse(tokenAmountController.text);
    if (textNum == null && swap.tokenToSwapAmount != 0.0) {
      _updateAmountTextController();
    } else {
      if (textNum != null && swap.tokenToSwapAmount != textNum) {
        _updateAmountTextController();
      }
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            SizedBox(
              width: DexThemeBase.sizeBoxComponentWidth,
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  width: 0.5,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(1),
                                    Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.3),
                                  ],
                                  stops: const [0, 1],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 160,
                                  right: 70,
                                ),
                                child: TextField(
                                  style: textTheme.titleMedium,
                                  autocorrect: false,
                                  controller: tokenAmountController,
                                  onChanged: (text) async {
                                    ref
                                        .read(
                                          SwapFormProvider.swapForm.notifier,
                                        )
                                        .setTokenFormSelected(1);
                                    await swapNotifier.setTokenToSwapAmount(
                                      double.tryParse(
                                            text.replaceAll(' ', ''),
                                          ) ??
                                          0,
                                    );
                                  },
                                  onTap: () {
                                    ref
                                        .read(
                                          SwapFormProvider.swapForm.notifier,
                                        )
                                        .setTokenFormSelected(1);
                                  },
                                  focusNode: tokenAmountFocusNode,
                                  textAlign: TextAlign.left,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    AmountTextInputFormatter(precision: 8),
                                  ],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: SwapTokenToSwapSelection(),
            ),
            if (swap.tokenToSwapBalance > 0)
              Container(
                padding: const EdgeInsets.only(
                  top: 3,
                  left: 540,
                ),
                child: InkWell(
                  onTap: () {
                    ref
                        .read(
                          SwapFormProvider.swapForm.notifier,
                        )
                        .setTokenFormSelected(1);
                    ref
                        .read(SwapFormProvider.swapForm.notifier)
                        .setTokenToSwapAmountMax();
                    _updateAmountTextController();
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
                ),
              ),
          ],
        ),
        const Row(
          children: [
            SwapTokenToSwapBalance(),
          ],
        ),
      ],
    );
  }
}
