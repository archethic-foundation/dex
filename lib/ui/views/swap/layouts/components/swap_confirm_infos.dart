import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_price_impact.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapConfirmInfos extends ConsumerWidget {
  const SwapConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.tokenToSwap == null) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Swap',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Mininum received',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '    - ${swap.tokenToSwapAmount.formatNumber(precision: 8)}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: DexThemeBase.secondaryColor,
                          ),
                    ),
                    TextSpan(
                      text: ' ${swap.tokenToSwap!.symbol}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '≈ + ${swap.tokenSwappedAmount.formatNumber(precision: 8)}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: DexThemeBase.secondaryColor,
                                  ),
                        ),
                        TextSpan(
                          text: ' ${swap.tokenSwapped!.symbol}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${swap.minToReceive.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          swap.tokenSwapped!.symbol,
                          swap.minToReceive,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
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
                    tokenBalance: swap.tokenToSwapBalance,
                    tokenSymbol: swap.tokenToSwap!.symbol,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              swap.tokenToSwapBalance.toString(),
                            ) -
                            Decimal.parse(swap.tokenToSwapAmount.toString()))
                        .toDouble(),
                    tokenSymbol: swap.tokenToSwap!.symbol,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
                    height: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: swap.tokenSwappedBalance,
                    tokenSymbol: swap.tokenSwapped!.symbol,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              swap.tokenSwappedBalance.toString(),
                            ) +
                            Decimal.parse(swap.tokenSwappedAmount.toString()))
                        .toDouble(),
                    tokenSymbol: swap.tokenSwapped!.symbol,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
                    height: 20,
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
              if (swap.swapFees > 0 && swap.tokenToSwap != null)
                Row(
                  children: [
                    Text(
                      'Fees: ${swap.swapFees.formatNumber()} UCO',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        swap.tokenToSwap!.symbol,
                        swap.swapFees,
                        precision: 8,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              if (swap.tokenSwapped != null &&
                  swap.tokenToSwap != null &&
                  swap.tokenSwappedAmount > 0 &&
                  swap.tokenToSwapAmount > 0)
                DexPriceImpact(priceImpact: swap.priceImpact),
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
