/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveTokensGetBack extends ConsumerWidget {
  const LiquidityRemoveTokensGetBack({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.lpTokenAmount <= 0 ||
        liquidityRemove.lpTokenAmount > liquidityRemove.lpTokenBalance) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            AppLocalizations.of(context)!.liquidityRemoveTokensGetBackHeader,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                liquidityRemove.token1!.symbol,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.end,
              ),
              Row(
                children: [
                  SelectableText(
                    '+ ${liquidityRemove.token1AmountGetBack.formatNumber(precision: 8)} ${liquidityRemove.token1!.symbol}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (liquidityRemove.token1 != null &&
                      liquidityRemove.token1AmountGetBack > 0)
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        liquidityRemove.token1!,
                        liquidityRemove.token1AmountGetBack,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SelectableText(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                liquidityRemove.token2!.symbol,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.end,
              ),
              Row(
                children: [
                  SelectableText(
                    '+ ${liquidityRemove.token2AmountGetBack.formatNumber(precision: 8)} ${liquidityRemove.token2!.symbol}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (liquidityRemove.token2 != null &&
                      liquidityRemove.token2AmountGetBack > 0)
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        liquidityRemove.token2!,
                        liquidityRemove.token2AmountGetBack,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SelectableText(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.bodyMedium,
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
    );
  }
}
