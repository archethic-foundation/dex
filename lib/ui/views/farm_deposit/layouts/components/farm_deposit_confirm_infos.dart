import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
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
    if (farmDeposit.dexFarmInfo == null) {
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
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please confirm the deposit of ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: farmDeposit.amount.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: DexThemeBase.secondaryColor,
                          ),
                    ),
                    TextSpan(
                      text:
                          ' ${farmDeposit.amount > 1 ? 'LP Tokens' : 'LP Token'}',
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
                    tokenBalance: farmDeposit.dexFarmInfo!.lpTokenDeposited,
                    tokenSymbol: farmDeposit.dexFarmInfo!.lpTokenDeposited > 1
                        ? 'LP Tokens'
                        : 'LP Token',
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              farmDeposit.dexFarmInfo!.lpTokenDeposited
                                  .toString(),
                            ) +
                            Decimal.parse(
                              farmDeposit.amount.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: (Decimal.parse(
                                      farmDeposit.dexFarmInfo!.lpTokenDeposited
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
