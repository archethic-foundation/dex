/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenIconRefresh extends ConsumerStatefulWidget {
  const SwapTokenIconRefresh({
    super.key,
  });

  @override
  ConsumerState<SwapTokenIconRefresh> createState() =>
      _SwapTokenIconRefreshState();
}

class _SwapTokenIconRefreshState extends ConsumerState<SwapTokenIconRefresh> {
  bool? isRefreshSuccess;

  @override
  void initState() {
    super.initState();
    isRefreshSuccess = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isRefreshSuccess != null && isRefreshSuccess == true) return;
        setState(
          () {
            isRefreshSuccess = true;
          },
        );

        ref.invalidate(aedappfm.CoinPriceProviders.coinPrice);
        await ref.read(aedappfm.CoinPriceProviders.coinPrice.notifier).init();
        final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);
        final swap = ref.read(SwapFormProvider.swapForm);

        final session = ref.read(SessionProviders.session);
        final balanceToSwap = await ref.read(
          BalanceProviders.getBalance(
            session.genesisAddress,
            swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address!,
          ).future,
        );
        swapNotifier.setTokenToSwapBalance(balanceToSwap);
        final balanceSwapped = await ref.read(
          BalanceProviders.getBalance(
            session.genesisAddress,
            swap.tokenSwapped!.isUCO ? 'UCO' : swap.tokenSwapped!.address!,
          ).future,
        );
        swapNotifier.setTokenSwappedBalance(balanceSwapped);

        if (swap.tokenToSwap != null && swap.tokenSwapped != null) {
          await swapNotifier.calculateSwapInfos(
            swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address!,
            swap.tokenToSwapAmount,
          );
          await swapNotifier.getRatio();
          await swapNotifier.getPool();
        }

        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          setState(
            () {
              isRefreshSuccess = false;
            },
          );
        }
      },
      child: Tooltip(
        message: AppLocalizations.of(context)!.swapIconRefreshTooltip,
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
            color: isRefreshSuccess != null && isRefreshSuccess == true
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
                isRefreshSuccess != null && isRefreshSuccess == true
                    ? Icons.check
                    : aedappfm.Iconsax.refresh,
                size: 16,
                color: isRefreshSuccess != null && isRefreshSuccess == true
                    ? Colors.white
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
