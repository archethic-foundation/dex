import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_list/components/loading_field_indicator.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_apr_value.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

part 'balance_details.dart';

class FarmDetailsFront extends ConsumerWidget {
  const FarmDetailsFront({
    super.key,
    required this.farm,
    required this.toggleCard,
  });
  final DexFarm farm;
  final VoidCallback toggleCard;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            FutureBuilder<DexFarm?>(
              future: ref.watch(
                DexFarmProviders.getFarmInfos(
                  farm.farmAddress,
                  farm.poolAddress,
                  dexFarmInput: farm,
                ).future,
              ),
              builder: (context, farmInfosSnapshot) {
                final farmInfos = farmInfosSnapshot.data;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${farm.lpTokenPair!.token1.symbol}/${farm.lpTokenPair!.token2.symbol}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: DexPairIcons(
                                      token1Address: farm.lpTokenPair!.token1
                                                  .address ==
                                              null
                                          ? 'UCO'
                                          : farm.lpTokenPair!.token1.address!,
                                      token2Address: farm.lpTokenPair!.token2
                                                  .address ==
                                              null
                                          ? 'UCO'
                                          : farm.lpTokenPair!.token2.address!,
                                      iconSize: 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Current APR',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  if (farmInfos == null)
                                    LoadingFieldIndicator(
                                      style: LoadingFieldIndicatorStyle(
                                        color: DexThemeBase.secondaryColor,
                                        dimension: 25,
                                        strokeWidth: 3,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 3,
                                      ),
                                    )
                                  else
                                    Text(
                                      DEXAprValue().display(
                                        ref,
                                        farm.farmAddress,
                                        farmInfos.remainingRewardInFiat,
                                        farmInfos.lpTokenPair!.token1,
                                        farmInfos.lpTokenPair!.token2,
                                        farmInfos.lpTokenDeposited,
                                        farm.endDate,
                                        farm.poolAddress,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            color: DexThemeBase.secondaryColor,
                                          ),
                                    ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Earn ${farm.rewardToken!.symbol}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3),
                                        child: DexTokenIcon(
                                          tokenAddress:
                                              farm.rewardToken!.address == null
                                                  ? 'UCO'
                                                  : farm.rewardToken!.address!,
                                          iconSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: DexThemeBase.backgroundPopupColor,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                  color: ArchethicThemeBase.purple500,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 7,
                                      bottom: 5,
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      'Farming',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color:
                                                ArchethicThemeBase.raspberry300,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: toggleCard,
                                child: SizedBox(
                                  height: 40,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color:
                                            DexThemeBase.backgroundPopupColor,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 0,
                                    color: DexThemeBase.backgroundPopupColor,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: ArchethicThemeBase.raspberry300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (farmInfos == null ||
                              farmInfos.endDate.dateTime
                                  .isAfter(DateTime.now()))
                            Text(
                              'Farm ends at',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          else
                            Text(
                              'Farm ended',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          if (farmInfos == null)
                            const LoadingFieldIndicator()
                          else
                            Text(
                              DateFormat.yMd(
                                Localizations.localeOf(context).languageCode,
                              )
                                  .add_Hm()
                                  .format(farmInfos.endDate.dateTime.toLocal()),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<DexFarmUserInfos?>(
                        future: ref.watch(
                          FarmListProvider.userInfos(
                            farm,
                          ).future,
                        ),
                        builder: (context, userInfosSnapshot) {
                          final userInfos = userInfosSnapshot.data;

                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Your deposited amount',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                  if (userInfos == null)
                                    const LoadingFieldIndicator()
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${userInfos.depositedAmount.formatNumber()} ${userInfos.depositedAmount > 1 ? 'LP Tokens' : 'LP Token'}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge,
                                        ),
                                        Text(
                                          DEXLPTokenFiatValue().display(
                                            ref,
                                            farm.lpTokenPair!.token1,
                                            farm.lpTokenPair!.token2,
                                            userInfos.depositedAmount,
                                            farm.poolAddress,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Your reward amount',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                  if (userInfos == null || farmInfos == null)
                                    const LoadingFieldIndicator()
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${userInfos.rewardAmount.formatNumber(precision: 8)} ${farmInfos.rewardToken!.symbol}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.copyWith(
                                                color:
                                                    DexThemeBase.secondaryColor,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        FutureBuilder<String>(
                                          future: FiatValue().display(
                                            ref,
                                            farmInfos.rewardToken!.symbol,
                                            userInfos.rewardAmount,
                                          ),
                                          builder: (context, fiatSnapshot) {
                                            if (!fiatSnapshot.hasData) {
                                              return const SizedBox.shrink();
                                            }

                                            final fiatValue =
                                                fiatSnapshot.data!;

                                            return Text(
                                              fiatValue,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _BalanceDetails(farm: farm),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
