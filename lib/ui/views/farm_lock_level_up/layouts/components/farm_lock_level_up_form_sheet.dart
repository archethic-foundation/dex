import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/components/farm_lock_level_up_lock_duration_btn.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_info_header.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FarmLockLevelUpFormSheet extends ConsumerWidget {
  const FarmLockLevelUpFormSheet({
    required this.currentLevel,
    required this.timestampStart,
    required this.rewardAmount,
    super.key,
  });
  final String currentLevel;
  final int timestampStart;
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
                      AppLocalizations.of(context)!.farmLockLevelUpFormTitle,
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
          PoolDetailsInfoHeader(
            pool: farmLockLevelUp.pool,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.farmLockLevelUpDesc,
                    style: AppTextStyles.bodyLarge(context),
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
                            '${AppLocalizations.of(context)!.farmLockLevelUpFormAmountLbl}: ',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                          SelectableText(
                            farmLockLevelUp.amount.formatNumber(precision: 8),
                            style:
                                AppTextStyles.bodyLargeSecondaryColor(context),
                          ),
                          SelectableText(
                            ' ${farmLockLevelUp.amount < 1 ? AppLocalizations.of(context)!.lpToken : AppLocalizations.of(context)!.lpTokens}',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                        ],
                      ),
                      if (farmLockLevelUp.aprEstimation != null)
                        SelectableText(
                          '${AppLocalizations.of(context)!.farmLockLevelUpAPREstimationLbl} ${farmLockLevelUp.aprEstimation!.formatNumber(precision: 2)}%',
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
                              .farmLockWithdrawFormTextNoRewardText1,
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
                                        .farmLockWithdrawFormTextNoRewardText2,
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
                            .farmLockLevelUpFormLockDurationLbl,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...farmLockLevelUp.farmLock!.availableLevels.entries
                          .map((entry) {
                        final farmLockDepositDurationType =
                            getFarmLockDepositDurationTypeFromLevel(
                          entry.key,
                        );

                        final currentLevelNum = int.tryParse(currentLevel) ?? 0;
                        final availableLevelNum = int.tryParse(entry.key) ?? 0;

                        if (currentLevelNum < availableLevelNum) {
                          return FarmLockLevelUpDurationButton(
                            farmLockLevelUpDuration:
                                farmLockDepositDurationType,
                            level: entry.key,
                            aprEstimation: farmLockLevelUp.farmLock!
                                    .stats[entry.key]?.aprEstimation ??
                                0,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }).toList(),
                    ],
                  ),
                  Row(
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .farmLockLevelUpInitialDateLbl,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      SelectableText(
                        DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            1688487207 * 1000,
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
                            .farmLockLevelUpUnlockDateLbl,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      SelectableText(
                        DateFormat('yyyy-MM-dd').format(
                          getFarmLockDepositDuration(
                            farmLockLevelUp.farmLockLevelUpDuration,
                            numberOfDaysAlreadyUsed: DateTime.now()
                                .difference(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    1688487207 * 1000,
                                  ),
                                )
                                .inDays,
                          )!,
                        ),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
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
                            child: aedappfm.ButtonValidate(
                              controlOk: farmLockLevelUp.isControlsOk,
                              labelBtn: AppLocalizations.of(context)!
                                  .btn_farmLockLevelUp,
                              onPressed: () => ref
                                  .read(
                                    FarmLockLevelUpFormProvider
                                        .farmLockLevelUpForm.notifier,
                                  )
                                  .validateForm(context),
                              isConnected: ref
                                  .watch(SessionProviders.session)
                                  .isConnected,
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