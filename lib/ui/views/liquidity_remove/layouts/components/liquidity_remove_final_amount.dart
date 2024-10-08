import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveFinalAmount extends ConsumerWidget {
  const LiquidityRemoveFinalAmount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    if (liquidityRemove.liquidityRemoveOk == false) {
      return const SizedBox.shrink();
    }

    final finalAmountToken1 = liquidityRemove.finalAmountToken1;
    final finalAmountToken2 = liquidityRemove.finalAmountToken2;
    final finalAmountLPToken = liquidityRemove.finalAmountLPToken;
    final timeout = ref.watch(
      liquidityRemoveFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (timeout == false)
          if (finalAmountToken1 != null)
            SelectableText(
              '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenObtained} ${finalAmountToken1.formatNumber(precision: 8)} ${liquidityRemove.token1!.symbol}',
              style: TextStyle(
                fontSize: aedappfm.Responsive.fontSizeFromValue(
                  context,
                  desktopValue: 13,
                ),
              ),
            )
          else
            Row(
              children: [
                SelectableText(
                  '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenObtained} ',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ],
            ),
        if (timeout == false)
          if (finalAmountToken2 != null)
            SelectableText(
              '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenObtained} ${finalAmountToken2.formatNumber(precision: 8)} ${liquidityRemove.token2!.symbol}',
              style: TextStyle(
                fontSize: aedappfm.Responsive.fontSizeFromValue(
                  context,
                  desktopValue: 13,
                ),
              ),
            )
          else
            Row(
              children: [
                SelectableText(
                  '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenObtained} ',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ],
            ),
        if (timeout == false)
          if (finalAmountLPToken != null)
            SelectableText(
              '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenBurned} ${finalAmountLPToken.formatNumber(precision: 8)} ${finalAmountLPToken > 1 ? 'LP Tokens' : 'LP Token'}',
              style: TextStyle(
                fontSize: aedappfm.Responsive.fontSizeFromValue(
                  context,
                  desktopValue: 13,
                ),
              ),
            )
          else
            Row(
              children: [
                SelectableText(
                  '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenBurned} ',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ],
            ),
        if (timeout == true)
          SelectableText(
            '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenObtained} ${AppLocalizations.of(context)!.finalAmountsNotRecovered}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          ),
      ],
    );
  }
}
