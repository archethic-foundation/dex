import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
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
          AppLocalizations.of(context)!.farmDetailsInfoYourDepositedAmount,
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
                  userInfos != null
                      ? '${userInfos!.depositedAmount.formatNumber()} ${userInfos!.depositedAmount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}'
                      : '',
                  style: AppTextStyles.bodyLarge(context),
                ),
                SelectableText(
                  userInfos != null
                      ? DEXLPTokenFiatValue().display(
                          ref,
                          farm.lpTokenPair!.token1,
                          farm.lpTokenPair!.token2,
                          userInfos!.depositedAmount,
                          farm.poolAddress,
                        )
                      : '',
                  style: AppTextStyles.bodyMedium(context),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}