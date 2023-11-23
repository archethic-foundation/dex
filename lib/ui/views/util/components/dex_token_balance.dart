/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class DexTokenBalance extends StatelessWidget {
  const DexTokenBalance({
    required this.tokenBalance,
    required this.tokenSymbol,
    super.key,
  });

  final double tokenBalance;
  final String tokenSymbol;

  @override
  Widget build(BuildContext context) {
    if (tokenSymbol.isEmpty) {
      return const SizedBox(
        height: 30,
      );
    }

    return SizedBox(
      height: 30,
      child: Text(
        '${AppLocalizations.of(context)!.balance_title_infos} ${tokenBalance.formatNumber()} $tokenSymbol',
      )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 500),
          )
          .scale(
            duration: const Duration(milliseconds: 500),
          ),
    );
  }
}
