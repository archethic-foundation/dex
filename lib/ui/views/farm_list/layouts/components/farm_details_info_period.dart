import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FarmDetailsInfoPeriod extends ConsumerWidget {
  const FarmDetailsInfoPeriod({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      children: [
        if (farm.startDate != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (farm.startDate!.isAfter(DateTime.now()))
                SelectableText(
                  AppLocalizations.of(context)!
                      .aeswap_farmDetailsInfoPeriodWillStart,
                  style: AppTextStyles.bodyLarge(context),
                )
              else
                SelectableText(
                  AppLocalizations.of(context)!
                      .aeswap_farmDetailsInfoPeriodStarted,
                  style: AppTextStyles.bodyLarge(context),
                ),
              SelectableText(
                DateFormat.yMd(
                  Localizations.localeOf(context).languageCode,
                ).add_Hm().format(farm.startDate!.toLocal()),
                style: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
        if (farm.endDate != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (farm.endDate!.isAfter(DateTime.now()))
                SelectableText(
                  AppLocalizations.of(context)!
                      .aeswap_farmDetailsInfoPeriodEndAt,
                  style: AppTextStyles.bodyLarge(context),
                )
              else
                SelectableText(
                  AppLocalizations.of(context)!
                      .aeswap_farmDetailsInfoPeriodEnded,
                  style: AppTextStyles.bodyLarge(context),
                ),
              SelectableText(
                DateFormat.yMd(
                  Localizations.localeOf(context).languageCode,
                ).add_Hm().format(farm.endDate!.toLocal()),
                style: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
      ],
    );
  }
}
