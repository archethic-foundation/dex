import 'package:aedex/application/dex_token.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoYourDepositedAmount extends ConsumerWidget {
  const FarmDetailsInfoYourDepositedAmount({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final amounts = (farm.depositedAmount == null || farm.depositedAmount! <= 0)
        ? null
        : ref
            .watch(
              DexTokensProviders.getRemoveAmounts(
                farm.poolAddress,
                farm.depositedAmount!,
              ),
            )
            .value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.farmDetailsInfoYourDepositedAmount,
              style: AppTextStyles.bodyLarge(context),
            ),
            if (farm.depositedAmount == null)
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              )
            else
              SelectableText(
                farm.depositedAmount == null
                    ? ''
                    : '${farm.depositedAmount!.formatNumber()} ${farm.depositedAmount! > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                style: AppTextStyles.bodyLarge(context),
              ),
          ],
        ),
        SelectableText(
          farm.depositedAmount == null
              ? ''
              : ref.watch(
                  dexLPTokenFiatValueProvider(
                    farm.lpTokenPair!.token1,
                    farm.lpTokenPair!.token2,
                    farm.depositedAmount!,
                    farm.poolAddress,
                  ),
                ),
          style: AppTextStyles.bodyMedium(context),
        ),
        if (amounts == null)
          SelectableText(
            ' ',
            style: AppTextStyles.bodyMedium(context),
          )
        else
          SelectableText(
            '${AppLocalizations.of(context)!.poolDetailsInfoDepositedEquivalent} ${amounts.token1.formatNumber(precision: amounts.token1 > 1 ? 2 : 8)} ${farm.lpTokenPair!.token1.symbol.reduceSymbol()} / ${amounts.token2.formatNumber(precision: amounts.token2 > 1 ? 2 : 8)} ${farm.lpTokenPair!.token2.symbol.reduceSymbol()}',
            style: AppTextStyles.bodyMedium(context),
          ),
      ],
    );
  }
}
