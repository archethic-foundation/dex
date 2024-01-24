import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveConfirmInfos extends ConsumerWidget {
  const LiquidityRemoveConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.token1 == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ArchethicThemeBase.blue800,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: ArchethicThemeBase.neutral900,
              blurRadius: 7,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please, confirm the removal of ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: '${liquidityRemove.lpTokenAmount} ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: DexThemeBase.secondaryColor,
                          ),
                    ),
                    TextSpan(
                      text: liquidityRemove.lpTokenAmount > 1
                          ? 'LP Tokens from the liquidity pool.'
                          : 'LP Token from the liquidity pool.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: DexThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.token1Balance,
                    tokenSymbol: liquidityRemove.token1!.symbol,
                    height: 20,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityRemove.token1Balance.toString(),
                            ) +
                            Decimal.parse(
                              liquidityRemove.token1AmountGetBack.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: liquidityRemove.token1!.symbol,
                    height: 20,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.token2Balance,
                    tokenSymbol: liquidityRemove.token2!.symbol,
                    height: 20,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityRemove.token2Balance.toString(),
                            ) +
                            Decimal.parse(
                              liquidityRemove.token2AmountGetBack.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: liquidityRemove.token2!.symbol,
                    height: 20,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: DexThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.lpTokenBalance,
                    tokenSymbol: liquidityRemove.lpTokenBalance > 1
                        ? 'LP Tokens'
                        : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityRemove.lpTokenBalance.toString(),
                            ) -
                            Decimal.parse(
                              liquidityRemove.lpTokenAmount.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: (Decimal.parse(
                                      liquidityRemove.lpTokenBalance.toString(),
                                    ) -
                                    Decimal.parse(
                                      liquidityRemove.lpTokenAmount.toString(),
                                    ))
                                .toDouble() >
                            1
                        ? 'LP Tokens'
                        : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
