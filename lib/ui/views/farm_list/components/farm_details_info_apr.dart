import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDetailsInfoAPR extends ConsumerWidget {
  const FarmDetailsInfoAPR({
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
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.farmDetailsInfoAPR,
              style: AppTextStyles.bodyLarge(context),
            ),
            SelectableText(
              '${(farm.apr * 100).formatNumber(precision: 2)}%',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).textTheme.headlineMedium!,
                    ),
                    color: aedappfm.AppThemeBase.secondaryColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
