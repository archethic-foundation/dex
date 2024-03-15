import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
          color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: aedappfm.AppThemeBase.sheetBorderSecondary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please, confirm the removal of ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
                    ),
                    TextSpan(
                      text:
                          '${liquidityRemove.lpTokenAmount.formatNumber(precision: 8)} ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: aedappfm.AppThemeBase.secondaryColor,
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
                    ),
                    TextSpan(
                      text: liquidityRemove.lpTokenAmount > 1
                          ? 'LP Tokens from the liquidity pool.'
                          : 'LP Token from the liquidity pool.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
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
                  gradient: aedappfm.AppThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.token1Balance,
                    token: liquidityRemove.token1,
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
                    token: liquidityRemove.token1,
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
                    token: liquidityRemove.token2,
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
                    token: liquidityRemove.token2,
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
                  gradient: aedappfm.AppThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.lpTokenBalance,
                    token: liquidityRemove.pool!.lpToken,
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
                    token: liquidityRemove.pool!.lpToken,
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
