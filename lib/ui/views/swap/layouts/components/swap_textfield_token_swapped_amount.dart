/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_token_swapped_selection.dart';
import 'package:aedex/ui/views/util/components/dex_btn_half.dart';
import 'package:aedex/ui/views/util/components/dex_btn_max.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenSwappedAmount extends ConsumerStatefulWidget {
  const SwapTokenSwappedAmount({
    super.key,
  });

  @override
  ConsumerState<SwapTokenSwappedAmount> createState() =>
      _SwapTokenSwappedAmountState();
}

class _SwapTokenSwappedAmountState
    extends ConsumerState<SwapTokenSwappedAmount> {
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
        text: swap.tokenSwappedAmount == 0
            ? ''
            : swap.tokenSwappedAmount.toString(),
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

    if (swap.tokenFormSelected == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tokenAmountFocusNode.requestFocus();
      });
    }

    final textNum = double.tryParse(tokenAmountController.text);
    if (swap.tokenSwappedAmount == 0.0 &&
        tokenAmountController.text != '' &&
        (textNum == null || textNum != 0)) {
      _updateAmountTextController();
    }
    if (swap.tokenSwappedAmount != 0.0 && textNum != swap.tokenSwappedAmount) {
      _updateAmountTextController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.swapToEstimatedLbl,
          style: Theme.of(context).textTheme.bodyLarge,
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
                            mainAxisAlignment: MainAxisAlignment.end,
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
                                            .setTokenFormSelected(2);
                                        await swapNotifier
                                            .setTokenSwappedAmount(
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
                                            .setTokenFormSelected(2);
                                      },
                                      focusNode: tokenAmountFocusNode,
                                      textAlign: TextAlign.left,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: <TextInputFormatter>[
                                        AmountTextInputFormatter(precision: 8),
                                        LengthLimitingTextInputFormatter(
                                          swap.tokenSwappedBalance
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
                if (swap.tokenSwapped != null)
                  Positioned(
                    top: 14,
                    right: 10,
                    child: FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        swap.tokenSwapped!,
                        swap.tokenSwappedAmount,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyLarge,
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
              child: SwapTokenSwappedSelection(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DexTokenBalance(
              tokenBalance: swap.tokenSwappedBalance,
              token: swap.tokenSwapped,
            ),
            if (swap.tokenSwappedBalance > 0)
              Row(
                children: [
                  DexButtonHalf(
                    balanceAmount: swap.tokenSwappedBalance,
                    onTap: () {
                      ref
                          .read(
                            SwapFormProvider.swapForm.notifier,
                          )
                          .setTokenFormSelected(2);
                      ref
                          .read(SwapFormProvider.swapForm.notifier)
                          .setTokenSwappedAmountHalf();
                      _updateAmountTextController();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DexButtonMax(
                    balanceAmount: swap.tokenSwappedBalance,
                    onTap: () {
                      ref
                          .read(
                            SwapFormProvider.swapForm.notifier,
                          )
                          .setTokenFormSelected(2);
                      ref
                          .read(SwapFormProvider.swapForm.notifier)
                          .setTokenSwappedAmountMax();
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
