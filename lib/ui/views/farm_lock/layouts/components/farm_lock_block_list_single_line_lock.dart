import 'dart:ui';

import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_btn_claim.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_btn_level_up.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_btn_withdraw.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';

class FarmLockBlockListSingleLineLock extends ConsumerWidget {
  const FarmLockBlockListSingleLineLock({
    super.key,
    required this.farmLock,
    required this.farmLockUserInfos,
    required this.currentSortedColumn,
  });

  final DexFarmLockUserInfos farmLockUserInfos;
  final DexFarmLock farmLock;
  final String currentSortedColumn;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var isFlexDuration = false;
    var progressPercentage = 0.0;
    if (farmLockUserInfos.start == null && farmLockUserInfos.end == null) {
      isFlexDuration = true;
      progressPercentage = 1.0;
    } else {
      final startDate =
          DateTime.fromMillisecondsSinceEpoch(farmLockUserInfos.start! * 1000);
      final endDate =
          DateTime.fromMillisecondsSinceEpoch(farmLockUserInfos.end! * 1000);
      final currentDate = DateTime.now().toUtc();
      final totalDuration = endDate.difference(startDate).inMinutes;
      final elapsedDuration = currentDate.difference(startDate).inMinutes;
      progressPercentage = elapsedDuration / totalDuration;
      progressPercentage = progressPercentage.clamp(0, 1);
    }

