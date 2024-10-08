import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FarmLockLevelUpConfirmInfos extends ConsumerWidget {
  const FarmLockLevelUpConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    if (farmLockLevelUp.pool == null) {
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
                          .farmLockLevelUpConfirmInfosText,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    TextSpan(
                      text: farmLockLevelUp.amount.formatNumber(precision: 8),
                      style: AppTextStyles.bodyLargeSecondaryColor(context),
                    ),
                    TextSpan(
                      text:
                          ' ${farmLockLevelUp.amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockLevelUp.farmLockLevelUpDuration !=
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .farmLockLevelUpConfirmInfosText2,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    if (farmLockLevelUp.farmLockLevelUpDuration !=
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: getFarmLockDepositDurationTypeLabel(
                          context,
                          farmLockLevelUp.farmLockLevelUpDuration,
                        ).toLowerCase(),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
                      ),
                    TextSpan(
                      text: '. ',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockLevelUp.farmLockLevelUpDuration ==
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .farmLockLevelUpConfirmInfosText3,
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
                    AppLocalizations.of(context)!.farmLockLevelUpAPRLbl,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.titleLarge!,
                          ),
                        ),
                  ),
                  if (farmLockLevelUp.aprEstimation == null ||
                      farmLockLevelUp.aprEstimation! == 0)
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
                      '${farmLockLevelUp.aprEstimation?.formatNumber(precision: 2)}%',
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
              if (farmLockLevelUp.farmLockLevelUpDuration !=
                  FarmLockDepositDurationType.flexible)
                Row(
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .farmLockLevelUpUnlockDateLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockLevelUp
                            .farmLock!.availableLevels[farmLockLevelUp.level] !=
                        null)
                      SelectableText(
                        DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            farmLockLevelUp.farmLock!
                                    .availableLevels[farmLockLevelUp.level]! *
                                1000,
                          ),
                        ),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
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
