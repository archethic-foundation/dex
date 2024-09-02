import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoTVL extends ConsumerWidget {
  const PoolDetailsInfoTVL({
    super.key,
    required this.tvl,
  });

  final double tvl;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
          child: Opacity(
            opacity: AppTextStyles.kOpacityText,
            child: SelectableText(
              AppLocalizations.of(context)!.aeswap_poolDetailsInfoTVL,
              style: AppTextStyles.bodyLarge(context),
            ),
          ),
        ),
        SelectableText(
          '\$${tvl.formatNumber(precision: 2)}',
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
