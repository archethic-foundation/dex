import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoDistributedRewards extends ConsumerWidget {
  const FarmDetailsInfoDistributedRewards({
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
          AppLocalizations.of(context)!.farmDetailsInfoDistributedRewards,
          style: AppTextStyles.bodyLarge(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectableText(
              '${farm.statsRewardDistributed.formatNumber(precision: 2)} ${farm.rewardToken!.symbol}',
              style: AppTextStyles.bodyLarge(context),
            ),
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                farm.rewardToken!,
                farm.statsRewardDistributed,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SelectableText(
                    snapshot.data!,
                    style: AppTextStyles.bodyMedium(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ],
    );
  }
}
