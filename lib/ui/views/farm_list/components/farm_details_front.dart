import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_list/components/loading_field_indicator.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
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
  });

  final DexFarm farm;
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
            Padding(
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: DexPairIcons(
                                  token1Address:
                                      farm.lpTokenPair!.token1.address == null
                                          ? 'UCO'
                                          : farm.lpTokenPair!.token1.address!,
                                  token2Address:
                                      farm.lpTokenPair!.token2.address == null
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
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '${(farm.apr * 100).formatNumber(precision: 4)}%',
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
                                    padding: const EdgeInsets.only(bottom: 3),
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (farm.endDate.dateTime.isAfter(DateTime.now()))
                        Text(
                          'Farm ends at',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      else
                        Text(
                          'Farm ended',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      Text(
                        DateFormat.yMd(
                          Localizations.localeOf(context).languageCode,
                        ).add_Hm().format(farm.endDate.dateTime.toLocal()),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${userInfos.depositedAmount.formatNumber()} ${userInfos.depositedAmount > 1 ? 'LP Tokens' : 'LP Token'}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      '(\$${farm.estimateLPTokenInFiat.formatNumber(precision: 2)})',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your reward amount',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge,
                              ),
                              if (userInfos == null)
                                const LoadingFieldIndicator()
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${userInfos.rewardAmount.formatNumber(precision: 8)} ${farm.rewardToken!.symbol}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.copyWith(
                                            color: DexThemeBase.secondaryColor,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    FutureBuilder<String>(
                                      future: FiatValue().display(
                                        ref,
                                        farm.rewardToken!,
                                        userInfos.rewardAmount,
                                      ),
                                      builder: (context, fiatSnapshot) {
                                        if (!fiatSnapshot.hasData) {
                                          return const SizedBox.shrink();
                                        }

                                        final fiatValue = fiatSnapshot.data!;

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
            ),
          ],
        ),
      ],
    );
  }
}
