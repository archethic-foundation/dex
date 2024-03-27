import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsBack extends ConsumerWidget {
  const FarmDetailsBack({
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
                          FormatAddressLinkCopy(
                            address: farm.farmAddress.toUpperCase(),
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        'Remaining reward',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SelectableText(
                            '${farm.remainingReward.formatNumber()} ${farm.rewardToken!.symbol}',
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
                          FutureBuilder<String>(
                            future: FiatValue().display(
                              ref,
                              farm.rewardToken!,
                              farm.remainingReward,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SelectableText(
                                  snapshot.data!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodyMedium!,
                                        ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        'LP Token deposited',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SelectableText(
                            '${farm.lpTokenDeposited.formatNumber(precision: 8)} ${farm.lpTokenDeposited > 1 ? 'LP Tokens' : 'LP Token'}',
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
                            '(\$${farm.estimateLPTokenInFiat.formatNumber(precision: 2)})',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyMedium!,
                                  ),
                                ),
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
                      SelectableText(
                        'Nb deposit',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
                      ),
                      SelectableText(
                        farm.nbDeposit.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        'Distributed rewards',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SelectableText(
                            '${farm.statsRewardDistributed.formatNumber(precision: 2)} ${farm.rewardToken!.symbol}',
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
                          FutureBuilder<String>(
                            future: FiatValue().display(
                              ref,
                              farm.rewardToken!,
                              farm.statsRewardDistributed,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SelectableText(
                                  snapshot.data!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .bodyMedium!,
                                        ),
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
                  const SizedBox(
                    height: 20,
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
