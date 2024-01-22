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
              Text(
                'Please confirm the withdraw of ${farmWithdraw.amount.formatNumber()} ${farmWithdraw.amount > 1 ? 'LP Tokens' : 'LP Token'}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Your balance',
                style: Theme.of(context).textTheme.bodyLarge,
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
                    tokenBalance: farmWithdraw.dexFarmUserInfo!.depositedAmount,
                    tokenSymbol:
                        farmWithdraw.dexFarmUserInfo!.depositedAmount > 1
                            ? 'LP Tokens'
                            : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmWithdraw.dexFarmUserInfo!.depositedAmount
                                  .toString(),
                            ) +
                            Decimal.parse(
                              farmWithdraw.amount.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: (Decimal.parse(
                                      farmWithdraw
                                          .dexFarmUserInfo!.depositedAmount
                                          .toString(),
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
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Farm's balance",
                style: Theme.of(context).textTheme.bodyLarge,
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
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Rewards',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              FutureBuilder<String>(
                future: FiatValue().display(
                  ref,
                  farmWithdraw.dexFarmInfo!.rewardToken!.symbol,
                  farmWithdraw.dexFarmUserInfo!.rewardAmount,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'You will receive ${farmWithdraw.dexFarmUserInfo!.rewardAmount.formatNumber()} ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol} ${snapshot.data}',
                      style: Theme.of(context).textTheme.bodyLarge,
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
