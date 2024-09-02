import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoYourRewardAmount extends ConsumerWidget {
  const FarmDetailsInfoYourRewardAmount({
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
          AppLocalizations.of(context)!.aeswap_farmDetailsInfoYourRewardAmount,
          style: AppTextStyles.bodyLarge(context),
        ),
        Wrap(
          children: [
            if (farm.rewardAmount == null)
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SelectableText(
                  farm.rewardAmount == null
                      ? ''
                      : '${farm.rewardAmount!.formatNumber(precision: 8)} ${farm.rewardToken!.symbol}',
                  style: AppTextStyles.bodyLargeSecondaryColor(context),
                ),
                if (farm.rewardAmount != null)
                  const SizedBox(
                    width: 5,
                  ),
                if (farm.rewardAmount != null)
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      farm.rewardToken!,
                      farm.rewardAmount!,
                    ),
                    builder: (context, fiatSnapshot) {
                      if (!fiatSnapshot.hasData) {
                        return SelectableText(
                          '',
                          style: AppTextStyles.bodyMedium(context),
                        );
                      }

                      final fiatValue = fiatSnapshot.data!;

                      return SelectableText(
                        fiatValue,
                        style: AppTextStyles.bodyMedium(context),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
