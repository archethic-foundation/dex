import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmBalance extends ConsumerWidget {
  const PoolAddConfirmBalance({
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

    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        bottom: 20,
        left: 50,
        right: 50,
      ),
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
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.confirmYourBalanceLbl),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${poolAdd.token1Balance.formatNumber()} ${poolAdd.token1!.symbol}',
                  ),
                  Text(
                    '${(Decimal.parse(poolAdd.token1Balance.toString()) - Decimal.parse(poolAdd.token1Amount.toString())).toDouble().formatNumber()} ${poolAdd.token1!.symbol}',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      poolAdd.token1!,
                      poolAdd.token1Balance,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      poolAdd.token1!,
                      (Decimal.parse(poolAdd.token1Balance.toString()) -
                              Decimal.parse(poolAdd.token1Amount.toString()))
                          .toDouble(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${poolAdd.token2Balance.formatNumber()} ${poolAdd.token2!.symbol}',
                  ),
                  Text(
                    '${(Decimal.parse(poolAdd.token2Balance.toString()) - Decimal.parse(poolAdd.token2Amount.toString())).toDouble().formatNumber()} ${poolAdd.token2!.symbol}',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      poolAdd.token2!,
                      poolAdd.token2Balance,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      poolAdd.token2!,
                      (Decimal.parse(poolAdd.token2Balance.toString()) -
                              Decimal.parse(poolAdd.token2Amount.toString()))
                          .toDouble(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
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
