/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveTokensGetBack extends ConsumerWidget {
  const LiquidityRemoveTokensGetBack({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.token1 == null || liquidityRemove.token2 == null) {
      return const SizedBox(height: 60);
    }
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          Text(
            '${liquidityRemove.token1!.name}: ${liquidityRemove.token1AmountGetBack.formatNumber()}',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.end,
          ),
          Text(
            '${liquidityRemove.token2!.name}: ${liquidityRemove.token2AmountGetBack.formatNumber()}',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
