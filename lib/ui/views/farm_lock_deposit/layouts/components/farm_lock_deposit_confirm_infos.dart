import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FarmLockDepositConfirmInfos extends ConsumerWidget {
  const FarmLockDepositConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockDeposit =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);
    if (farmLockDeposit.pool == null) {
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
                          .aeswap_farmLockDepositConfirmInfosText,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    TextSpan(
                      text: farmLockDeposit.amount.formatNumber(precision: 8),
                      style: AppTextStyles.bodyLargeSecondaryColor(context),
                    ),
                    TextSpan(
                      text:
                          ' ${farmLockDeposit.amount > 1 ? AppLocalizations.of(context)!.aeswap_lpTokens : AppLocalizations.of(context)!.aeswap_lpToken}',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockDeposit.farmLockDepositDuration !=
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .aeswap_farmLockDepositConfirmInfosText2,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    if (farmLockDeposit.farmLockDepositDuration !=
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: getFarmLockDepositDurationTypeLabel(
                          context,
                          farmLockDeposit.farmLockDepositDuration,
                        ).toLowerCase(),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
                      ),
                    TextSpan(
                      text: '. ',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockDeposit.farmLockDepositDuration ==
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .aeswap_farmLockDepositConfirmInfosText3,
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
                    AppLocalizations.of(context)!.aeswap_farmLockDepositAPRLbl,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.titleLarge!,
                          ),
                        ),
                  ),
                  if (farmLockDeposit.aprEstimation == null ||
                      farmLockDeposit.aprEstimation! == 0)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Icon(
                        Icons.all_inclusive,
                        size: 20,
                        color: Colors.white60,
                      ),
                    )
                  else
                    SelectableText(
                      '${farmLockDeposit.aprEstimation?.formatNumber(precision: 2)}%',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: aedappfm.AppThemeBase.secondaryColor,
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.titleLarge!,
                            ),
                          ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (farmLockDeposit.farmLockDepositDuration !=
                  FarmLockDepositDurationType.flexible)
                Row(
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .aeswap_farmLockDepositUnlockDateLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockDeposit.farmLockDepositDuration !=
                            FarmLockDepositDurationType.flexible &&
                        farmLockDeposit.farmLock!
                                .availableLevels[farmLockDeposit.level] !=
                            null)
                      SelectableText(
                        DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            farmLockDeposit.farmLock!
                                    .availableLevels[farmLockDeposit.level]! *
                                1000,
                          ),
                        ),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
                      ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .aeswap_farmLockDepositConfirmYourBalance,
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
                    tokenBalance: farmLockDeposit.lpTokenBalance,
                    token: farmLockDeposit.pool!.lpToken,
                    withFiat: false,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmLockDeposit.lpTokenBalance.toString(),
                            ) -
                            Decimal.parse(
                              farmLockDeposit.amount.toString(),
                            ))
                        .toDouble(),
                    token: farmLockDeposit.pool!.lpToken,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
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
