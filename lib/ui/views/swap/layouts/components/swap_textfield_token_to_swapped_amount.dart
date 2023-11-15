/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late TextEditingController tokenSwappedAmountController;
  late FocusNode tokenSwappedAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenSwappedAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  @override
  void dispose() {
    tokenSwappedAmountFocusNode.dispose();
    tokenSwappedAmountController.dispose();
    super.dispose();
  }

  void _updateAmountTextController() {
    final swap = ref.read(SwapFormProvider.swapForm);
    tokenSwappedAmountController = TextEditingController();
    tokenSwappedAmountController.value =
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
  Widget build(
    BuildContext context,
  ) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    final swapNotifier = ref.watch(SwapFormProvider.swapForm.notifier);

    final swap = ref.watch(SwapFormProvider.swapForm);
    final textNum = double.tryParse(tokenSwappedAmountController.text);
    if (textNum == null && swap.tokenSwappedAmount != 0.0) {
      _updateAmountTextController();
    } else {
      if (textNum != null && swap.tokenSwappedAmount != textNum) {
        _updateAmountTextController();
      }
    }

    return SizedBox(
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
                          color: Theme.of(context).colorScheme.primaryContainer,
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
                      child: TextField(
                        style: textTheme.titleMedium,
                        autocorrect: false,
                        controller: tokenSwappedAmountController,
                        onChanged: (text) async {
                          swapNotifier.setTokenSwappedAmount(
                            double.tryParse(text.replaceAll(' ', '')) ?? 0,
                          );
                        },
                        focusNode: tokenSwappedAmountFocusNode,
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
                          contentPadding: EdgeInsets.only(left: 10),
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
    );
  }
}
