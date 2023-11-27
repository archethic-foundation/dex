/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DexRatio extends StatelessWidget {
  const DexRatio({
    required this.ratio,
    required this.token1Symbol,
    required this.token2Symbol,
    super.key,
  });

  final double ratio;
  final String token1Symbol;
  final String token2Symbol;

  @override
  Widget build(BuildContext context) {
    if (token1Symbol.isEmpty || token2Symbol.isEmpty || ratio <= 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      child: Text(
        '${double.parse('1').formatNumber()} $token1Symbol = ${ratio.formatNumber()} $token2Symbol',
      ),
    )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 500),
        )
        .scale(
          duration: const Duration(milliseconds: 500),
        );
  }
}