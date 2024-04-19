import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddConfirmInfos extends ConsumerWidget {
  const LiquidityAddConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    'Add liquidity in the pool',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                  ),
                  SelectableText(
                    'Mininum amount',
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
                  Row(
                    children: [
                      Tooltip(
                        message: liquidityAdd.token1!.symbol,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: liquidityAdd.token1Amount
                                    .formatNumber(precision: 8),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color:
                                          aedappfm.AppThemeBase.secondaryColor,
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context).textTheme.bodyLarge!,
                                      ),
                                    ),
                              ),
                              TextSpan(
                                text:
                                    ' ${liquidityAdd.token1!.symbol.reduceSymbol()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context).textTheme.bodyLarge!,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Tooltip(
                    message: liquidityAdd.token1!.symbol,
                    child: SelectableText(
                      '${liquidityAdd.token1minAmount.formatNumber()} ${liquidityAdd.token1!.symbol.reduceSymbol()}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SelectableText(
                        '${liquidityAdd.token2Amount}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: aedappfm.AppThemeBase.secondaryColor,
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
                      ),
                      Tooltip(
                        message: liquidityAdd.token2!.symbol,
                        child: SelectableText(
                          ' ${liquidityAdd.token2!.symbol.reduceSymbol()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyLarge!,
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),
                  Tooltip(
                    message: liquidityAdd.token2!.symbol,
                    child: SelectableText(
                      '+${liquidityAdd.token2minAmount.formatNumber()} ${liquidityAdd.token2!.symbol.reduceSymbol()}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
                    ),
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
                    tokenBalance: liquidityAdd.token1Balance,
                    token: liquidityAdd.token1,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.token1Balance.toString(),
                            ) -
                            Decimal.parse(liquidityAdd.token1Amount.toString()))
                        .toDouble(),
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    token: liquidityAdd.token1,
                    height: 20,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityAdd.token2Balance,
                    token: liquidityAdd.token2,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.token2Balance.toString(),
                            ) -
                            Decimal.parse(liquidityAdd.token2Amount.toString()))
                        .toDouble(),
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    token: liquidityAdd.token2,
                    height: 20,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
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
                children: [
                  SelectableText(
                    '+${liquidityAdd.expectedTokenLP.formatNumber()} ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: aedappfm.AppThemeBase.secondaryColor,
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                  ),
                  SelectableText(
                    liquidityAdd.expectedTokenLP > 1
                        ? 'LP Tokens expected'
                        : 'LP Token expected',
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
                    tokenBalance: liquidityAdd.lpTokenBalance,
                    token: liquidityAdd.pool!.lpToken,
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.lpTokenBalance.toString(),
                            ) +
                            Decimal.parse(
                              liquidityAdd.expectedTokenLP.toString(),
                            ))
                        .toDouble(),
                    token: liquidityAdd.pool!.lpToken,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              if (liquidityAdd.messageMaxHalfUCO)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 45,
                    child: aedappfm.InfoBanner(
                      'The UCO amount you entered has been reduced to include transaction fees.',
                      aedappfm.InfoBannerType.request,
                    ),
                  ),
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
