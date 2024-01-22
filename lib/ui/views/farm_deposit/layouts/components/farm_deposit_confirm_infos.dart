import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositConfirmInfos extends ConsumerWidget {
  const FarmDepositConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.dexFarmInfos == null) {
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
                'Please confirm the deposit of ${farmDeposit.amount.formatNumber()} ${farmDeposit.amount > 1 ? 'LP Tokens' : 'LP Token'}',
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
                    tokenBalance: farmDeposit.lpTokenBalance,
                    tokenSymbol: farmDeposit.lpTokenBalance > 1
                        ? 'LP Tokens'
                        : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmDeposit.lpTokenBalance.toString(),
                            ) -
                            Decimal.parse(
                              farmDeposit.amount.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: (Decimal.parse(
                                      farmDeposit.lpTokenBalance.toString(),
                                    ) -
                                    Decimal.parse(
                                      farmDeposit.amount.toString(),
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
                    tokenBalance: farmDeposit.dexFarmInfos!.lpTokenDeposited,
                    tokenSymbol: farmDeposit.dexFarmInfos!.lpTokenDeposited > 1
                        ? 'LP Tokens'
                        : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmDeposit.dexFarmInfos!.lpTokenDeposited
                                  .toString(),
                            ) -
                            Decimal.parse(
                              farmDeposit.amount.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: (Decimal.parse(
                                      farmDeposit.dexFarmInfos!.lpTokenDeposited
                                          .toString(),
                                    ) +
                                    Decimal.parse(
                                      farmDeposit.amount.toString(),
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
