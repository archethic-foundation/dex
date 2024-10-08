import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    final liquidityRemove = ref.read(liquidityRemoveFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = aedappfm.AmountTextInputFormatter(
      precision: 8,
      thousandsSeparator: ',',
      useUnifyDecimalSeparator: false,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: liquidityRemove.lpTokenAmount == 0
            ? ''
            : liquidityRemove.lpTokenAmount
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
    final liquidityRemoveNotifier =
        ref.watch(liquidityRemoveFormNotifierProvider.notifier);

    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(liquidityRemove.lpTokenAmount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
      _updateAmountTextController();
    }

    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Column(
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
                                    fontSize: aedappfm.Responsive
                                        .fontSizeFromTextStyle(
                                      context,
                                      Theme.of(context).textTheme.titleMedium!,
                                    ),
                                  ),
                              autocorrect: false,
                              controller: tokenAmountController,
                              onChanged: (text) async {
                                await liquidityRemoveNotifier.setLPTokenAmount(
                                  double.tryParse(text.replaceAll(',', '')) ??
                                      0,
                                );
                              },
                              focusNode: tokenAmountFocusNode,
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
              if (liquidityRemove.pool != null)
                DexTokenBalance(
                  tokenBalance: liquidityRemove.lpTokenBalance,
                  token: liquidityRemove.pool!.lpToken,
                  pool: liquidityRemove.pool,
                ),
              Row(
                children: [
                  aedappfm.ButtonHalf(
                    balanceAmount: liquidityRemove.lpTokenBalance,
                    onTap: () async {
                      await ref
                          .read(
                            liquidityRemoveFormNotifierProvider.notifier,
                          )
                          .setLpTokenAmountHalf();
                      _updateAmountTextController();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  aedappfm.ButtonMax(
                    balanceAmount: liquidityRemove.lpTokenBalance,
                    onTap: () async {
                      await ref
                          .read(
                            liquidityRemoveFormNotifierProvider.notifier,
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
      ),
    );
  }
}
