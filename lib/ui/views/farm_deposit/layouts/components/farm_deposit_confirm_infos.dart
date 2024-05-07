import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositConfirmInfos extends ConsumerWidget {
  const FarmDepositConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.dexFarmInfo == null) {
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
                          .farmDepositConfirmInfosText,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    TextSpan(
                      text: farmDeposit.amount.formatNumber(precision: 8),
                      style: AppTextStyles.bodyLargeSecondaryColor(context),
                    ),
                    TextSpan(
                      text:
                          ' ${farmDeposit.amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
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
                    AppLocalizations.of(context)!.farmDepositConfirmYourBalance,
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
                    tokenBalance: farmDeposit.lpTokenBalance,
                    token: farmDeposit.dexFarmInfo!.lpToken,
                    withFiat: false,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmDeposit.lpTokenBalance.toString(),
                            ) -
                            Decimal.parse(
                              farmDeposit.amount.toString(),
                            ))
                        .toDouble(),
                    token: farmDeposit.dexFarmInfo!.lpToken,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.farmDepositConfirmFarmBalance,
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
                    tokenBalance: farmDeposit.dexFarmInfo!.lpTokenDeposited,
                    token: farmDeposit.dexFarmInfo!.lpToken,
                    withFiat: false,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmDeposit.dexFarmInfo!.lpTokenDeposited
                                  .toString(),
                            ) +
                            Decimal.parse(
                              farmDeposit.amount.toString(),
                            ))
                        .toDouble(),
                    token: farmDeposit.dexFarmInfo!.lpToken,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    withFiat: false,
                    height: 20,
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
