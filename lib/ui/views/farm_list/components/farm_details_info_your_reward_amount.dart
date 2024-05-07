import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoYourRewardAmount extends ConsumerWidget {
  const FarmDetailsInfoYourRewardAmount({
    super.key,
    required this.farm,
    required this.userInfos,
  });

  final DexFarm farm;
  final DexFarmUserInfos? userInfos;

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
          AppLocalizations.of(context)!.farmDetailsInfoYourRewardAmount,
          style: AppTextStyles.bodyLarge(context),
        ),
        Wrap(
          children: [
            if (userInfos == null)
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
                  userInfos == null
                      ? ''
                      : '${userInfos!.rewardAmount.formatNumber(precision: 8)} ${farm.rewardToken!.symbol}',
                  style: AppTextStyles.bodyLargeSecondaryColor(context),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (userInfos == null)
                  SelectableText(
                    '',
                    style: AppTextStyles.bodyMedium(context),
                  )
                else
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      farm.rewardToken!,
                      userInfos!.rewardAmount,
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
