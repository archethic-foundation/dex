import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    final farmDeposit = ref.read(farmDepositFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = aedappfm.AmountTextInputFormatter(
      precision: 8,
      thousandsSeparator: ',',
      useUnifyDecimalSeparator: false,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: farmDeposit.amount == 0
            ? ''
            : farmDeposit.amount.formatNumber(precision: 8).replaceAll(',', ''),
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
        ref.watch(farmDepositFormNotifierProvider.notifier);

    final farmDeposit = ref.watch(farmDepositFormNotifierProvider);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(farmDeposit.amount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
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
                                    .surface
                                    .withOpacity(1),
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.3),
                              ],
                              stops: const [0, 1],
                            ),
                          ),
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.titleMedium!,
                                  ),
                                ),
                            autocorrect: false,
                            controller: tokenAmountController,
                            onChanged: (text) async {
                              farmDepositNotifier.setAmount(
                                double.tryParse(text.replaceAll(',', '')) ?? 0,
                              );
                            },
                            focusNode: tokenAmountFocusNode,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.done,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              aedappfm.AmountTextInputFormatter(
                                precision: 8,
                                thousandsSeparator: ',',
                                useUnifyDecimalSeparator: false,
                              ),
                              LengthLimitingTextInputFormatter(
                                farmDeposit.lpTokenBalance
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                DexTokenBalance(
                  tokenBalance: farmDeposit.lpTokenBalance,
                  token: farmDeposit.dexFarmInfo!.lpToken,
                  withFiat: false,
                ),
                const SizedBox(
                  width: 5,
                ),
                SelectableText(
                  ref.watch(
                    dexLPTokenFiatValueProvider(
                      farmDeposit.dexFarmInfo!.lpTokenPair!.token1,
                      farmDeposit.dexFarmInfo!.lpTokenPair!.token2,
                      farmDeposit.lpTokenBalance,
                      farmDeposit.dexFarmInfo!.poolAddress,
                    ),
                  ),
                  style: AppTextStyles.bodyLarge(context),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                aedappfm.ButtonHalf(
                  balanceAmount: farmDeposit.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          farmDepositFormNotifierProvider.notifier,
                        )
                        .setAmountHalf();
                    _updateAmountTextController();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                aedappfm.ButtonMax(
                  balanceAmount: farmDeposit.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          farmDepositFormNotifierProvider.notifier,
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
