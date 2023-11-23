/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_2_selection.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddToken2Amount extends ConsumerStatefulWidget {
  const PoolAddToken2Amount({
    super.key,
  });

  @override
  ConsumerState<PoolAddToken2Amount> createState() =>
      _PoolAddToken2AmountState();
}

class _PoolAddToken2AmountState extends ConsumerState<PoolAddToken2Amount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final poolAdd = ref.read(PoolAddFormProvider.poolAddForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: poolAdd.token2Amount == 0 ? '' : poolAdd.token2Amount.toString(),
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

    final poolAddNotifier = ref.watch(PoolAddFormProvider.poolAddForm.notifier);

    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    if (poolAdd.tokenFormSelected == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tokenAmountFocusNode.requestFocus();
      });
    }

    final textNum = double.tryParse(tokenAmountController.text);
    if (!(poolAdd.token2Amount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
      _updateAmountTextController();
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
                                  style: textTheme.titleMedium,
                                  autocorrect: false,
                                  controller: tokenAmountController,
                                  onChanged: (text) async {
                                    ref
                                        .read(
                                          PoolAddFormProvider
                                              .poolAddForm.notifier,
                                        )
                                        .setTokenFormSelected(2);
                                    poolAddNotifier.setToken2Amount(
                                      double.tryParse(
                                            text.replaceAll(' ', ''),
                                          ) ??
                                          0,
                                    );
                                  },
                                  onTap: () {
                                    ref
                                        .read(
                                          PoolAddFormProvider
                                              .poolAddForm.notifier,
                                        )
                                        .setTokenFormSelected(2);
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
              child: PoolAddToken2Selection(),
            ),
            if (poolAdd.token2Balance > 0)
              Container(
                padding: const EdgeInsets.only(
                  top: 3,
                  left: 540,
                ),
                child: InkWell(
                  onTap: () {
                    ref
                        .read(
                          PoolAddFormProvider.poolAddForm.notifier,
                        )
                        .setTokenFormSelected(2);
                    ref
                        .read(PoolAddFormProvider.poolAddForm.notifier)
                        .setToken2AmountMax();
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
        Row(
          children: [
            DexTokenBalance(
              tokenBalance: poolAdd.token2Balance,
              tokenSymbol: poolAdd.token2 == null ? '' : poolAdd.token2!.symbol,
            ),
          ],
        ),
      ],
    );
  }
}
