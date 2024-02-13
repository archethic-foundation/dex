import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';

class DexPriceImpact extends StatelessWidget {
  const DexPriceImpact({
    required this.priceImpact,
    this.withLabel = true,
    this.textStyle,
    super.key,
  });

  final double priceImpact;
  final bool? withLabel;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (withLabel!)
          SelectableText(
            'Price impact: ${priceImpact.formatNumber()}%',
            style: priceImpact > 5
                ? textStyle?.copyWith(
                      color: ArchethicThemeBase.systemDanger500,
                    ) ??
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ArchethicThemeBase.systemDanger500,
                        )
                : priceImpact > 1
                    ? textStyle?.copyWith(
                          color: ArchethicThemeBase.systemWarning600,
                        ) ??
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ArchethicThemeBase.systemWarning600,
                            )
                    : textStyle ?? Theme.of(context).textTheme.bodyLarge,
          )
        else
          SelectableText(
            '${priceImpact.formatNumber()}%',
            style: priceImpact > 5
                ? textStyle?.copyWith(
                      color: ArchethicThemeBase.systemDanger500,
                    ) ??
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ArchethicThemeBase.systemDanger500,
                        )
                : priceImpact > 1
                    ? textStyle?.copyWith(
                          color: ArchethicThemeBase.systemWarning600,
                        ) ??
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ArchethicThemeBase.systemWarning600,
                            )
                    : textStyle ?? Theme.of(context).textTheme.bodyLarge,
          ),
        if (priceImpact > 1)
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Tooltip(
              message: 'Warning, the price impact is high.',
              child: Icon(
                Icons.warning,
                color: priceImpact > 5
                    ? ArchethicThemeBase.systemDanger500
                    : ArchethicThemeBase.systemWarning600,
                size: 15,
              ),
            ),
          ),
      ],
    );
  }
}
