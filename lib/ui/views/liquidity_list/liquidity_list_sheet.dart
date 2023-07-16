import 'package:aedex/model/dex_pair.dart';
import 'package:aedex/model/dex_pool.dart';
import 'package:aedex/model/dex_token.dart';
import 'package:aedex/ui/themes/theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class LiquidityListSheet extends ConsumerWidget {
  const LiquidityListSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: ThemeBase.gradientMainScreen,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            gradient: ThemeBase.gradientSheetBackground,
            border: GradientBoxBorder(
              gradient: ThemeBase.gradientSheetBorder,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SelectionArea(
                        child: Text(
                          AppLocalizations.of(context)!.liquidityListTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 50,
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: ThemeBase.gradient,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: Column(
                  children: [
                    _buildWebsiteCard(
                      context,
                      ref,
                      const DexPool(
                        pair: DexPair(
                          token1: DexToken(name: 'Uniris Coin', symbol: 'UCO'),
                          token2:
                              DexToken(name: 'Wrapped Ether', symbol: 'WETH'),
                        ),
                      ),
                    ),
                    _buildWebsiteCard(
                      context,
                      ref,
                      const DexPool(
                        pair: DexPair(
                          token1: DexToken(name: 'Red Token', symbol: 'RTOK'),
                          token2:
                              DexToken(name: 'Wrapped Bitcoin', symbol: 'WBTC'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildWebsiteCard(BuildContext context, WidgetRef ref, DexPool pool) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      height: 60,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: ThemeBase.gradientSheetBorder,
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background.withOpacity(0.5),
                Theme.of(context).colorScheme.background.withOpacity(0.7),
              ],
              stops: const [0, 1],
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _contentCard(context, ref, pool),
      ),
    ),
  );
}

Widget _contentCard(BuildContext context, WidgetRef ref, DexPool pool) {
  return InkWell(
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${pool.pair!.token1.name}/${pool.pair!.token2.name}',
                style: const TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
