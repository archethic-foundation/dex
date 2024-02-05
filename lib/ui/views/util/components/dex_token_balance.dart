/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexTokenBalance extends ConsumerWidget {
  const DexTokenBalance({
    required this.tokenBalance,
    this.token,
    this.withFiat = true,
    this.fiatVertical = false,
    this.fiatAlignLeft = false,
    this.fiatTextStyleMedium = false,
    this.height = 30,
    this.pool,
    super.key,
  });

  final double tokenBalance;
  final DexToken? token;
  final DexPool? pool;
  final bool withFiat;
  final double height;
  final bool fiatVertical;
  final bool fiatAlignLeft;
  final bool fiatTextStyleMedium;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (token == null || token!.symbol.isEmpty) {
      return SizedBox(
        height: height,
      );
    }
    var opacity = 1.0;
    if (tokenBalance <= 0) {
      opacity = 0.5;
    }

    return fiatVertical
        ? Column(
            crossAxisAlignment: fiatAlignLeft
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.empty_wallet,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity: opacity,
                    child: SelectableText(
                      '${tokenBalance.formatNumber(precision: 8)} ${getSymbolDisplay(token!, tokenBalance)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (withFiat)
                    if (token != null && pool != null && token!.isLpToken)
                      Opacity(
                        opacity: opacity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          child: SelectableText(
                            DEXLPTokenFiatValue().display(
                              ref,
                              pool!.pair.token1,
                              pool!.pair.token2,
                              tokenBalance,
                              pool!.poolAddress,
                            ),
                            style: fiatTextStyleMedium
                                ? Theme.of(context).textTheme.bodyMedium
                                : Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      )
                    else
                      FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          token!,
                          tokenBalance,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Opacity(
                              opacity: opacity,
                              child: SelectableText(
                                snapshot.data!,
                                style: fiatTextStyleMedium
                                    ? Theme.of(context).textTheme.bodyMedium
                                    : Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                ],
              ),
            ],
          )
            .animate()
            .fade(
              duration: const Duration(milliseconds: 200),
            )
            .scale(
              duration: const Duration(milliseconds: 200),
            )
        : SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.empty_wallet,
                  size: 14,
                ),
                const SizedBox(
                  width: 5,
                ),
                Opacity(
                  opacity: opacity,
                  child: SelectableText(
                    '${tokenBalance.formatNumber(precision: 8)} ${getSymbolDisplay(token!, tokenBalance)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                if (withFiat)
                  if (token != null && pool != null && token!.isLpToken)
                    Opacity(
                      opacity: opacity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: SelectableText(
                          DEXLPTokenFiatValue().display(
                            ref,
                            pool!.pair.token1,
                            pool!.pair.token2,
                            tokenBalance,
                            pool!.poolAddress,
                          ),
                          style: fiatTextStyleMedium
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    )
                  else
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        token!,
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
                              child: SelectableText(
                                snapshot.data!,
                                style: fiatTextStyleMedium
                                    ? Theme.of(context).textTheme.bodyMedium
                                    : Theme.of(context).textTheme.bodyLarge,
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

  String getSymbolDisplay(DexToken token, double balance) {
    if (token.isLpToken == true) {
      if (balance > 1) {
        return 'LP Tokens';
      } else {
        return 'LP Token';
      }
    }
    return token.symbol;
  }
}
