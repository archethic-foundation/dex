/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapConfirmationInfos extends ConsumerWidget {
  const SwapConfirmationInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.swap_confirmation_you_pay,
        ),
        Text(
          '${swap.tokenToSwapAmount} ${swap.tokenToSwap!.symbol}',
          style: textTheme.titleLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.swap_confirmation_you_receive,
        ),
        Text(
          '${swap.tokenSwappedAmount} ${swap.tokenSwapped!.symbol}',
          style: textTheme.titleLarge,
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.swap_confirmation_exchange_rate,
            ),
            Text(
              '1 ${swap.tokenToSwap!.symbol} = ???? ${swap.tokenSwapped!.symbol}',
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.swap_confirmation_network_fee,
            ),
            Text(
              swap.networkFees.toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.swap_confirmation_swap_fee,
            ),
            Text(
              swap.swapFees.toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.swap_confirmation_minimum_received,
            ),
            Text(
              swap.minimumReceived.toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.swap_confirmation_price_impact,
            ),
            Text(
              '${swap.priceImpact}%',
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!
                  .swap_confirmation_estimated_received,
            ),
            Text(
              swap.estimatedReceived.toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
