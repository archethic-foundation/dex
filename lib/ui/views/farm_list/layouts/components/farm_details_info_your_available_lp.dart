import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoYourAvailableLP extends ConsumerWidget {
  const FarmDetailsInfoYourAvailableLP({
    super.key,
    required this.farm,
    required this.balance,
  });

  final DexFarm farm;
  final double? balance;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(sessionNotifierProvider);
    if (session.isConnected == false) {
      return const SizedBox(
        height: 190,
      );
    }

    final amounts = (balance == null || balance! <= 0)
        ? null
        : ref
            .watch(
              DexTokensProviders.getRemoveAmounts(farm.poolAddress, balance!),
            )
            .value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.farmDetailsInfoYourAvailableLP,
              style: AppTextStyles.bodyLarge(context),
            ),
            if (balance == null)
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
                balance == null
                    ? ''
                    : '${balance!.formatNumber()} ${balance! > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                style: AppTextStyles.bodyLarge(context),
              ),
          ],
        ),
        SelectableText(
          balance == null
              ? ''
              : ref.watch(
                  dexLPTokenFiatValueProvider(
                    farm.lpTokenPair!.token1,
                    farm.lpTokenPair!.token2,
                    balance!,
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
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
