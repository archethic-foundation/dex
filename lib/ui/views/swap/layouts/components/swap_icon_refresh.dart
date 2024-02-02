/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/coin_price.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenIconRefresh extends ConsumerWidget {
  const SwapTokenIconRefresh({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        ref.invalidate(CoinPriceProviders.coinPrice);
        await ref.read(CoinPriceProviders.coinPrice.notifier).init();
        final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);
        final swap = ref.read(SwapFormProvider.swapForm);
        await swapNotifier.calculateSwapInfos(
          swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address!,
          swap.tokenToSwapAmount,
        );
        await swapNotifier.getRatio();
        await swapNotifier.getPool();
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 5, bottom: 4),
        child: Icon(Iconsax.refresh, size: 14),
      ),
    );
  }
}
