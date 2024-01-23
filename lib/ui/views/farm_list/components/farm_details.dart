import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_all_info_popup.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_apr_value.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FarmDetails extends ConsumerWidget {
  const FarmDetails({
    super.key,
    required this.farm,
    this.allInfo = false,
  });
  final DexFarm farm;
  final bool allInfo;

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
            FutureBuilder<DexFarm?>(
              future: ref.watch(
                DexFarmProviders.getFarmInfos(
                  farm.farmAddress,
                  farm.poolAddress,
                  dexFarmInput: farm,
                ).future,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final timestampEndDate = DateFormat.yMd(
                    Localizations.localeOf(context).languageCode,
                  ).add_Hm().format(
                        DateTime.fromMillisecondsSinceEpoch(
                          snapshot.data!.endDate * 1000,
                        ).toLocal(),
                      );
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
                                if (allInfo)
                                  FormatAddressLinkCopy(
                                    address: snapshot.data!.farmAddress
                                        .toUpperCase(),
                                    header: '',
                                    typeAddress: TypeAddress.chain,
                                    reduceAddress: true,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .fontSize!,
                                  ),
                                const SizedBox(
                                  height: 20,
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
                                    FutureBuilder<String>(
                                      future: DEXAprValue().display(
                                        ref,
                                        farm.farmAddress,
                                        snapshot.data!.remainingReward,
                                        snapshot.data!.lpTokenPair!.token1,
                                        snapshot.data!.lpTokenPair!.token2,
                                        snapshot.data!.lpTokenDeposited,
                                        farm.poolAddress,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                  color: DexThemeBase
                                                      .secondaryColor,
                                                ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (allInfo == false)
                              Row(
                                children: [
                                  SizedBox(
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
                                                color: ArchethicThemeBase
                                                    .raspberry300,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await FarmDetailsAllInfoPopup.getDialog(
                                        context,
                                        farm,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: DexThemeBase
                                                .backgroundPopupColor,
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        elevation: 0,
                                        color:
                                            DexThemeBase.backgroundPopupColor,
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
                                            color:
                                                ArchethicThemeBase.raspberry300,
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
                            if (DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data!.endDate * 1000,
                            ).isAfter(DateTime.now()))
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
                              timestampEndDate,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (allInfo)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Remaining reward',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${snapshot.data!.remainingReward.formatNumber()} ${snapshot.data!.rewardToken!.symbol}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  FutureBuilder<String>(
                                    future: FiatValue().display(
                                      ref,
                                      snapshot.data!.rewardToken!.symbol,
                                      snapshot.data!.remainingReward,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (allInfo)
                          const SizedBox(
                            height: 10,
                          ),
                        if (allInfo)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'LP Token deposited',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${snapshot.data!.lpTokenDeposited.formatNumber()} ${snapshot.data!.lpTokenDeposited > 1 ? 'LP Tokens' : 'LP Token'}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  FutureBuilder<String>(
                                    future: DEXLPTokenFiatValue().display(
                                      ref,
                                      farm.lpTokenPair!.token1,
                                      farm.lpTokenPair!.token2,
                                      snapshot.data!.lpTokenDeposited,
                                      farm.poolAddress,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (allInfo)
                          const SizedBox(
                            height: 10,
                          ),
                        if (allInfo)
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
                        if (allInfo)
                          const SizedBox(
                            height: 15,
                          ),
                        if (allInfo)
                          Container(
                            height: 0.5,
                            color: Colors.white,
                          ),
                        if (allInfo == false)
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: DexThemeBase.gradientLine,
                            ),
                          ),
                        const SizedBox(
                          height: 20,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Deposited amount',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${snapshot2.data!.depositedAmount.formatNumber()} ${snapshot2.data!.depositedAmount > 1 ? 'LP Tokens' : 'LP Token'}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                          ),
                                          FutureBuilder<String>(
                                            future:
                                                DEXLPTokenFiatValue().display(
                                              ref,
                                              farm.lpTokenPair!.token1,
                                              farm.lpTokenPair!.token2,
                                              snapshot2.data!.depositedAmount,
                                              farm.poolAddress,
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                );
                                              }
                                              return const SizedBox.shrink();
                                            },
                                          ),
                                          if (allInfo)
                                            Text(
                                              '${snapshot2.data!.depositedAmount * 100 / snapshot.data!.lpTokenDeposited} % of the farm',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Your reward amount',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${snapshot2.data!.rewardAmount.formatNumber(precision: 8)} ${snapshot.data!.rewardToken!.symbol}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyLarge!.copyWith(
                                                  color: DexThemeBase
                                                      .secondaryColor,
                                                ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          FutureBuilder<String>(
                                            future: FiatValue().display(
                                              ref,
                                              snapshot
                                                  .data!.rewardToken!.symbol,
                                              snapshot2.data!.rewardAmount,
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                );
                                              }
                                              return const SizedBox.shrink();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Your available LP Tokens',
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodyLarge,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${snapshot3.data!.formatNumber()} ${snapshot3.data! > 1 ? 'LP Tokens' : 'LP Token'}',
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyLarge,
                                                    ),
                                                    FutureBuilder<String>(
                                                      future:
                                                          DEXLPTokenFiatValue()
                                                              .display(
                                                        ref,
                                                        farm.lpTokenPair!
                                                            .token1,
                                                        farm.lpTokenPair!
                                                            .token2,
                                                        snapshot3.data!,
                                                        farm.poolAddress,
                                                      ),
                                                      builder: (
                                                        context,
                                                        snapshot,
                                                      ) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            snapshot.data!,
                                                            style: Theme.of(
                                                              context,
                                                            )
                                                                .textTheme
                                                                .bodyMedium,
                                                          );
                                                        }
                                                        return const SizedBox
                                                            .shrink();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            if (allInfo == false)
                                              const SizedBox(
                                                height: 40,
                                              ),
                                            if (allInfo == false)
                                              Column(
                                                children: [
                                                  DexButtonValidate(
                                                    background:
                                                        ArchethicThemeBase
                                                            .purple500,
                                                    controlOk:
                                                        snapshot3.data! > 0,
                                                    labelBtn:
                                                        'Deposit LP Tokens',
                                                    onPressed: () {
                                                      ref
                                                          .read(
                                                            MainScreenWidgetDisplayedProviders
                                                                .mainScreenWidgetDisplayedProvider
                                                                .notifier,
                                                          )
                                                          .setWidget(
                                                            FarmDepositSheet(
                                                              farm: snapshot
                                                                  .data!,
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
                                                        child:
                                                            DexButtonValidate(
                                                          background:
                                                              ArchethicThemeBase
                                                                  .purple500,
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
                                                        child:
                                                            DexButtonValidate(
                                                          background:
                                                              ArchethicThemeBase
                                                                  .purple500,
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
                                                                    farmUserInfo:
                                                                        snapshot2
                                                                            .data!,
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
