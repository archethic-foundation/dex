import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
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

    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Container(
      padding: const EdgeInsets.only(
        top: 50,
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
            top: 60,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.poolAddConfirmYourBalanceLbl),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .poolAddConfirmBalanceBeforeLbl,
                  ),
                  Text(
                    AppLocalizations.of(context)!.poolAddConfirmBalanceAfterLbl,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${liquidityAdd.token1Balance.formatNumber()} ${liquidityAdd.token1!.symbol}',
                  ),
                  Text(
                    '${(Decimal.parse(liquidityAdd.token1Balance.toString()) - Decimal.parse(liquidityAdd.token1Amount.toString())).toDouble().formatNumber()} ${liquidityAdd.token1!.symbol}',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      liquidityAdd.token1!.symbol,
                      liquidityAdd.token1Balance,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      liquidityAdd.token1!.symbol,
                      (Decimal.parse(liquidityAdd.token1Balance.toString()) -
                              Decimal.parse(
                                liquidityAdd.token1Amount.toString(),
                              ))
                          .toDouble(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
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
                    '${liquidityAdd.token2Balance.formatNumber()} ${liquidityAdd.token2!.symbol}',
                  ),
                  Text(
                    '${(Decimal.parse(liquidityAdd.token2Balance.toString()) - Decimal.parse(liquidityAdd.token2Amount.toString())).toDouble().formatNumber()} ${liquidityAdd.token2!.symbol}',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      liquidityAdd.token2!.symbol,
                      liquidityAdd.token2Balance,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      liquidityAdd.token2!.symbol,
                      (Decimal.parse(liquidityAdd.token2Balance.toString()) -
                              Decimal.parse(
                                liquidityAdd.token2Amount.toString(),
                              ))
                          .toDouble(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Text('Expected LP Token: +${liquidityAdd.expectedTokenLP}'),
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
