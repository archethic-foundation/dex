import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoFees extends ConsumerWidget {
  const PoolDetailsInfoFees({
    super.key,
    required this.feesAllTime,
    required this.fees24h,
  });

  final double? feesAllTime;
  final double? fees24h;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SelectableText(
                AppLocalizations.of(context)!.time24h,
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
                AppLocalizations.of(context)!.poolDetailsInfoFees,
                style: AppTextStyles.bodyLarge(context),
              ),
            ),
          ],
        ),
        SelectableText(
          fees24h == null
              ? ''
              : '\$${fees24h!.formatNumber(precision: fees24h! > 1 ? 2 : 8)}',
          style: AppTextStyles.bodyLarge(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SelectableText(
                AppLocalizations.of(context)!.timeAll,
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
                AppLocalizations.of(context)!.poolDetailsInfoFees,
                style: AppTextStyles.bodyLarge(context),
              ),
            ),
          ],
        ),
        SelectableText(
          feesAllTime == null
              ? ''
              : '\$${feesAllTime!.formatNumber(precision: feesAllTime! > 1 ? 2 : 8)}',
          style: AppTextStyles.bodyLarge(context),
        ),
      ],
    );
  }
}
