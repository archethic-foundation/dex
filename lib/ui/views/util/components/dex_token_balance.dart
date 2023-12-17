/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexTokenBalance extends ConsumerWidget {
  const DexTokenBalance({
    required this.tokenBalance,
    required this.tokenSymbol,
    this.withFiat = true,
    this.height = 30,
    super.key,
  });

  final double tokenBalance;
  final String tokenSymbol;
  final bool withFiat;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (tokenSymbol.isEmpty) {
      return SizedBox(
        height: height,
      );
    }
    var opacity = 1.0;
    if (tokenBalance <= 0) {
      opacity = 0.5;
    }

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Icon(
              Iconsax.empty_wallet,
              size: 14,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Opacity(
            opacity: opacity,
            child: Text(
              '${tokenBalance.formatNumber()} $tokenSymbol',
            ),
          ),
          if (withFiat)
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                tokenSymbol,
                tokenBalance,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: Text(
                        snapshot.data!,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 200),
        )
        .scale(
          duration: const Duration(milliseconds: 200),
        );
  }
}
