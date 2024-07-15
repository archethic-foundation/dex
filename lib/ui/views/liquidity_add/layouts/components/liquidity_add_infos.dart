import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/app_styles.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddInfos extends ConsumerWidget {
  const LiquidityAddInfos({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null ||
        liquidityAdd.token2 == null ||
        (liquidityAdd.token1minAmount == 0 &&
            liquidityAdd.token2minAmount == 0 &&
            liquidityAdd.expectedTokenLP == 0)) {
      return const SizedBox.shrink();
    }

    if (liquidityAdd.calculationInProgress) {
      return Opacity(
        opacity: AppTextStyles.kOpacityText,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  message: liquidityAdd.token1!.symbol,
                  child: SelectableText(
                    '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token1!.symbol.reduceSymbol()}: ',
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  message: liquidityAdd.token2!.symbol,
                  child: SelectableText(
                    '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token2!.symbol.reduceSymbol()}: ',
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  AppLocalizations.of(context)!.liquidityAddInfosExpectedToken,
                  style: AppTextStyles.bodyMedium(context),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: liquidityAdd.token1!.symbol,
                child: SelectableText(
                  '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token1!.symbol.reduceSymbol()}',
                  style: AppTextStyles.bodyMedium(context),
                ),
              ),
              Tooltip(
                message: liquidityAdd.token1!.symbol,
                child: SelectableText(
                  '${liquidityAdd.token1minAmount.formatNumber()} ${liquidityAdd.token1!.symbol.reduceSymbol()}',
                  style: AppTextStyles.bodyMedium(context),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: liquidityAdd.token2!.symbol,
                child: SelectableText(
                  '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token2!.symbol.reduceSymbol()}',
                  style: AppTextStyles.bodyMedium(context),
                ),
              ),
              Tooltip(
                message: liquidityAdd.token2!.symbol,
                child: SelectableText(
                  '${liquidityAdd.token2minAmount.formatNumber()} ${liquidityAdd.token2!.symbol.reduceSymbol()}',
                  style: AppTextStyles.bodyMedium(context),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.liquidityAddInfosExpectedToken,
                style: AppTextStyles.bodyMedium(context),
              ),
              SelectableText(
                '${liquidityAdd.expectedTokenLP.formatNumber()} ${liquidityAdd.expectedTokenLP > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                style: liquidityAdd.expectedTokenLP == 0
                    ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: aedappfm.ArchethicThemeBase.systemWarning600,
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyMedium!,
                          ),
                        )
                    : AppTextStyles.bodyMedium(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
