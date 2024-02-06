import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_price_impact.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
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
                  SelectableText(
                    'Swap',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SelectableText(
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
                      SelectableText(
                        '${swap.minToReceive.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          swap.tokenSwapped!,
                          swap.minToReceive,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SelectableText(
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
                  SelectableText(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SelectableText(
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
                    token: swap.tokenToSwap,
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
                    token: swap.tokenToSwap,
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
                    token: swap.tokenSwapped,
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
                    token: swap.tokenSwapped,
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
              if (swap.swapTotalFees > 0 && swap.tokenToSwap != null)
                Row(
                  children: [
                    SelectableText(
                      'Fees: ${swap.swapTotalFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        swap.tokenToSwap!,
                        swap.swapTotalFees,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SelectableText(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Tooltip(
                      message:
                          'Liquidity Provider fees (${swap.pool!.infos!.fees}%): ${swap.swapFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol} \nProtocol fees (${swap.pool!.infos!.protocolFees}%): ${swap.swapProtocolFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol}',
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Icon(
                          Iconsax.info_circle,
                          size: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              if (swap.tokenSwapped != null &&
                  swap.tokenToSwap != null &&
                  swap.tokenSwappedAmount > 0 &&
                  swap.tokenToSwapAmount > 0)
                DexPriceImpact(priceImpact: swap.priceImpact),
              if (swap.messageMaxHalfUCO)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 45,
                    child: InfoBanner(
                      r'The UCO amount you entered has been reduced by $0.5 to include transaction fees.',
                      InfoBannerType.request,
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
