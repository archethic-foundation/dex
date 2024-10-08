import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmInfos extends ConsumerWidget {
  const PoolAddConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final poolAdd = ref.watch(poolAddFormNotifierProvider);
    if (poolAdd.token1 == null) {
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
            children: [
              Opacity(
                opacity: AppTextStyles.kOpacityText,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.poolAddConfirmNewPoolLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!
                          .poolAddConfirmWithLiquidityLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Tooltip(
                            message: poolAdd.token1!.symbol,
                            child: SelectableText(
                              poolAdd.token1!.symbol.reduceSymbol(),
                              style: AppTextStyles.bodyLargeSecondaryColor(
                                context,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (poolAdd.token1!.isUCO == false)
                            FormatAddressLink(
                              address: poolAdd.token1!.isUCO
                                  ? 'UCO'
                                  : poolAdd.token1!.address,
                            ),
                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: VerifiedTokenIcon(
                              address: poolAdd.token1!.isUCO
                                  ? 'UCO'
                                  : poolAdd.token1!.address,
                            ),
                          ),
                        ],
                      ),
                      SelectableText(
                        ' ',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodySmall!,
                              ),
                            ),
                      ),
                      Row(
                        children: [
                          Tooltip(
                            message: poolAdd.token2!.symbol,
                            child: SelectableText(
                              poolAdd.token2!.symbol.reduceSymbol(),
                              style: AppTextStyles.bodyLargeSecondaryColor(
                                context,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (poolAdd.token2!.isUCO == false)
                            FormatAddressLink(
                              address: poolAdd.token2!.isUCO
                                  ? 'UCO'
                                  : poolAdd.token2!.address,
                            ),
                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: VerifiedTokenIcon(
                              address: poolAdd.token2!.isUCO
                                  ? 'UCO'
                                  : poolAdd.token2!.address,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: poolAdd.token1!.symbol,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '+ ${poolAdd.token1Amount.formatNumber(precision: 8)}',
                                style: AppTextStyles.bodyLargeSecondaryColor(
                                  context,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${poolAdd.token1!.symbol.reduceSymbol()}',
                                style: AppTextStyles.bodyLarge(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FutureBuilder<String>(
                            future: FiatValue().display(
                              ref,
                              poolAdd.token1!,
                              poolAdd.token1Amount,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SelectableText(
                                  snapshot.data!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodyMedium!,
                                        ),
                                      ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Tooltip(
                            message: poolAdd.token2!.symbol,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '+ ${poolAdd.token2Amount.formatNumber(precision: 8)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: aedappfm
                                              .AppThemeBase.secondaryColor,
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyLarge!,
                                          ),
                                        ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ${poolAdd.token2!.symbol.reduceSymbol()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyLarge!,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FutureBuilder<String>(
                                future: FiatValue().display(
                                  ref,
                                  poolAdd.token2!,
                                  poolAdd.token2Amount,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return SelectableText(
                                      snapshot.data!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: aedappfm.Responsive
                                                .fontSizeFromTextStyle(
                                              context,
                                              Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!,
                                            ),
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
              if (poolAdd.token1Amount > 0)
                Opacity(
                  opacity: AppTextStyles.kOpacityText,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DexRatio(
                      ratio: (Decimal.parse(poolAdd.token2Amount.toString()) /
                              Decimal.parse(poolAdd.token1Amount.toString()))
                          .toDouble(),
                      token1Symbol: poolAdd.token1!.symbol,
                      token2Symbol: poolAdd.token2!.symbol,
                    ),
                  ),
                ),
              if (poolAdd.token2Amount > 0)
                Opacity(
                  opacity: AppTextStyles.kOpacityText,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DexRatio(
                      ratio: (Decimal.parse(poolAdd.token1Amount.toString()) /
                              Decimal.parse(poolAdd.token2Amount.toString()))
                          .toDouble(),
                      token1Symbol: poolAdd.token2!.symbol,
                      token2Symbol: poolAdd.token1!.symbol,
                    ),
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
                    tokenBalance: poolAdd.token1Balance,
                    token: poolAdd.token1,
                    height: 20,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              poolAdd.token1Balance.toString(),
                            ) -
                            Decimal.parse(poolAdd.token1Amount.toString()))
                        .toDouble(),
                    token: poolAdd.token1,
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
                    tokenBalance: poolAdd.token2Balance,
                    token: poolAdd.token2,
                    height: 20,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              poolAdd.token2Balance.toString(),
                            ) -
                            Decimal.parse(poolAdd.token2Amount.toString()))
                        .toDouble(),
                    token: poolAdd.token2,
                    height: 20,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
                  ),
                ],
              ),
              if (poolAdd.messageMaxHalfUCO)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 45,
                    child: aedappfm.InfoBanner(
                      AppLocalizations.of(context)!
                          .poolAddConfirmMessageMaxHalfUCO,
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
