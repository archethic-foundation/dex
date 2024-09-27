import 'package:aedex/application/dex_token.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoLPDeposited extends ConsumerWidget {
  const FarmLockDetailsInfoLPDeposited({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final amounts = farmLock.lpTokensDeposited <= 0
        ? null
        : ref
            .watch(
              DexTokensProviders.getRemoveAmounts(
                farmLock.poolAddress,
                farmLock.lpTokensDeposited,
              ),
            )
            .value;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SelectableText(
            AppLocalizations.of(context)!.farmDetailsInfoLPDeposited,
            style: AppTextStyles.bodyLarge(context),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectableText(
              '${farmLock.lpTokensDeposited.formatNumber(precision: 8)} ${farmLock.lpTokensDeposited > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
              style: AppTextStyles.bodyLarge(context),
            ),
            SelectableText(
              '(\$${farmLock.estimateLPTokenInFiat.formatNumber(precision: 2)})',
              style: AppTextStyles.bodyLarge(context),
            ),
            if (amounts == null)
              SelectableText(' ', style: AppTextStyles.bodyMedium(context))
            else
              SelectableText(
                '${AppLocalizations.of(context)!.poolDetailsInfoDepositedEquivalent} ${amounts.token1.formatNumber(precision: amounts.token1 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token1.symbol.reduceSymbol()} / ${amounts.token2.formatNumber(precision: amounts.token2 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token2.symbol.reduceSymbol()}',
                style: AppTextStyles.bodyMedium(context),
              ),
          ],
        ),
      ],
    );
  }
}
