import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_user_info.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
                              SelectableText(
                                '${farm.lpTokenPair!.token1.symbol}/${farm.lpTokenPair!.token2.symbol}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context)
                                            .textTheme
                                            .headlineMedium!,
                                      ),
                                    ),
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
                              SelectableText(
                                'Current APR',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context).textTheme.bodyLarge!,
                                      ),
                                    ),
                              ),
                              SelectableText(
                                '${(farm.apr * 100).formatNumber(precision: 4)}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context)
                                            .textTheme
                                            .headlineMedium!,
                                      ),
                                      color:
                                          aedappfm.AppThemeBase.secondaryColor,
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
                                  SelectableText(
                                    'Earn ${farm.rewardToken!.symbol}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .headlineSmall!,
                                          ),
                                        ),
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
                  if (farm.startDate != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (farm.startDate!.isAfter(DateTime.now()))
                          SelectableText(
                            'Farm will start at',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          )
                        else
                          SelectableText(
                            'Farm started since',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          ),
                        SelectableText(
                          DateFormat.yMd(
                            Localizations.localeOf(context).languageCode,
                          ).add_Hm().format(farm.startDate!.toLocal()),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyLarge!,
                                ),
                              ),
                        ),
                      ],
                    ),
                  if (farm.endDate != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (farm.endDate!.isAfter(DateTime.now()))
                          SelectableText(
                            'Farm ends at',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          )
                        else
                          SelectableText(
                            'Farm ended',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                          ),
                        SelectableText(
                          DateFormat.yMd(
                            Localizations.localeOf(context).languageCode,
                          ).add_Hm().format(farm.endDate!.toLocal()),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyLarge!,
                                ),
                              ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 9,
                  ),
                  FarmDetailsUserInfo(farm: farm),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
