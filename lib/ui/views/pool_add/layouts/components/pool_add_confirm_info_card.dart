import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmInfoCard extends ConsumerWidget {
  const PoolAddConfirmInfoCard({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    final poolAdd = ref.read(PoolAddFormProvider.poolAddForm);
    if (poolAdd.token1 == null) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            ArchethicThemeBase.blue800,
            BlendMode.modulate,
          ),
          image: const AssetImage(
            'assets/images/background-sub-menu.png',
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: ArchethicThemeBase.neutral900,
            blurRadius: 7,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.poolAddConfirmNewPoolLbl,
                ),
                Text(
                  AppLocalizations.of(context)!.poolAddConfirmWithLiquidityLbl,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            poolAdd.token1!.symbol,
                            style: textTheme.titleLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                poolAdd.token1!.name,
                                style: textTheme.labelSmall,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (poolAdd.token1!.isUCO == false)
                                FormatAddressLink(
                                  address: poolAdd.token1!.isUCO
                                      ? 'UCO'
                                      : poolAdd.token1!.address!,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: VerifiedTokenIcon(
                                  address: poolAdd.token1!.isUCO
                                      ? 'UCO'
                                      : poolAdd.token1!.address!,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            poolAdd.token2!.symbol,
                            style: textTheme.titleLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                poolAdd.token2!.name,
                                style: textTheme.labelSmall,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (poolAdd.token2!.isUCO == false)
                                FormatAddressLink(
                                  address: poolAdd.token2!.isUCO
                                      ? 'UCO'
                                      : poolAdd.token2!.address!,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: VerifiedTokenIcon(
                                  address: poolAdd.token2!.isUCO
                                      ? 'UCO'
                                      : poolAdd.token2!.address!,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Text(
                        '+ ${poolAdd.token1Amount} ${poolAdd.token1!.symbol}',
                        style: textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Text(
                        '+ ${poolAdd.token2Amount} ${poolAdd.token2!.symbol}',
                        style: textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DexRatio(
              ratio: (Decimal.parse(poolAdd.token2Amount.toString()) /
                      Decimal.parse(poolAdd.token1Amount.toString()))
                  .toDouble(),
              token1Symbol: poolAdd.token1!.symbol,
              token2Symbol: poolAdd.token2!.symbol,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}