import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsBack extends ConsumerWidget {
  const FarmDetailsBack({
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
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                                FormatAddressLinkCopy(
                                  address:
                                      snapshot.data!.farmAddress.toUpperCase(),
                                  header: '',
                                  typeAddress: TypeAddressLinkCopy.chain,
                                  reduceAddress: true,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize!,
                                ),
                                const SizedBox(
                                  height: 20,
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
                                          Icons.home,
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
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                        const SizedBox(
                          height: 10,
                        ),
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
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Distributed rewards',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${snapshot.data!.statsRewardDistributed.formatNumber(precision: 2)} ${snapshot.data!.rewardToken!.symbol}',
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                        const SizedBox(
                          height: 20,
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
