import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoFees extends ConsumerWidget {
  const PoolDetailsInfoFees({
    super.key,
    required this.feesAllTime,
    required this.fees24h,
    this.poolWithFarm = false,
  });

  final double? feesAllTime;
  final double? fees24h;
  final bool poolWithFarm;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (poolWithFarm) {
      return const SizedBox(
        height: 30,
      );
    }
    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectableText(
                      AppLocalizations.of(context)!.aeswap_time24h,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodySmall!,
                            ),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SelectableText(
                      AppLocalizations.of(context)!.aeswap_poolDetailsInfoFees,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                ],
              ),
              SelectableText(
                fees24h == null
                    ? ''
                    : ': \$${fees24h!.formatNumber(precision: 2)}',
                style: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectableText(
                      AppLocalizations.of(context)!.aeswap_timeAll,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodySmall!,
                            ),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: SelectableText(
                      AppLocalizations.of(context)!.aeswap_poolDetailsInfoFees,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                ],
              ),
              SelectableText(
                feesAllTime == null
                    ? ''
                    : ': \$${feesAllTime!.formatNumber(precision: 2)}',
                style: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
