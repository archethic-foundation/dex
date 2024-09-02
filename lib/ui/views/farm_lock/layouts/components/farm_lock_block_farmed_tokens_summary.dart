import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockBlockFarmedTokensSummary extends ConsumerWidget {
  const FarmLockBlockFarmedTokensSummary({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);
    var opacity = AppTextStyles.kOpacityText;
    if (session.isConnected == false) {
      opacity = 0.5;
    }
    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);
    return BlockInfo(
      info: Column(
        children: [
          Row(
            children: [
              SelectableText(
                AppLocalizations.of(context)!
                    .aeswap_farmLockBlockFarmedTokensSummaryHeader,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Opacity(
                opacity: opacity,
                child: SelectableText(
                  '\$${farmLockForm.farmedTokensInFiat.formatNumber(precision: 2)}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Opacity(
                    opacity: AppTextStyles.kOpacityText,
                    child: SelectableText(
                      '${AppLocalizations.of(context)!.aeswap_farmLockBlockFarmedTokensSummaryCapitalInvestedLbl}: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Opacity(
                    opacity: opacity,
                    child: SelectableText(
                      '\$${farmLockForm.farmedTokensCapitalInFiat.formatNumber(precision: 2)}',
                      style: session.isConnected
                          ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: aedappfm.AppThemeBase.secondaryColor,
                              )
                          : Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Opacity(
                    opacity: AppTextStyles.kOpacityText,
                    child: SelectableText(
                      '${AppLocalizations.of(context)!.aeswap_farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl}: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Opacity(
                    opacity: opacity,
                    child: SelectableText(
                      '\$${farmLockForm.farmedTokensRewardsInFiat.formatNumber(precision: 2)}',
                      style: session.isConnected
                          ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: session.isConnected
                                    ? aedappfm.AppThemeBase.secondaryColor
                                    : aedappfm.AppThemeBase.primaryColor,
                              )
                          : Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
      width: width,
      height: height,
      backgroundWidget: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/coin-img.png',
            ),
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerRight,
            opacity: 0.2,
          ),
        ),
      ),
    );
  }
}
