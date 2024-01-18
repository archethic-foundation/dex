import 'dart:ui';

import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FarmListSheet extends ConsumerWidget {
  const FarmListSheet({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: FutureBuilder<List<DexFarm>>(
        future: ref.watch(
          DexFarmProviders.getFarmList.future,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
              children: snapshot.data!.map((farm) {
                return FarmCard(farm: farm);
              }).toList(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class FarmCard extends StatelessWidget {
  const FarmCard({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: DexThemeBase.backgroundPopupColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
              left: 20,
              right: 20,
            ),
            child: FarmDetails(farm: farm),
          ),
        ),
      ),
    );
  }
}

class FarmDetails extends ConsumerWidget {
  const FarmDetails({
    super.key,
    required this.farm,
  });
  final DexFarm farm;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              '${farm.lpToken!.name} Farming Pool',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 40,
            ),
            FutureBuilder<DexFarm?>(
              future: ref.watch(
                DexFarmProviders.getFarmInfos(
                  farm.farmAddress,
                  dexFarmInput: farm,
                ).future,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final timestampStartDate = DateFormat.yMd(
                    Localizations.localeOf(context).languageCode,
                  ).add_Hm().format(
                        DateTime.fromMillisecondsSinceEpoch(
                          snapshot.data!.startDate * 1000,
                        ).toLocal(),
                      );
                  final timestampEndDate = DateFormat.yMd(
                    Localizations.localeOf(context).languageCode,
                  ).add_Hm().format(
                        DateTime.fromMillisecondsSinceEpoch(
                          snapshot.data!.endDate * 1000,
                        ).toLocal(),
                      );
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Farm address',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            FormatAddressLinkCopy(
                              address: snapshot.data!.farmAddress.toUpperCase(),
                              header: '',
                              typeAddress: TypeAddress.chain,
                              reduceAddress: true,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize!,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reward delivery period',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '$timestampStartDate to $timestampEndDate',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Remaining reward',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '${snapshot.data!.remainingReward.formatNumber()} ${snapshot.data!.rewardToken!.symbol}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'LP Token deposited',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '${snapshot.data!.lpTokenDeposited.formatNumber()}  ${snapshot.data!.lpToken!.symbol}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nb deposit',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              snapshot.data!.nbDeposit.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<DexFarmUserInfos?>(
                          future: ref.watch(
                            DexFarmProviders.getUserInfos(
                              snapshot.data!.farmAddress,
                              session.genesisAddress,
                            ).future,
                          ),
                          builder: (context, snapshot2) {
                            if (snapshot2.hasData) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Deposited amount',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      Text(
                                        '${snapshot2.data!.depositedAmount.formatNumber()} ${snapshot.data!.lpToken!.symbol}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Reward amount',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      Text(
                                        '${snapshot2.data!.rewardAmount.formatNumber(precision: 8)} ${snapshot.data!.rewardToken!.symbol}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<double>(
                                    future: ref.watch(
                                      BalanceProviders.getBalance(
                                        session.genesisAddress,
                                        snapshot.data!.lpToken!.isUCO
                                            ? 'UCO'
                                            : snapshot.data!.lpToken!.address!,
                                      ).future,
                                    ),
                                    builder: (
                                      context,
                                      snapshot3,
                                    ) {
                                      if (snapshot3.hasData) {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Your LP Token',
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodyLarge,
                                                ),
                                                Text(
                                                  '${snapshot3.data!.formatNumber()} ${snapshot.data!.lpToken!.symbol}',
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodyLarge,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            Column(
                                              children: [
                                                DexButtonValidate(
                                                  controlOk:
                                                      snapshot3.data! > 0,
                                                  labelBtn: 'Deposit LP Tokens',
                                                  onPressed: () {
                                                    ref
                                                        .read(
                                                          MainScreenWidgetDisplayedProviders
                                                              .mainScreenWidgetDisplayedProvider
                                                              .notifier,
                                                        )
                                                        .setWidget(
                                                          FarmDepositSheet(
                                                            farm:
                                                                snapshot.data!,
                                                          ),
                                                          ref,
                                                        );
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: DexButtonValidate(
                                                        controlOk: snapshot
                                                                .data!
                                                                .lpTokenDeposited >
                                                            0,
                                                        labelBtn: 'Withdraw',
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                MainScreenWidgetDisplayedProviders
                                                                    .mainScreenWidgetDisplayedProvider
                                                                    .notifier,
                                                              )
                                                              .setWidget(
                                                                FarmWithdrawSheet(
                                                                  farm: snapshot
                                                                      .data!,
                                                                ),
                                                                ref,
                                                              );
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: DexButtonValidate(
                                                        controlOk: true,
                                                        labelBtn: 'Claim',
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                MainScreenWidgetDisplayedProviders
                                                                    .mainScreenWidgetDisplayedProvider
                                                                    .notifier,
                                                              )
                                                              .setWidget(
                                                                FarmClaimSheet(
                                                                  farm: snapshot
                                                                      .data!,
                                                                ),
                                                                ref,
                                                              );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ],
    );
  }
}
