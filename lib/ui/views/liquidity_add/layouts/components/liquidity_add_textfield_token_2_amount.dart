/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_btn_half.dart';
import 'package:aedex/ui/views/util/components/dex_btn_max.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddToken2Amount extends ConsumerStatefulWidget {
  const LiquidityAddToken2Amount({
    super.key,
  });

  @override
  ConsumerState<LiquidityAddToken2Amount> createState() =>
      _LiquidityAddToken2AmountState();
}

class _LiquidityAddToken2AmountState
    extends ConsumerState<LiquidityAddToken2Amount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final liquidityAdd = ref.read(LiquidityAddFormProvider.liquidityAddForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: liquidityAdd.token2Amount == 0
            ? ''
            : liquidityAdd.token2Amount.toString(),
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
    final liquidityAddNotifier =
        ref.watch(LiquidityAddFormProvider.liquidityAddForm.notifier);

    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    final textNum = double.tryParse(tokenAmountController.text);
    if (liquidityAdd.token2Amount == 0.0 &&
        tokenAmountController.text != '' &&
        (textNum == null || textNum != 0)) {
      _updateAmountTextController();
    }
    if (liquidityAdd.token2Amount != 0.0 &&
        textNum != liquidityAdd.token2Amount) {
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
                          child: liquidityAdd.calculateToken2
                              ? const SizedBox(
                                  width: 10,
                                  height: 48,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 560,
                                      top: 15,
                                      bottom: 15,
                                    ),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : TextField(
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  autocorrect: false,
                                  controller: tokenAmountController,
                                  onChanged: (text) async {
                                    await liquidityAddNotifier.setToken2Amount(
                                      double.tryParse(
                                            text.replaceAll(' ', ''),
                                          ) ??
                                          0,
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
              tokenBalance: liquidityAdd.token2Balance,
              token: liquidityAdd.token2,
            ),
            Row(
              children: [
                DexButtonHalf(
                  balanceAmount: liquidityAdd.token2Balance,
                  onTap: () => ref
                      .read(
                        LiquidityAddFormProvider.liquidityAddForm.notifier,
                      )
                      .setToken2AmountHalf(),
                ),
                const SizedBox(
                  width: 10,
                ),
                DexButtonMax(
                  balanceAmount: liquidityAdd.token2Balance,
                  onTap: () => ref
                      .read(
                        LiquidityAddFormProvider.liquidityAddForm.notifier,
                      )
                      .setToken2AmountMax(ref),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
