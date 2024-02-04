import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/format_address_link.dart';
import 'package:aedex/ui/views/util/components/verified_token_icon.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmInfos extends ConsumerWidget {
  const PoolAddConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final poolAdd = ref.read(PoolAddFormProvider.poolAddForm);
    if (poolAdd.token1 == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ArchethicThemeBase.blue800,
          borderRadius: BorderRadius.circular(24),
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
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.poolAddConfirmNewPoolLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .poolAddConfirmWithLiquidityLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
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
                      Row(
                        children: [
                          Text(
                            poolAdd.token1!.symbol,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: DexThemeBase.secondaryColor,
                                    ),
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
                      Text(
                        ' ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          Text(
                            poolAdd.token2!.symbol,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: DexThemeBase.secondaryColor,
                                    ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '+ ${poolAdd.token1Amount.formatNumber()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: DexThemeBase.secondaryColor,
                                  ),
                            ),
                            TextSpan(
                              text: ' ${poolAdd.token1!.symbol}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FutureBuilder<String>(
                            future: FiatValue().display(
                              ref,
                              poolAdd.token1!,
                              poolAdd.token1Amount,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '+ ${poolAdd.token2Amount.formatNumber()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: DexThemeBase.secondaryColor,
                                      ),
                                ),
                                TextSpan(
                                  text: ' ${poolAdd.token2!.symbol}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FutureBuilder<String>(
                                future: FiatValue().display(
                                  ref,
                                  poolAdd.token2!,
                                  poolAdd.token2Amount,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: DexThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (poolAdd.token1Amount > 0)
                    DexRatio(
                      ratio: (Decimal.parse(poolAdd.token2Amount.toString()) /
                              Decimal.parse(poolAdd.token1Amount.toString()))
                          .toDouble(),
                      token1Symbol: poolAdd.token1!.symbol,
                      token2Symbol: poolAdd.token2!.symbol,
                    ),
                  if (poolAdd.token2Amount > 0)
                    DexRatio(
                      ratio: (Decimal.parse(poolAdd.token1Amount.toString()) /
                              Decimal.parse(poolAdd.token2Amount.toString()))
                          .toDouble(),
                      token1Symbol: poolAdd.token2!.symbol,
                      token2Symbol: poolAdd.token1!.symbol,
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: DexThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: poolAdd.token1Balance,
                    token: poolAdd.token1,
                    height: 20,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              poolAdd.token1Balance.toString(),
                            ) -
                            Decimal.parse(poolAdd.token1Amount.toString()))
                        .toDouble(),
                    token: poolAdd.token1,
                    height: 20,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: poolAdd.token2Balance,
                    token: poolAdd.token2,
                    height: 20,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              poolAdd.token2Balance.toString(),
                            ) -
                            Decimal.parse(poolAdd.token2Amount.toString()))
                        .toDouble(),
                    token: poolAdd.token2,
                    height: 20,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
