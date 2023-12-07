/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
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
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.liquidityRemoveTokensGetBackHeader,
          ),
          Row(
            children: [
              Text(
                '${liquidityRemove.token1!.symbol}: +${liquidityRemove.token1AmountGetBack.formatNumber()} ${liquidityRemove.token1!.symbol}',
                overflow: TextOverflow.visible,
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
                    liquidityRemove.token1!.symbol,
                    liquidityRemove.token1AmountGetBack,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
            ],
          ),
          Row(
            children: [
              Text(
                '${liquidityRemove.token2!.symbol}: +${liquidityRemove.token2AmountGetBack.formatNumber()} ${liquidityRemove.token2!.symbol}',
                overflow: TextOverflow.visible,
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
                    liquidityRemove.token2!.symbol,
                    liquidityRemove.token2AmountGetBack,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
