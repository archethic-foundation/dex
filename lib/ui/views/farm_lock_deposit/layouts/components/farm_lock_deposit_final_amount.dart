import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositFinalAmount extends ConsumerWidget {
  const FarmLockDepositFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    if (farmLockDeposit.farmLockDepositOk == false) {
      return const SizedBox.shrink();
    }

    final finalAmount = farmLockDeposit.finalAmount;
    final timeout = ref.watch(
      farmLockDepositFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            '${AppLocalizations.of(context)!.farmLockDepositFinalAmount} ${finalAmount.formatNumber(precision: 8)} ${finalAmount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
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
                    AppLocalizations.of(context)!.farmLockDepositFinalAmount,
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
                '${AppLocalizations.of(context)!.farmLockDepositFinalAmount} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 13,
                  ),
                ),
              );
  }
}
