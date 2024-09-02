import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawFinalAmount extends ConsumerWidget {
  const FarmWithdrawFinalAmount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.farmWithdrawOk == false) return const SizedBox.shrink();

    final finalAmountReward = farmWithdraw.finalAmountReward;
    final finalAmountWithdraw = farmWithdraw.finalAmountWithdraw;
    final timeout = ref.watch(
      FarmWithdrawFormProvider.farmWithdrawForm
          .select((value) => value.failure != null),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (finalAmountWithdraw != null)
          SelectableText(
            '${AppLocalizations.of(context)!.aeswap_farmWithdrawFinalAmount} ${finalAmountWithdraw.formatNumber(precision: 8)} ${finalAmountWithdraw > 1 ? AppLocalizations.of(context)!.aeswap_lpTokens : AppLocalizations.of(context)!.aeswap_lpToken}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          )
        else if (timeout == false)
          Row(
            children: [
              SelectableText(
                AppLocalizations.of(context)!.aeswap_farmWithdrawFinalAmount,
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
        else
          SelectableText(
            '${AppLocalizations.of(context)!.aeswap_farmWithdrawFinalAmount} ${AppLocalizations.of(context)!.aeswap_finalAmountNotRecovered}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          ),
        if (finalAmountReward != null)
          if ((farmWithdraw.isFarmClose && farmWithdraw.rewardAmount! > 0) ||
              farmWithdraw.isFarmClose == false)
            SelectableText(
              '${AppLocalizations.of(context)!.aeswap_farmWithdrawFinalAmountReward} ${finalAmountReward.formatNumber(precision: 8)} ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol}',
              style: TextStyle(
                fontSize: aedappfm.Responsive.fontSizeFromValue(
                  context,
                  desktopValue: 13,
                ),
              ),
            )
          else
            const SizedBox.shrink()
        else if (timeout == false)
          if (farmWithdraw.rewardAmount! > 0)
            Row(
              children: [
                SelectableText(
                  AppLocalizations.of(context)!
                      .aeswap_farmWithdrawFinalAmountReward,
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
          else
            const SizedBox.shrink()
        else
          SelectableText(
            '${AppLocalizations.of(context)!.aeswap_farmWithdrawFinalAmountReward} ${AppLocalizations.of(context)!.aeswap_finalAmountNotRecovered}',
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
