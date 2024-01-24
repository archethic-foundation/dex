import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawConfirmInfos extends ConsumerWidget {
  const FarmWithdrawConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.dexFarmInfo == null) {
      return const SizedBox.shrink();
    }

    final session = ref.watch(SessionProviders.session);
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ArchethicThemeBase.blue800,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: ArchethicThemeBase.neutral900,
              blurRadius: 7,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please confirm the withdraw of ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: farmWithdraw.amount.formatNumber(precision: 8),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: DexThemeBase.secondaryColor,
                          ),
                    ),
                    TextSpan(
                      text:
                          ' ${farmWithdraw.amount > 1 ? 'LP Tokens' : 'LP Token'}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Your balance',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: DexThemeBase.gradient,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              FutureBuilder<double>(
                future: ref.watch(
                  BalanceProviders.getBalance(
                    session.genesisAddress,
                    farmWithdraw.dexFarmInfo!.lpToken!.isUCO
                        ? 'UCO'
                        : farmWithdraw.dexFarmInfo!.lpToken!.address!,
                  ).future,
                ),
                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DexTokenBalance(
                          tokenBalance: snapshot.data!,
                          tokenSymbol:
                              snapshot.data! > 1 ? 'LP Tokens' : 'LP Token',
                          withFiat: false,
                          height: 20,
                        ),
                        DexTokenBalance(
                          tokenBalance: (Decimal.parse(
                                    snapshot.data!.toString(),
                                  ) +
                                  Decimal.parse(
                                    farmWithdraw.amount.toString(),
                                  ))
                              .toDouble(),
                          tokenSymbol: (Decimal.parse(
                                            snapshot.data!.toString(),
                                          ) +
                                          Decimal.parse(
                                            farmWithdraw.amount.toString(),
                                          ))
                                      .toDouble() >
                                  1
                              ? 'LP Tokens'
                              : 'LP Token',
                          withFiat: false,
                          height: 20,
                        ),
                      ],
                    );
                  }
                  return const Row(children: [Text('')]);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Farm's balance",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: DexThemeBase.gradient,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: farmWithdraw.dexFarmInfo!.lpTokenDeposited,
                    tokenSymbol: farmWithdraw.dexFarmInfo!.lpTokenDeposited > 1
                        ? 'LP Tokens'
                        : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmWithdraw.dexFarmInfo!.lpTokenDeposited
                                  .toString(),
                            ) -
                            Decimal.parse(
                              farmWithdraw.amount.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: (Decimal.parse(
                                      farmWithdraw.dexFarmInfo!.lpTokenDeposited
                                          .toString(),
                                    ) -
                                    Decimal.parse(
                                      farmWithdraw.amount.toString(),
                                    ))
                                .toDouble() >
                            1
                        ? 'LP Tokens'
                        : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Rewards',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: DexThemeBase.gradient,
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder<String>(
                future: FiatValue().display(
                  ref,
                  farmWithdraw.dexFarmInfo!.rewardToken!.symbol,
                  farmWithdraw.dexFarmUserInfo!.rewardAmount,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'You will receive ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: farmWithdraw.dexFarmUserInfo!.rewardAmount
                                .formatNumber(precision: 8),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: DexThemeBase.secondaryColor,
                                    ),
                          ),
                          TextSpan(
                            text:
                                ' ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol} ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: '${snapshot.data}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
