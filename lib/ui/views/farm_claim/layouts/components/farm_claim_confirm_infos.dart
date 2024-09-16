import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmClaimConfirmInfos extends ConsumerWidget {
  const FarmClaimConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    if (farmClaim.rewardAmount == null) {
      return const SizedBox.shrink();
    }
    final session = ref.watch(sessionNotifierProvider).value ?? const Session();

    final apiService = aedappfm.sl.get<archethic.ApiService>();
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: aedappfm.AppThemeBase.sheetBorderSecondary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                future: FiatValue().display(
                  ref,
                  farmClaim.rewardToken!,
                  farmClaim.rewardAmount!,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .farmClaimConfirmInfosText,
                            style: AppTextStyles.bodyLarge(context),
                          ),
                          TextSpan(
                            text: farmClaim.rewardAmount!
                                .formatNumber(precision: 8),
                            style:
                                AppTextStyles.bodyLargeSecondaryColor(context),
                          ),
                          TextSpan(
                            text: ' ${farmClaim.rewardToken!.symbol}',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                          TextSpan(
                            text: ' ${snapshot.data} ',
                            style: AppTextStyles.bodyLarge(context),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              FutureBuilder<double>(
                future: ref.watch(
                  getBalanceProvider(
                    session.genesisAddress,
                    farmClaim.rewardToken!.isUCO
                        ? 'UCO'
                        : farmClaim.rewardToken!.address!,
                    apiService,
                  ).future,
                ),
                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DexTokenBalance(
                          tokenBalance: snapshot.data!,
                          token: farmClaim.rewardToken,
                          digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                          withFiat: false,
                          height: 20,
                        ),
                        DexTokenBalance(
                          tokenBalance: (Decimal.parse(
                                    snapshot.data!.toString(),
                                  ) +
                                  Decimal.parse(
                                    farmClaim.rewardAmount.toString(),
                                  ))
                              .toDouble(),
                          token: farmClaim.rewardToken,
                          digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                          withFiat: false,
                          height: 20,
                        ),
                      ],
                    );
                  }
                  return const Row(children: [SelectableText('')]);
                },
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
