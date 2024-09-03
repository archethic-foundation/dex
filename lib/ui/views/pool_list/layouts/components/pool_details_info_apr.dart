import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoAPR extends ConsumerWidget {
  const PoolDetailsInfoAPR({
    super.key,
    required this.tvl,
    required this.fee24h,
  });

  final double tvl;
  final double fee24h;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2, right: 5),
                child: Tooltip(
                  message: AppLocalizations.of(context)!.aeswap_apr24hTooltip,
                  triggerMode: TooltipTriggerMode.tap,
                  showDuration: const Duration(seconds: 5),
                  child: Icon(
                    Icons.help,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: AppTextStyles.kOpacityText,
              child: Stack(
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
                      AppLocalizations.of(context)!.aeswap_poolDetailsInfoAPR,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (tvl > 0)
          SelectableText(
            '${(Decimal.parse(fee24h.toString()) * Decimal.parse('365') * Decimal.parse('100') / Decimal.parse(tvl.toString())).toDouble().formatNumber(precision: 2)}%',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                    context,
                    Theme.of(context).textTheme.headlineMedium!,
                  ),
                  color: aedappfm.AppThemeBase.secondaryColor,
                ),
          )
        else
          SelectableText(
            '0.00%',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                    context,
                    Theme.of(context).textTheme.headlineMedium!,
                  ),
                  color: aedappfm.AppThemeBase.secondaryColor,
                ),
          ),
      ],
    );
  }
}
