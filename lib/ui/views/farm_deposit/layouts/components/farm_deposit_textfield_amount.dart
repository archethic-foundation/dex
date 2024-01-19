import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_btn_half.dart';
import 'package:aedex/ui/views/util/components/dex_btn_max.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositAmount extends ConsumerStatefulWidget {
  const FarmDepositAmount({
    super.key,
  });

  @override
  ConsumerState<FarmDepositAmount> createState() =>
      _FarmDepositToken1AmountState();
}

class _FarmDepositToken1AmountState extends ConsumerState<FarmDepositAmount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final farmDeposit = ref.read(FarmDepositFormProvider.farmDepositForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: farmDeposit.amount == 0 ? '' : farmDeposit.amount.toString(),
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
    final farmDepositNotifier =
        ref.watch(FarmDepositFormProvider.farmDepositForm.notifier);

    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(farmDeposit.amount != 0.0 ||
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
                              farmDepositNotifier.setAmount(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DexTokenBalance(
              tokenBalance: farmDeposit.lpTokenBalance,
              tokenSymbol: farmDeposit.dexFarmInfos!.lpToken == null
                  ? ''
                  : farmDeposit.dexFarmInfos!.lpToken!.symbol,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                DexButtonHalf(
                  balanceAmount: farmDeposit.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          FarmDepositFormProvider.farmDepositForm.notifier,
                        )
                        .setAmountHalf();
                    _updateAmountTextController();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                DexButtonMax(
                  balanceAmount: farmDeposit.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          FarmDepositFormProvider.farmDepositForm.notifier,
                        )
                        .setAmountMax();
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
