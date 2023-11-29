/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_change.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_icon_settings.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_to_swap_selection.dart';
import 'package:aedex/ui/views/util/components/dex_btn_half.dart';
import 'package:aedex/ui/views/util/components/dex_btn_max.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.swapFromLbl),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.slippage_tolerance} ${swap.slippageTolerance}%',
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: SwapTokenIconSettings(),
                ),
              ],
            ),
          ],
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Stack(
              alignment: Alignment.centerRight,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      autocorrect: false,
                                      controller: tokenAmountController,
                                      onChanged: (text) async {
                                        ref
                                            .read(
                                              SwapFormProvider
                                                  .swapForm.notifier,
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
                                              SwapFormProvider
                                                  .swapForm.notifier,
                                            )
                                            .setTokenFormSelected(1);
                                      },
                                      focusNode: tokenAmountFocusNode,
                                      textAlign: TextAlign.left,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: <TextInputFormatter>[
                                        AmountTextInputFormatter(precision: 8),
                                        LengthLimitingTextInputFormatter(
                                          swap.tokenToSwapBalance
                                                  .formatNumber(precision: 0)
                                                  .length +
                                              8 +
                                              1,
                                        ),
                                      ],
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
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
                if (swap.tokenToSwap != null)
                  Positioned(
                    top: 14,
                    right: 10,
                    child: FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        swap.tokenToSwap!.symbol,
                        swap.tokenToSwapAmount,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.titleMedium,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: SwapTokenToSwapSelection(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DexTokenBalance(
              tokenBalance: swap.tokenToSwapBalance,
              tokenSymbol:
                  swap.tokenToSwap == null ? '' : swap.tokenToSwap!.symbol,
            ),
            if (swap.tokenToSwapBalance > 0)
              Row(
                children: [
                  const SwapChange(),
                  const SizedBox(
                    width: 10,
                  ),
                  DexButtonHalf(
                    balanceAmount: swap.tokenToSwapBalance,
                    onTap: () {
                      ref
                          .read(
                            SwapFormProvider.swapForm.notifier,
                          )
                          .setTokenFormSelected(1);
                      ref
                          .read(SwapFormProvider.swapForm.notifier)
                          .setTokenToSwapAmountHalf();
                      _updateAmountTextController();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DexButtonMax(
                    balanceAmount: swap.tokenToSwapBalance,
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
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
