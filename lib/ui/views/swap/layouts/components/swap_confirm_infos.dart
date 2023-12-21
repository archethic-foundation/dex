import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_infos.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapConfirmInfos extends ConsumerWidget {
  const SwapConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.tokenToSwap == null) {
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
                'Swap',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '    - ${swap.tokenToSwapAmount.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '≈ + ${swap.tokenSwappedAmount.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
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
                    tokenBalance: swap.tokenToSwapBalance,
                    tokenSymbol: swap.tokenToSwap!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              swap.tokenToSwapBalance.toString(),
                            ) -
                            Decimal.parse(swap.tokenToSwapAmount.toString()))
                        .toDouble(),
                    tokenSymbol: swap.tokenToSwap!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: swap.tokenSwappedBalance,
                    tokenSymbol: swap.tokenSwapped!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              swap.tokenSwappedBalance.toString(),
                            ) +
                            Decimal.parse(swap.tokenSwappedAmount.toString()))
                        .toDouble(),
                    tokenSymbol: swap.tokenSwapped!.symbol,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10),
                child: const SwapInfos(),
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