    final style = Theme.of(context).textTheme.bodyMedium;
    final styleHeader = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
        );
    return Padding(
      padding: aedappfm.Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 50)
          : const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                alignment: Alignment.topLeft,
                height: aedappfm.Responsive.isDesktop(context) ? 80 : 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      aedappfm.AppThemeBase.sheetBackgroundSecondary
                          .withOpacity(0.4),
                      aedappfm.AppThemeBase.sheetBackgroundSecondary,
                    ],
                    stops: const [0, 1],
                  ),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: [
                        aedappfm.AppThemeBase.sheetBackgroundSecondary
                            .withOpacity(0.4),
                        aedappfm.AppThemeBase.sheetBackgroundSecondary,
                      ],
                      stops: const [0, 1],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return aedappfm.Responsive.isDesktop(context)
                              ? Row(
                                  children: [
                                    Opacity(
                                      opacity: AppTextStyles.kOpacityText,
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.15,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              SelectableText(
                                                '${farmLockUserInfos.amount.formatNumber(precision: farmLockUserInfos.amount < 1 ? 8 : 3)} ${farmLockUserInfos.amount < 1 ? AppLocalizations.of(context)!.lpToken : AppLocalizations.of(context)!.lpTokens}',
                                                style: style,
                                              ),
                                              SelectableText(
                                                DEXLPTokenFiatValue().display(
                                                  ref,
                                                  farmLock.lpTokenPair!.token1,
                                                  farmLock.lpTokenPair!.token2,
                                                  farmLockUserInfos.amount,
                                                  farmLock.poolAddress,
                                                ),
                                                style: AppTextStyles.bodySmall(
                                                  context,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Opacity(
                                      opacity: AppTextStyles.kOpacityText,
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.20,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              SelectableText(
                                                '${farmLockUserInfos.rewardAmount.formatNumber(precision: farmLockUserInfos.rewardAmount < 1 ? 8 : 3)} ${farmLock.rewardToken!.symbol}',
                                                style: style,
                                              ),
                                              FutureBuilder<String>(
                                                future: FiatValue().display(
                                                  ref,
                                                  farmLock.rewardToken!,
                                                  farmLockUserInfos
                                                      .rewardAmount,
                                                ),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return SelectableText(
                                                      snapshot.data!,
                                                      style: AppTextStyles
                                                          .bodySmall(
                                                        context,
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox
                                                      .shrink();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Opacity(
                                      opacity: AppTextStyles.kOpacityText,
                                      child: isFlexDuration
                                          ? SizedBox(
                                              width:
                                                  constraints.maxWidth * 0.15,
                                              child: Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .available,
                                                  style: style!.copyWith(
                                                    color: aedappfm
                                                        .ArchethicThemeBase
                                                        .systemPositive600,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              width:
                                                  constraints.maxWidth * 0.15,
                                              child: Column(
                                                children: [
                                                  SelectableText(
                                                    DateTime.fromMillisecondsSinceEpoch(
                                                      farmLockUserInfos.end! *
                                                          1000,
                                                    )
                                                        .difference(
                                                          DateTime.now()
                                                              .toUtc(),
                                                        )
                                                        .toDurationString(
                                                          includeWeeks: true,
                                                          round: false,
                                                          delimiter: ', ',
                                                        ),
                                                    style: style,
                                                  ),
                                                  SelectableText(
                                                    DateFormat.yMMMEd(
                                                      Localizations.localeOf(
                                                        context,
                                                      ).languageCode,
                                                    ).format(
                                                      DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                        farmLockUserInfos.end! *
                                                            1000,
                                                      ),
                                                    ),
                                                    style:
                                                        AppTextStyles.bodySmall(
                                                      context,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                    Opacity(
                                      opacity: AppTextStyles.kOpacityText,
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.15,
                                        child: Center(
                                          child: Text(
                                            farmLock.availableLevels.isNotEmpty
                                                ? '${AppLocalizations.of(context)!.lvl} ${farmLockUserInfos.level}/${farmLock.availableLevels.entries.last.key}'
                                                : 'N/A',
                                            style: style,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Opacity(
                                      opacity: AppTextStyles.kOpacityText,
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.10,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                '${(farmLockUserInfos.apr * 100).formatNumber(precision: 2)}%',
                                                style: style,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.083,
                                      child: FarmLockBtnLevelUp(
                                        farmAddress: farmLock.farmAddress,
                                        lpTokenAddress:
                                            farmLock.lpToken!.address!,
                                        lpTokenAmount: farmLockUserInfos.amount,
                                        rewardToken: farmLock.rewardToken!,
                                        depositId: farmLockUserInfos.id,
                                        currentLevel: farmLockUserInfos.level,
                                        enabled: farmLock.isOpen &&
                                            int.tryParse(
                                                  farmLockUserInfos.level,
                                                )! <
                                                int.tryParse(
                                                  farmLock.availableLevels
                                                      .entries.last.key,
                                                )!,
                                        rewardAmount:
                                            farmLockUserInfos.rewardAmount,
                                        currentSortedColumn:
                                            currentSortedColumn,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.083,
                                      child: FarmLockBtnWithdraw(
                                        farmAddress: farmLock.farmAddress,
                                        poolAddress: farmLock.poolAddress,
                                        lpToken: farmLock.lpToken!,
                                        lpTokenPair: farmLock.lpTokenPair!,
                                        depositedAmount:
                                            farmLockUserInfos.amount,
                                        rewardAmount:
                                            farmLockUserInfos.rewardAmount,
                                        rewardToken: farmLock.rewardToken!,
                                        depositId: farmLockUserInfos.id,
                                        endDate: farmLock.endDate!,
                                        enabled: isFlexDuration ||
                                            (!isFlexDuration &&
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                  farmLockUserInfos.end! * 1000,
                                                ).isBefore(
                                                  DateTime.now().toUtc(),
                                                )),
                                        currentSortedColumn:
                                            currentSortedColumn,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.083,
                                      child: FarmLockBtnClaim(
                                        farmAddress: farmLock.farmAddress,
                                        lpTokenAddress:
                                            farmLock.lpToken!.address!,
                                        rewardToken: farmLock.rewardToken!,
                                        depositId: farmLockUserInfos.id,
                                        rewardAmount:
                                            farmLockUserInfos.rewardAmount,
                                        enabled: isFlexDuration == true &&
                                            farmLockUserInfos.rewardAmount >
                                                0 &&
                                            (isFlexDuration ||
                                                (!isFlexDuration &&
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                      farmLockUserInfos.end! *
                                                          1000,
                                                    ).isBefore(
                                                      DateTime.now().toUtc(),
                                                    ))),
                                        currentSortedColumn:
                                            currentSortedColumn,
                                      ),
                                    ),
                                  ],
                                )
                              : Opacity(
                                  opacity: AppTextStyles.kOpacityText,
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${AppLocalizations.of(
                                                      context,
                                                    )!.farmLockBlockListHeaderAmount}: ',
                                                    style: styleHeader,
                                                  ),
                                                  SelectableText(
                                                    '${farmLockUserInfos.amount.formatNumber(precision: farmLockUserInfos.amount < 1 ? 8 : 3)} ${farmLockUserInfos.amount < 1 ? AppLocalizations.of(context)!.lpToken : AppLocalizations.of(context)!.lpTokens}',
                                                    style: style,
                                                  ),
                                                ],
                                              ),
                                              SelectableText(
                                                DEXLPTokenFiatValue().display(
                                                  ref,
                                                  farmLock.lpTokenPair!.token1,
                                                  farmLock.lpTokenPair!.token2,
                                                  farmLockUserInfos.amount,
                                                  farmLock.poolAddress,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${AppLocalizations.of(
                                                      context,
                                                    )!.farmLockBlockListHeaderRewards}: ',
                                                    style: styleHeader,
                                                  ),
                                                  SelectableText(
                                                    '${farmLockUserInfos.rewardAmount.formatNumber(precision: farmLockUserInfos.rewardAmount < 1 ? 8 : 3)} ${farmLock.rewardToken!.symbol}',
                                                    style: style,
                                                  ),
                                                ],
                                              ),
                                              FutureBuilder<String>(
                                                future: FiatValue().display(
                                                  ref,
                                                  farmLock.rewardToken!,
                                                  farmLockUserInfos
                                                      .rewardAmount,
                                                ),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return SelectableText(
                                                      snapshot.data!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    );
                                                  }
                                                  return const SizedBox
                                                      .shrink();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (isFlexDuration)
                                          SizedBox(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .available,
                                              style: style!.copyWith(
                                                color: aedappfm
                                                    .ArchethicThemeBase
                                                    .systemPositive600,
                                              ),
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${AppLocalizations.of(
                                                        context,
                                                      )!.farmLockBlockListHeaderUnlocks}: ',
                                                      style: styleHeader,
                                                    ),
                                                    SelectableText(
                                                      DateTime.fromMillisecondsSinceEpoch(
                                                        farmLockUserInfos.end! *
                                                            1000,
                                                      )
                                                          .difference(
                                                            DateTime.now()
                                                                .toUtc(),
                                                          )
                                                          .toDurationString(
                                                            includeWeeks: true,
                                                            round: false,
                                                            delimiter: ', ',
                                                          ),
                                                      style: style,
                                                    ),
                                                  ],
                                                ),
                                                SelectableText(
                                                  DateFormat.yMMMEd(
                                                    Localizations.localeOf(
                                                      context,
                                                    ).languageCode,
                                                  ).format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                      farmLockUserInfos.end! *
                                                          1000,
                                                    ),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${AppLocalizations.of(
                                                      context,
                                                    )!.level}: ',
                                                    style: styleHeader,
                                                  ),
                                                  SelectableText(
                                                    farmLock.availableLevels
                                                            .isNotEmpty
                                                        ? '${AppLocalizations.of(context)!.lvl} ${farmLockUserInfos.level}/${farmLock.availableLevels.entries.last.key}'
                                                        : 'N/A',
                                                    style: style,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${AppLocalizations.of(
                                                      context,
                                                    )!.farmLockBlockListHeaderAPR}: ',
                                                    style: styleHeader,
                                                  ),
                                                  SelectableText(
                                                    '${(farmLockUserInfos.apr * 100).formatNumber(precision: 2)}%',
                                                    style: style,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: FarmLockBtnLevelUp(
                                                      farmAddress:
                                                          farmLock.farmAddress,
                                                      lpTokenAddress: farmLock
                                                          .lpToken!.address!,
                                                      lpTokenAmount:
                                                          farmLockUserInfos
                                                              .amount,
                                                      rewardToken:
                                                          farmLock.rewardToken!,
                                                      depositId:
                                                          farmLockUserInfos.id,
                                                      currentLevel:
                                                          farmLockUserInfos
                                                              .level,
                                                      enabled: int.tryParse(
                                                            farmLockUserInfos
                                                                .level,
                                                          )! <
                                                          int.tryParse(
                                                            farmLock
                                                                .availableLevels
                                                                .entries
                                                                .last
                                                                .key,
                                                          )!,
                                                      rewardAmount:
                                                          farmLockUserInfos
                                                              .rewardAmount,
                                                      currentSortedColumn:
                                                          currentSortedColumn,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: FarmLockBtnWithdraw(
                                                      farmAddress:
                                                          farmLock.farmAddress,
                                                      poolAddress:
                                                          farmLock.poolAddress,
                                                      lpToken:
                                                          farmLock.lpToken!,
                                                      lpTokenPair:
                                                          farmLock.lpTokenPair!,
                                                      depositedAmount:
                                                          farmLockUserInfos
                                                              .amount,
                                                      rewardAmount:
                                                          farmLockUserInfos
                                                              .rewardAmount,
                                                      rewardToken:
                                                          farmLock.rewardToken!,
                                                      depositId:
                                                          farmLockUserInfos.id,
                                                      endDate:
                                                          farmLock.endDate!,
                                                      enabled: isFlexDuration ||
                                                          (!isFlexDuration &&
                                                              DateTime
                                                                  .fromMillisecondsSinceEpoch(
                                                                farmLockUserInfos
                                                                        .end! *
                                                                    1000,
                                                              ).isBefore(
                                                                DateTime.now()
                                                                    .toUtc(),
                                                              )),
                                                      currentSortedColumn:
                                                          currentSortedColumn,
                                                    ),
                                                  ),
                                                  if (isFlexDuration)
                                                    Expanded(
                                                      child: FarmLockBtnClaim(
                                                        farmAddress: farmLock
                                                            .farmAddress,
                                                        lpTokenAddress: farmLock
                                                            .lpToken!.address!,
                                                        rewardToken: farmLock
                                                            .rewardToken!,
                                                        depositId:
                                                            farmLockUserInfos
                                                                .id,
                                                        rewardAmount:
                                                            farmLockUserInfos
                                                                .rewardAmount,
                                                        enabled: farmLockUserInfos
                                                                    .rewardAmount >
                                                                0 &&
                                                            (isFlexDuration ||
                                                                (!isFlexDuration &&
                                                                    DateTime
                                                                        .fromMillisecondsSinceEpoch(
                                                                      farmLockUserInfos
                                                                              .end! *
                                                                          1000,
                                                                    ).isBefore(
                                                                      DateTime.now()
                                                                          .toUtc(),
                                                                    ))),
                                                        currentSortedColumn:
                                                            currentSortedColumn,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: progressPercentage > 0
                              ? MediaQuery.of(context).size.width *
                                  progressPercentage
                              : 3,
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: aedappfm.AppThemeBase.gradientWelcomeTxt,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
