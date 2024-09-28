import 'dart:ui';

import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_legacy_btn_claim.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_legacy_btn_withdraw.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class FarmLockBlockListSingleLineLegacy extends ConsumerWidget {
  const FarmLockBlockListSingleLineLegacy({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farm = ref.watch(farmLockFormFarmProvider).value;

    if (farm == null ||
        ((farm.depositedAmount == null || farm.depositedAmount == 0) &&
            (farm.rewardAmount == null || farm.rewardAmount == 0))) {
      return const SizedBox.shrink();
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
                                                '${farm.depositedAmount!.formatNumber(precision: farm.depositedAmount! < 1 ? 8 : 3)}  ${farm.depositedAmount! < 1 ? AppLocalizations.of(context)!.lpToken : AppLocalizations.of(context)!.lpTokens}',
                                                style: style,
                                              ),
                                              SelectableText(
                                                ref.watch(
                                                  dexLPTokenFiatValueProvider(
                                                    farm.lpTokenPair!.token1,
                                                    farm.lpTokenPair!.token2,
                                                    farm.depositedAmount!,
                                                    farm.poolAddress,
                                                  ),
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
                                                '${farm.rewardAmount!.formatNumber(precision: farm.rewardAmount! < 1 ? 8 : 3)} ${farm.rewardToken!.symbol}',
                                                style: style,
                                              ),
                                              FutureBuilder<String>(
                                                future: FiatValue().display(
                                                  ref,
                                                  farm.rewardToken!,
                                                  farm.rewardAmount!,
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
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.15,
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .available,
                                            style: style!.copyWith(
                                              color: aedappfm.ArchethicThemeBase
                                                  .systemPositive600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Opacity(
                                      opacity: AppTextStyles.kOpacityText,
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.15,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .legacy,
                                              style: style,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 3),
                                              child: Icon(
                                                Icons.info_outline,
                                                size: 14,
                                              ),
                                            ),
                                          ],
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
                                                '${(farm.apr * 100).formatNumber(precision: 2)}%',
                                                style: style,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.125,
                                      child: FarmLegacyBtnWithdraw(
                                        enabled: farm.depositedAmount != null &&
                                            farm.depositedAmount! > 0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.125,
                                      child: FarmLegacyBtnClaim(
                                        enabled: farm.rewardAmount != null &&
                                            farm.rewardAmount! > 0,
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
                                                    '${farm.depositedAmount!.formatNumber(precision: farm.depositedAmount! < 1 ? 8 : 3)}  ${farm.depositedAmount! < 1 ? AppLocalizations.of(context)!.lpToken : AppLocalizations.of(context)!.lpTokens}',
                                                    style: style,
                                                  ),
                                                ],
                                              ),
                                              SelectableText(
                                                ref.watch(
                                                  dexLPTokenFiatValueProvider(
                                                    farm.lpTokenPair!.token1,
                                                    farm.lpTokenPair!.token2,
                                                    farm.depositedAmount!,
                                                    farm.poolAddress,
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
                                                    '${farm.rewardAmount!.formatNumber(precision: farm.rewardAmount! < 1 ? 8 : 3)} ${farm.rewardToken!.symbol}',
                                                    style: style,
                                                  ),
                                                ],
                                              ),
                                              FutureBuilder<String>(
                                                future: FiatValue().display(
                                                  ref,
                                                  farm.rewardToken!,
                                                  farm.rewardAmount!,
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
                                        SizedBox(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .available,
                                            style: style!.copyWith(
                                              color: aedappfm.ArchethicThemeBase
                                                  .systemPositive600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .legacy,
                                                style: style,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: 3,
                                                ),
                                                child: Icon(
                                                  Icons.info_outline,
                                                  size: 14,
                                                ),
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
                                                    '${(farm.apr * 100).formatNumber(precision: 2)}%',
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
                                                    child:
                                                        FarmLegacyBtnWithdraw(
                                                      enabled:
                                                          farm.depositedAmount !=
                                                                  null &&
                                                              farm.depositedAmount! >
                                                                  0,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: FarmLegacyBtnClaim(
                                                      enabled:
                                                          farm.rewardAmount !=
                                                                  null &&
                                                              farm.rewardAmount! >
                                                                  0,
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
                    Row(
                      children: [
                        Container(
                          width: aedappfm.Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width - 110
                              : MediaQuery.of(context).size.width - 30,
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: aedappfm.AppThemeBase.gradientWelcomeTxt,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
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
