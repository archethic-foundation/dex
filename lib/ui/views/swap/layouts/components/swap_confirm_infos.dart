import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_price_impact.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    final swap = ref.watch(swapFormNotifierProvider);
    if (swap.tokenToSwap == null) {
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
              Opacity(
                opacity: AppTextStyles.kOpacityText,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .swapConfirmInfosAmountTokens,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!
                          .swapConfirmInfosAmountMinReceived,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
              ),
              Tooltip(
                message: swap.tokenToSwap!.symbol,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '    - ${swap.tokenToSwapAmount.formatNumber(precision: 8)}',
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
                      ),
                      TextSpan(
                        text: ' ${swap.tokenToSwap!.symbol.reduceSymbol()}',
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    message: swap.tokenSwapped!.symbol,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '≈ + ${swap.tokenSwappedAmount.formatNumber(precision: 8)}',
                            style:
                                AppTextStyles.bodyLargeSecondaryColor(context),
                          ),
                          TextSpan(
                            text:
                                ' ${swap.tokenSwapped!.symbol.reduceSymbol()}',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: swap.tokenSwapped!.symbol,
                        child: Opacity(
                          opacity: AppTextStyles.kOpacityText,
                          child: SelectableText(
                            '${swap.minToReceive.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol.reduceSymbol()}',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                        ),
                      ),
                      FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          swap.tokenSwapped!,
                          swap.minToReceive,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Opacity(
                              opacity: AppTextStyles.kOpacityText,
                              child: SelectableText(
                                snapshot.data!,
                                style: AppTextStyles.bodyMedium(context),
                              ),
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
                  gradient: aedappfm.AppThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Opacity(
                opacity: AppTextStyles.kOpacityText,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.confirmBeforeLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!.confirmAfterLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
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
                    digits: aedappfm.Responsive.isMobile(context) &&
                            swap.tokenToSwapBalance > 1
                        ? 2
                        : 8,
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
                    digits: aedappfm.Responsive.isMobile(context) &&
                            (Decimal.parse(
                                          swap.tokenToSwapBalance.toString(),
                                        ) -
                                        Decimal.parse(
                                          swap.tokenToSwapAmount.toString(),
                                        ))
                                    .toDouble() >
                                1
                        ? 2
                        : 8,
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
                    digits: aedappfm.Responsive.isMobile(context) &&
                            swap.tokenToSwapBalance > 1
                        ? 2
                        : 8,
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
                    digits: aedappfm.Responsive.isMobile(context) &&
                            (Decimal.parse(
                                          swap.tokenSwappedBalance.toString(),
                                        ) +
                                        Decimal.parse(
                                          swap.tokenSwappedAmount.toString(),
                                        ))
                                    .toDouble() >
                                1
                        ? 2
                        : 8,
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
              if (swap.swapTotalFees > 0 && swap.tokenToSwap != null)
                Opacity(
                  opacity: AppTextStyles.kOpacityText,
                  child: Row(
                    children: [
                      Tooltip(
                        message: swap.tokenToSwap!.symbol,
                        child: SelectableText(
                          '${AppLocalizations.of(context)!.swapConfirmInfosAmountMinFees} ${swap.swapTotalFees.formatNumber(
                            precision: aedappfm.Responsive.isMobile(context) &&
                                    swap.swapTotalFees > 1
                                ? 2
                                : 8,
                          )} ${swap.tokenToSwap!.symbol.reduceSymbol()}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
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
                              style: AppTextStyles.bodyMedium(context),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (swap.pool != null &&
                          swap.poolInfos != null &&
                          swap.tokenToSwap != null)
                        Tooltip(
                          message:
                              '${AppLocalizations.of(context)!.swapConfirmInfosFeesLP} (${swap.poolInfos!.fees}%): ${swap.swapFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol.reduceSymbol()} \n${AppLocalizations.of(context)!.swapConfirmInfosFeesProtocol} (${swap.poolInfos!.protocolFees}%): ${swap.swapProtocolFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol.reduceSymbol()}',
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Icon(
                              aedappfm.Iconsax.info_circle,
                              size: 13,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              if (swap.tokenSwapped != null &&
                  swap.tokenToSwap != null &&
                  swap.tokenSwappedAmount > 0 &&
                  swap.tokenToSwapAmount > 0)
                DexPriceImpact(priceImpact: swap.priceImpact),
              if (swap.messageMaxHalfUCO)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 45,
                    child: aedappfm.InfoBanner(
                      AppLocalizations.of(context)!
                          .swapConfirmInfosMessageMaxHalfUCO,
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
