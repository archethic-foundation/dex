import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';

import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'balance_details.dart';

class FarmDetailsUserInfo extends ConsumerWidget {
  const FarmDetailsUserInfo({
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
    if (session.isConnected) {
      return FutureBuilder<DexFarmUserInfos?>(
        future: ref.watch(
          FarmListProvider.userInfos(
            farm.farmAddress,
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
                  SelectableText(
                    'Your deposited amount',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge,
                  ),
                  if (userInfos == null)
                    const Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 0.5,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: 20,
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SelectableText(
                          '${userInfos.depositedAmount.formatNumber()} ${userInfos.depositedAmount > 1 ? 'LP Tokens' : 'LP Token'}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge,
                        ),
                        SelectableText(
                          DEXLPTokenFiatValue().display(
                            ref,
                            farm.lpTokenPair!.token1,
                            farm.lpTokenPair!.token2,
                            userInfos.depositedAmount,
                            farm.poolAddress,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
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
                    'Your reward amount',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge,
                  ),
                  if (userInfos == null)
                    const Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 0.5,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: 20,
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SelectableText(
                          '${userInfos.rewardAmount.formatNumber(precision: 8)} ${farm.rewardToken!.symbol}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                                color: aedappfm.AppThemeBase.secondaryColor,
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

                            return SelectableText(
                              fiatValue,
                              style: Theme.of(context).textTheme.bodyMedium,
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
      );
    } else {
      return _BalanceDetails(farm: farm);
    }
  }
}
