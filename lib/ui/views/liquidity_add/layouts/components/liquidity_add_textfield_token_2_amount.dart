/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
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

  @override
  void initState() {
    super.initState();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final liquidityAdd = ref.read(LiquidityAddFormProvider.liquidityAddForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = aedappfm.AmountTextInputFormatter(
      precision: 8,
      thousandsSeparator: ',',
      useUnifyDecimalSeparator: false,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: liquidityAdd.token2Amount == 0
            ? ''
            : liquidityAdd.token2Amount
                .formatNumber(precision: 8)
                .replaceAll(',', ''),
      ),
    );
  }

  @override
  void dispose() {
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

    if (liquidityAdd.tokenFormSelected != 2) {
      _updateAmountTextController();
    }

    return Column(
      children: [
        SizedBox(
          width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .titleMedium!,
                                        ),
                                      ),
                                  autocorrect: false,
                                  controller: tokenAmountController,
                                  onChanged: (text) async {
                                    liquidityAddNotifier
                                        .setTokenFormSelected(2);
                                    await liquidityAddNotifier.setToken2Amount(
                                      context,
                                      double.tryParse(
                                            text.replaceAll(',', ''),
                                          ) ??
                                          0,
                                    );
                                  },
                                  onTap: () {
                                    liquidityAddNotifier
                                        .setTokenFormSelected(2);
                                  },
                                  textAlign: TextAlign.left,
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    aedappfm.AmountTextInputFormatter(
                                      precision: 8,
                                      thousandsSeparator: ',',
                                      useUnifyDecimalSeparator: false,
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      liquidityAdd.token2Balance
                                              .formatNumber(
                                                precision: 0,
                                              )
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
                aedappfm.ButtonHalf(
                  balanceAmount: liquidityAdd.token2Balance,
                  onTap: () async {
                    tokenAmountController.value =
                        aedappfm.AmountTextInputFormatter(
                      precision: 8,
                      thousandsSeparator: ',',
                      useUnifyDecimalSeparator: false,
                    ).formatEditUpdate(
                      TextEditingValue.empty,
                      TextEditingValue(
                        text: (Decimal.parse(
                                  liquidityAdd.token2Balance.toString(),
                                ) /
                                Decimal.fromInt(2))
                            .toDouble()
                            .toString(),
                      ),
                    );
                    liquidityAddNotifier.setTokenFormSelected(2);
                    await liquidityAddNotifier.setToken2Amount(
                      context,
                      (Decimal.parse(
                                liquidityAdd.token2Balance.toString(),
                              ) /
                              Decimal.fromInt(2))
                          .toDouble(),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                aedappfm.ButtonMax(
                  balanceAmount: liquidityAdd.token2Balance,
                  onTap: () async {
                    tokenAmountController.value =
                        aedappfm.AmountTextInputFormatter(
                      precision: 8,
                      thousandsSeparator: ',',
                      useUnifyDecimalSeparator: false,
                    ).formatEditUpdate(
                      TextEditingValue.empty,
                      TextEditingValue(
                        text: liquidityAdd.token2Balance.toString(),
                      ),
                    );
                    liquidityAddNotifier.setTokenFormSelected(2);
                    await liquidityAddNotifier.setToken2Amount(
                      context,
                      liquidityAdd.token2Balance,
                    );
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
