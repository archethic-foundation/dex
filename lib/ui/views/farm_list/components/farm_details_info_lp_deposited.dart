import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
        SelectableText(
          AppLocalizations.of(context)!.farmDetailsInfoLPDeposited,
          style: AppTextStyles.bodyLarge(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectableText(
              '${farm.lpTokenDeposited.formatNumber(precision: 8)} ${farm.lpTokenDeposited > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
              style: AppTextStyles.bodyLarge(context),
            ),
            SelectableText(
              '(\$${farm.estimateLPTokenInFiat.formatNumber(precision: 2)})',
              style: AppTextStyles.bodyLarge(context),
            ),
          ],
        ),
      ],
    );
  }
}
