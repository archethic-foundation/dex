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
    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      return const SizedBox(
        height: 190,
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.farmDetailsInfoYourAvailableLP,
              style: AppTextStyles.bodyLarge(context),
            ),
            Wrap(
              children: [
                if (balance == null)
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
                      balance == null
                          ? ''
                          : '${balance!.formatNumber()} ${balance! > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    SelectableText(
                      balance == null
                          ? ''
                          : DEXLPTokenFiatValue().display(
                              ref,
                              farm.lpTokenPair!.token1,
                              farm.lpTokenPair!.token2,
                              balance!,
                              farm.poolAddress,
                            ),
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
