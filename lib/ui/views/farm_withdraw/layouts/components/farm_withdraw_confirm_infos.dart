import 'package:aedex/application/balance.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawConfirmInfos extends ConsumerWidget {
  const FarmWithdrawConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmWithdraw = ref.watch(farmWithdrawFormNotifierProvider);
    if (farmWithdraw.dexFarmInfo == null) {
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
                      text: AppLocalizations.of(context)!
                          .farmWithdrawConfirmInfosText,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    TextSpan(
                      text: farmWithdraw.amount.formatNumber(precision: 8),
                      style: AppTextStyles.bodyLargeSecondaryColor(context),
                    ),
                    TextSpan(
                      text:
                          ' ${farmWithdraw.amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .farmWithdrawConfirmYourBalance,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: aedappfm.AppThemeBase.gradient,
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
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              FutureBuilder<double>(
                future: ref.watch(
                  getBalanceProvider(
                    farmWithdraw.dexFarmInfo!.lpToken!.isUCO
                        ? 'UCO'
                        : farmWithdraw.dexFarmInfo!.lpToken!.address,
                  ).future,
                ),
                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DexTokenBalance(
                          tokenBalance: snapshot.data!,
                          token: farmWithdraw.dexFarmInfo!.lpToken,
                          withFiat: false,
                          digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                          height: 20,
                        ),
                        DexTokenBalance(
                          tokenBalance: (Decimal.parse(
                                    snapshot.data!.toString(),
                                  ) +
                                  Decimal.parse(
                                    farmWithdraw.amount.toString(),
                                  ))
                              .toDouble(),
                          token: farmWithdraw.dexFarmInfo!.lpToken,
                          digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                          withFiat: false,
                          height: 20,
                        ),
                      ],
                    );
                  }
                  return const Row(children: [SelectableText('')]);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .farmWithdrawConfirmFarmBalance,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: aedappfm.AppThemeBase.gradient,
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
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: farmWithdraw.dexFarmInfo!.lpTokenDeposited,
                    token: farmWithdraw.dexFarmInfo!.lpToken,
                    withFiat: false,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmWithdraw.dexFarmInfo!.lpTokenDeposited
                                  .toString(),
                            ) -
                            Decimal.parse(
                              farmWithdraw.amount.toString(),
                            ))
                        .toDouble(),
                    token: farmWithdraw.dexFarmInfo!.lpToken,
                    withFiat: false,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                  ),
                ],
              ),
              if (farmWithdraw.rewardAmount! > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SelectableText(
                          AppLocalizations.of(context)!
                              .farmWithdrawConfirmRewards,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: aedappfm.AppThemeBase.gradient,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        farmWithdraw.dexFarmInfo!.rewardToken!,
                        farmWithdraw.rewardAmount!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .farmWithdrawConfirmYouWillReceive,
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
                                TextSpan(
                                  text: farmWithdraw.rewardAmount!
                                      .formatNumber(precision: 8),
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
                                      ' ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol} ',
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
                                TextSpan(
                                  text: '${snapshot.data}',
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
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
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
