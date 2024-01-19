import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_btn_half.dart';
import 'package:aedex/ui/views/util/components/dex_btn_max.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveLPTokenAmount extends ConsumerStatefulWidget {
  const LiquidityRemoveLPTokenAmount({
    super.key,
  });

  @override
  ConsumerState<LiquidityRemoveLPTokenAmount> createState() =>
      _LiquidityRemoveLPTokenAmountState();
}

class _LiquidityRemoveLPTokenAmountState
    extends ConsumerState<LiquidityRemoveLPTokenAmount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final liquidityRemove =
        ref.read(LiquidityRemoveFormProvider.liquidityRemoveForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: liquidityRemove.lpTokenAmount == 0
            ? ''
            : liquidityRemove.lpTokenAmount.toString(),
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
    final liquidityRemoveNotifier =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm.notifier);

    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(liquidityRemove.lpTokenAmount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
      _updateAmountTextController();
    }

    return Column(
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
                          child: TextField(
                            style: Theme.of(context).textTheme.titleMedium,
                            autocorrect: false,
                            controller: tokenAmountController,
                            onChanged: (text) async {
                              await liquidityRemoveNotifier.setLPTokenAmount(
                                double.tryParse(text.replaceAll(' ', '')) ?? 0,
                              );
                            },
                            focusNode: tokenAmountFocusNode,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              AmountTextInputFormatter(precision: 8),
                              LengthLimitingTextInputFormatter(10),
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
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DexTokenBalance(
              tokenBalance: liquidityRemove.lpTokenBalance,
              tokenSymbol: liquidityRemove.lpToken == null
                  ? ''
                  : liquidityRemove.lpToken!.symbol,
            ),
            Row(
              children: [
                DexButtonHalf(
                  balanceAmount: liquidityRemove.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          LiquidityRemoveFormProvider
                              .liquidityRemoveForm.notifier,
                        )
                        .setLpTokenAmountHalf();
                    _updateAmountTextController();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                DexButtonMax(
                  balanceAmount: liquidityRemove.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          LiquidityRemoveFormProvider
                              .liquidityRemoveForm.notifier,
                        )
                        .setLpTokenAmountMax();
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
