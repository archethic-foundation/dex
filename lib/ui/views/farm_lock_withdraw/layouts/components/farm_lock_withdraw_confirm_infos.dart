import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockWithdrawConfirmInfos extends ConsumerWidget {
  const FarmLockWithdrawConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockWithdraw =
        ref.watch(FarmLockWithdrawFormProvider.farmLockWithdrawForm);

    final session = ref.watch(SessionProviders.session);
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
                          .aeswap_farmLockWithdrawConfirmInfosText,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    TextSpan(
                      text: farmLockWithdraw.amount.formatNumber(precision: 8),
                      style: AppTextStyles.bodyLargeSecondaryColor(context),
                    ),
                    TextSpan(
                      text:
                          ' ${farmLockWithdraw.amount > 1 ? AppLocalizations.of(context)!.aeswap_lpTokens : AppLocalizations.of(context)!.aeswap_lpToken}',
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
                        .aeswap_farmLockWithdrawConfirmYourBalance,
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
                    AppLocalizations.of(context)!.aeswap_confirmBeforeLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!.aeswap_confirmAfterLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              FutureBuilder<double>(
                future: ref.watch(
                  BalanceProviders.getBalance(
                    session.genesisAddress,
                    farmLockWithdraw.lpToken!.isUCO
                        ? 'UCO'
                        : farmLockWithdraw.lpToken!.address!,
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
                          token: farmLockWithdraw.lpToken,
                          withFiat: false,
                          digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                          height: 20,
                        ),
                        DexTokenBalance(
                          tokenBalance: (Decimal.parse(
                                    snapshot.data!.toString(),
                                  ) +
                                  Decimal.parse(
                                    farmLockWithdraw.amount.toString(),
                                  ))
                              .toDouble(),
                          token: farmLockWithdraw.lpToken,
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
                        .aeswap_farmLockWithdrawConfirmFarmBalance,
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
                    AppLocalizations.of(context)!.aeswap_confirmBeforeLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!.aeswap_confirmAfterLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: farmLockWithdraw.depositedAmount!,
                    token: farmLockWithdraw.lpToken,
                    withFiat: false,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmLockWithdraw.depositedAmount.toString(),
                            ) -
                            Decimal.parse(
                              farmLockWithdraw.amount.toString(),
                            ))
                        .toDouble(),
                    token: farmLockWithdraw.lpToken,
                    withFiat: false,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                  ),
                ],
              ),
              if (farmLockWithdraw.rewardAmount! > 0)
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
                              .aeswap_farmLockWithdrawConfirmRewards,
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
                        farmLockWithdraw.rewardToken!,
                        farmLockWithdraw.rewardAmount!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .aeswap_farmLockWithdrawConfirmYouWillReceive,
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
                                  text: farmLockWithdraw.rewardAmount!
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
                                      ' ${farmLockWithdraw.rewardToken!.symbol} ',
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
