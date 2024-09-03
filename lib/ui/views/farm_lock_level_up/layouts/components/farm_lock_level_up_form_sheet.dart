import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_lock_duration_btn.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:aedex/util/config/config.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FarmLockLevelUpFormSheet extends ConsumerWidget {
  const FarmLockLevelUpFormSheet({
    required this.rewardAmount,
    super.key,
  });
  final double rewardAmount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockLevelUp =
        ref.watch(FarmLockLevelUpFormProvider.farmLockLevelUpForm);

    if (farmLockLevelUp.pool == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 80, bottom: 80),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 0.5),
        ),
      );
    }

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SelectionArea(
                    child: SelectableText(
                      AppLocalizations.of(context)!
                          .aeswap_farmLockLevelUpFormTitle,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.titleMedium!,
                            ),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: aedappfm.AppThemeBase.gradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.aeswap_farmLockLevelUpDesc,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SelectableText(
                            '${AppLocalizations.of(context)!.aeswap_farmLockLevelUpFormAmountLbl}: ',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                          SelectableText(
                            farmLockLevelUp.amount.formatNumber(precision: 8),
                            style:
                                AppTextStyles.bodyLargeSecondaryColor(context),
                          ),
                          SelectableText(
                            ' ${farmLockLevelUp.amount < 1 ? AppLocalizations.of(context)!.aeswap_lpToken : AppLocalizations.of(context)!.aeswap_lpTokens}',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                        ],
                      ),
                      if (farmLockLevelUp.aprEstimation != null)
                        SelectableText(
                          '${AppLocalizations.of(context)!.aeswap_farmLockLevelUpAPREstimationLbl} ${farmLockLevelUp.aprEstimation!.formatNumber(precision: 2)}%',
                          style: AppTextStyles.bodyLarge(context),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                  Row(
                    children: [
                      if (rewardAmount == 0)
                        SelectableText(
                          AppLocalizations.of(context)!
                              .aeswap_farmLockWithdrawFormTextNoRewardText1,
                          style: AppTextStyles.bodyLarge(context),
                        )
                      else
                        FutureBuilder<String>(
                          future: FiatValue().display(
                            ref,
                            farmLockLevelUp.farmLock!.rewardToken!,
                            rewardAmount,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  SelectableText(
                                    rewardAmount.formatNumber(),
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
                                  SelectableText(
                                    ' ${farmLockLevelUp.farmLock!.rewardToken!.symbol} ',
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
                                  SelectableText(
                                    '${snapshot.data}',
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
                                  SelectableText(
                                    AppLocalizations.of(context)!
                                        .aeswap_farmLockWithdrawFormTextNoRewardText2,
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
                  Row(
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .aeswap_farmLockLevelUpFormLockDurationLbl,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...farmLockLevelUp.filterAvailableLevels.entries
                          .map((entry) {
                        return FarmLockLevelUpDurationButton(
                          farmLockLevelUpDuration:
                              getFarmLockDepositDurationTypeFromLevel(
                            entry.key,
                          ),
                          level: entry.key,
                          aprEstimation: (farmLockLevelUp.farmLock!
                                      .stats[entry.key]?.aprEstimation ??
                                  0) *
                              100,
                        );
                      }).toList(),
                    ],
                  ),
                  if (farmLockLevelUp
                          .filterAvailableLevels[farmLockLevelUp.level] !=
                      null)
                    Row(
                      children: [
                        SelectableText(
                          AppLocalizations.of(context)!
                              .aeswap_farmLockLevelUpUnlockDateLbl,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                        SelectableText(
                          DateFormat(
                            Config.kSecondsInDay == 86400
                                ? 'yyyy-MM-dd'
                                : 'yyyy-MM-dd HH:mm:ss',
                          ).format(
                            DateTime.fromMillisecondsSinceEpoch(
                              farmLockLevelUp.filterAvailableLevels[
                                      farmLockLevelUp.level]! *
                                  1000,
                            ),
                          ),
                          style: AppTextStyles.bodyLargeSecondaryColor(context),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .aeswap_farmLockLevelUpCurrentLvlLbl,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      if (farmLockLevelUp.currentLevel != null)
                        Row(
                          children: [
                            SelectableText(
                              farmLockLevelUp.currentLevel!,
                              style: AppTextStyles.bodyLargeSecondaryColor(
                                context,
                              ),
                            ),
                            SelectableText(
                              '/',
                              style: AppTextStyles.bodyLarge(context),
                            ),
                            SelectableText(
                              farmLockLevelUp
                                  .farmLock!.availableLevels.entries.last.key,
                              style: AppTextStyles.bodyLarge(context),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      aedappfm.ErrorMessage(
                        failure: farmLockLevelUp.failure,
                        failureMessage: FailureMessage(
                          context: context,
                          failure: farmLockLevelUp.failure,
                        ).getMessage(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ButtonValidateMobile(
                              controlOk: farmLockLevelUp.isControlsOk &&
                                  ref
                                      .watch(SessionProviders.session)
                                      .isConnected,
                              labelBtn: AppLocalizations.of(context)!
                                  .aeswap_btn_farmLockLevelUp,
                              onPressed: () => ref
                                  .read(
                                    FarmLockLevelUpFormProvider
                                        .farmLockLevelUpForm.notifier,
                                  )
                                  .validateForm(context),
                              isConnected: true,
                              displayWalletConnectOnPressed: () async {
                                final sessionNotifier =
                                    ref.read(SessionProviders.session.notifier);
                                await sessionNotifier.connectToWallet();

                                final session =
                                    ref.read(SessionProviders.session);
                                if (session.error.isNotEmpty) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .snackBarTheme
                                          .backgroundColor,
                                      content: SelectableText(
                                        session.error,
                                        style: Theme.of(context)
                                            .snackBarTheme
                                            .contentTextStyle,
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  context.go(
                                    '/',
                                  );
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: aedappfm.ButtonClose(
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
