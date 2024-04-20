/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenIconRefresh extends ConsumerWidget {
  const SwapTokenIconRefresh({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefreshSuccess =
        ref.watch(SwapFormProvider.swapForm).refreshInProgress;

    return InkWell(
      onTap: () async {
        if (isRefreshSuccess) return;
        ref.read(SwapFormProvider.swapForm.notifier).setRefreshInProgress(true);

        ref.invalidate(aedappfm.CoinPriceProviders.coinPrice);
        await ref.read(aedappfm.CoinPriceProviders.coinPrice.notifier).init();
        final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);
        final swap = ref.read(SwapFormProvider.swapForm);

        if (swap.tokenToSwap != null && swap.tokenSwapped != null) {
          await swapNotifier.calculateSwapInfos(
            swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address!,
            swap.tokenToSwapAmount,
          );
          await swapNotifier.getRatio();
          await swapNotifier.getPool();
        }

        await Future.delayed(const Duration(seconds: 3));
        ref
            .read(SwapFormProvider.swapForm.notifier)
            .setRefreshInProgress(false);
      },
      child: Tooltip(
        message: 'Refresh information',
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                    .withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: isRefreshSuccess
                ? aedappfm.ArchethicThemeBase.systemPositive600
                : aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                    .withOpacity(1),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                isRefreshSuccess ? Icons.check : aedappfm.Iconsax.refresh,
                size: 16,
                color: isRefreshSuccess ? Colors.white : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
