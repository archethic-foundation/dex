/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/token_selection/token_selection_popup.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenToSwapSelection extends ConsumerWidget {
  const SwapTokenToSwapSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    return Container(
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        color: aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async {
          final token = await TokenSelectionPopup.getDialog(
            context,
          );
          if (token == null) return;
          await ref
              .read(SwapFormProvider.swapForm.notifier)
              .setTokenToSwap(token);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Row(
                children: [
                  if (swap.tokenToSwap == null)
                    Text(
                      AppLocalizations.of(context)!.btn_selectToken,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            DexTokenIcon(
                              tokenAddress: swap.tokenToSwap!.address == null
                                  ? 'UCO'
                                  : swap.tokenToSwap!.address!,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                swap.tokenToSwap!.symbol,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context).textTheme.bodyLarge!,
                                      ),
                                    ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              aedappfm.Iconsax.search_normal,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
