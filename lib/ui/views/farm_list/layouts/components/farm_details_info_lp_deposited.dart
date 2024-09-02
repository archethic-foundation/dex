import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoLPDeposited extends ConsumerWidget {
  const FarmDetailsInfoLPDeposited({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SelectableText(
            AppLocalizations.of(context)!.aeswap_farmDetailsInfoLPDeposited,
            style: AppTextStyles.bodyLarge(context),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectableText(
              '${farm.lpTokenDeposited.formatNumber(precision: 8)} ${farm.lpTokenDeposited > 1 ? AppLocalizations.of(context)!.aeswap_lpTokens : AppLocalizations.of(context)!.aeswap_lpToken}',
              style: AppTextStyles.bodyLarge(context),
            ),
            SelectableText(
              '(\$${farm.estimateLPTokenInFiat.formatNumber(precision: 2)})',
              style: AppTextStyles.bodyLarge(context),
            ),
            if (farm.lpTokenDeposited > 0)
              FutureBuilder<Map<String, dynamic>?>(
                future: PoolFactoryRepositoryImpl(
                  farm.poolAddress,
                  aedappfm.sl.get<ApiService>(),
                ).getRemoveAmounts(
                  farm.lpTokenDeposited,
                ),
                builder: (
                  context,
                  snapshotAmounts,
                ) {
                  if (snapshotAmounts.hasData && snapshotAmounts.data != null) {
                    final amountToken1 = snapshotAmounts.data!['token1'] == null
                        ? 0.0
                        : snapshotAmounts.data!['token1'] as double;
                    final amountToken2 = snapshotAmounts.data!['token2'] == null
                        ? 0.0
                        : snapshotAmounts.data!['token2'] as double;

                    return SelectableText(
                      '${AppLocalizations.of(context)!.aeswap_poolDetailsInfoDepositedEquivalent} ${amountToken1.formatNumber(precision: amountToken1 > 1 ? 2 : 8)} ${farm.lpTokenPair!.token1.symbol.reduceSymbol()} / ${amountToken2.formatNumber(precision: amountToken2 > 1 ? 2 : 8)} ${farm.lpTokenPair!.token2.symbol.reduceSymbol()}',
                      style: AppTextStyles.bodyMedium(context),
                    );
                  }
                  return SelectableText(
                    ' ',
                    style: AppTextStyles.bodyMedium(context),
                  );
                },
              )
            else
              SelectableText(' ', style: AppTextStyles.bodyMedium(context)),
          ],
        ),
      ],
    );
  }
}
