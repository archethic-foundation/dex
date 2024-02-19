import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
                      color: aedappfm.ArchethicThemeBase.systemDanger500,
                    ) ??
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: aedappfm.ArchethicThemeBase.systemDanger500,
                        )
                : priceImpact > 1
                    ? textStyle?.copyWith(
                          color: aedappfm.ArchethicThemeBase.systemWarning600,
                        ) ??
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color:
                                  aedappfm.ArchethicThemeBase.systemWarning600,
                            )
                    : textStyle ?? Theme.of(context).textTheme.bodyLarge,
          )
        else
          SelectableText(
            '${priceImpact.formatNumber()}%',
            style: priceImpact > 5
                ? textStyle?.copyWith(
                      color: aedappfm.ArchethicThemeBase.systemDanger500,
                    ) ??
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: aedappfm.ArchethicThemeBase.systemDanger500,
                        )
                : priceImpact > 1
                    ? textStyle?.copyWith(
                          color: aedappfm.ArchethicThemeBase.systemWarning600,
                        ) ??
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color:
                                  aedappfm.ArchethicThemeBase.systemWarning600,
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
                    ? aedappfm.ArchethicThemeBase.systemDanger500
                    : aedappfm.ArchethicThemeBase.systemWarning600,
                size: 15,
              ),
            ),
          ),
      ],
    );
  }
}
