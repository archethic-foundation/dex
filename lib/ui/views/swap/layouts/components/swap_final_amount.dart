import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapFinalAmount extends ConsumerWidget {
  const SwapFinalAmount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.swapOk == false) return const SizedBox.shrink();

    final finalAmount = swap.finalAmount;
    final timeout = ref.watch(
      SwapFormProvider.swapForm.select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            '${AppLocalizations.of(context)!.swapFinalAmountAmountSwapped} ${finalAmount.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          )
        : timeout == false
            ? Row(
                children: [
                  SelectableText(
                    '${AppLocalizations.of(context)!.swapFinalAmountAmountSwapped} ',
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
              )
            : SelectableText(
                '${AppLocalizations.of(context)!.swapFinalAmountAmountSwapped} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 13,
                  ),
                ),
              );
  }
}
