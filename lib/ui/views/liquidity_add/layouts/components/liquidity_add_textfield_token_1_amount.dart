/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/state.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddToken1Amount extends ConsumerStatefulWidget {
  const LiquidityAddToken1Amount({
    super.key,
  });

  @override
  ConsumerState<LiquidityAddToken1Amount> createState() =>
      _LiquidityAddToken1AmountState();
}

class _LiquidityAddToken1AmountState
    extends ConsumerState<LiquidityAddToken1Amount> {
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
        text: liquidityAdd.token1Amount == 0
            ? ''
            : liquidityAdd.token1Amount.toString(),
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

    final liquidityAddNotifier =
        ref.watch(LiquidityAddFormProvider.liquidityAddForm.notifier);

    final liquidityAdd = ref.read(LiquidityAddFormProvider.liquidityAddForm);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(liquidityAdd.token1Amount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
      _updateAmountTextController();
    }

    ref.listen<LiquidityAddFormState>(
      LiquidityAddFormProvider.liquidityAddForm,
      (_, liquidityAdd) {
        log('liquidityAdd.token1Amount.toString() ${liquidityAdd.token1Amount} - tokenAmountController.text ${tokenAmountController.text}');
        if (liquidityAdd.token1Amount.toString() !=
            tokenAmountController.text) {
          tokenAmountController.text = liquidityAdd.token1Amount.toString();
        }
      },
    );

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
                        style: textTheme.titleLarge,
                        autocorrect: false,
                        controller: tokenAmountController,
                        onChanged: (text) async {
                          await liquidityAddNotifier.setToken1Amount(
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
    );
  }
}
