import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimFinalAmount extends ConsumerWidget {
  const FarmClaimFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmClaim = ref.watch(farmClaimFormNotifierProvider);
    if (farmClaim.farmClaimOk == false) return const SizedBox.shrink();

    final finalAmount = farmClaim.finalAmount;
    final timeout = ref.watch(
      farmClaimFormNotifierProvider.select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            '${AppLocalizations.of(context)!.farmClaimFinalAmount} ${finalAmount.formatNumber(precision: 8)} ${farmClaim.rewardToken!.symbol}',
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
                    AppLocalizations.of(context)!.farmClaimFinalAmount,
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
                '${AppLocalizations.of(context)!.farmClaimFinalAmount} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 13,
                  ),
                ),
              );
  }
}
