import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_infos.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddConfirmInfos extends ConsumerWidget {
  const LiquidityAddConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 20,
        left: 50,
        right: 50,
      ),
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
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add liquidity in the pool'),
              Text(
                '+ ${liquidityAdd.token1Amount.formatNumber()} ${liquidityAdd.token1!.symbol}',
              ),
              Text(
                '+ ${liquidityAdd.token2Amount.formatNumber()} ${liquidityAdd.token2!.symbol}',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityAdd.token1Balance,
                    tokenSymbol: liquidityAdd.token1!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.token1Balance.toString(),
                            ) -
                            Decimal.parse(liquidityAdd.token1Amount.toString()))
                        .toDouble(),
                    tokenSymbol: liquidityAdd.token1!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityAdd.token2Balance,
                    tokenSymbol: liquidityAdd.token2!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.token2Balance.toString(),
                            ) -
                            Decimal.parse(liquidityAdd.token2Amount.toString()))
                        .toDouble(),
                    tokenSymbol: liquidityAdd.token2!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityAdd.lpTokenBalance,
                    tokenSymbol: liquidityAdd.pool!.lpToken!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.lpTokenBalance.toString(),
                            ) +
                            Decimal.parse(
                              liquidityAdd.expectedTokenLP.toString(),
                            ))
                        .toDouble(),
                    tokenSymbol: liquidityAdd.pool!.lpToken!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10),
                child: const LiquidityAddInfos(),
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
