import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockLevelUpAmount extends ConsumerStatefulWidget {
  const FarmLockLevelUpAmount({
    super.key,
  });

  @override
  ConsumerState<FarmLockLevelUpAmount> createState() =>
      _FarmLockLevelUpToken1AmountState();
}

class _FarmLockLevelUpToken1AmountState
    extends ConsumerState<FarmLockLevelUpAmount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final farmLockLevelUp =
        ref.read(FarmLockLevelUpFormProvider.farmLockLevelUpForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = aedappfm.AmountTextInputFormatter(
      precision: 8,
      thousandsSeparator: ',',
      useUnifyDecimalSeparator: false,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: farmLockLevelUp.amount == 0
            ? ''
            : farmLockLevelUp.amount
                .formatNumber(precision: 8)
                .replaceAll(',', ''),
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
    final farmLockLevelUpNotifier =
        ref.watch(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier);

    final farmLockLevelUp =
        ref.watch(FarmLockLevelUpFormProvider.farmLockLevelUpForm);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(farmLockLevelUp.amount != 0.0 ||
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
                              farmLockLevelUpNotifier.setAmount(
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
                                farmLockLevelUp.lpTokenBalance
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
                  tokenBalance: farmLockLevelUp.lpTokenBalance,
                  token: farmLockLevelUp.pool!.lpToken,
                  withFiat: false,
                ),
                const SizedBox(
                  width: 5,
                ),
                SelectableText(
                  DEXLPTokenFiatValue().display(
                    ref,
                    farmLockLevelUp.pool!.pair.token1,
                    farmLockLevelUp.pool!.pair.token2,
                    farmLockLevelUp.lpTokenBalance,
                    farmLockLevelUp.pool!.poolAddress,
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
                  balanceAmount: farmLockLevelUp.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          FarmLockLevelUpFormProvider
                              .farmLockLevelUpForm.notifier,
                        )
                        .setAmountHalf();
                    _updateAmountTextController();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                aedappfm.ButtonMax(
                  balanceAmount: farmLockLevelUp.lpTokenBalance,
                  onTap: () {
                    ref
                        .read(
                          FarmLockLevelUpFormProvider
                              .farmLockLevelUpForm.notifier,
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
