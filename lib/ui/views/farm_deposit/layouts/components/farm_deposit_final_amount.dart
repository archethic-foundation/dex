import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositFinalAmount extends ConsumerWidget {
  const FarmDepositFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.farmDepositOk == false) return const SizedBox.shrink();

    final finalAmount = farmDeposit.finalAmount;
    final timeout = ref.watch(
      FarmDepositFormProvider.farmDepositForm
          .select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            '${AppLocalizations.of(context)!.farmDepositFinalAmount} ${finalAmount.formatNumber(precision: 8)} ${finalAmount > 1 ? 'LP Tokens' : 'LP Token'}',
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
                    AppLocalizations.of(context)!.farmDepositFinalAmount,
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
                '${AppLocalizations.of(context)!.farmDepositFinalAmount} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 13,
                  ),
                ),
              );
  }
}
