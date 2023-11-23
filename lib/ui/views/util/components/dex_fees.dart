/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class DexFees extends StatelessWidget {
  const DexFees({
    required this.fees,
    this.withLabel = true,
    super.key,
  });

  final double fees;
  final bool withLabel;

  @override
  Widget build(BuildContext context) {
    if (fees == 0) {
      return const SizedBox(
        height: 30,
      );
    }

    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ArchethicThemeBase.blue500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: withLabel
          ? Text(
              '${AppLocalizations.of(context)!.feesLbl}: $fees%',
              style: textTheme.labelSmall,
            )
          : Text(
              '$fees%',
              style: textTheme.labelSmall,
            ),
    );
  }
}
