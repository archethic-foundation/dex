/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/token_selection/layouts/token_selection_popup.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
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
    final swap = ref.watch(swapFormNotifierProvider);

    return Container(
      width: aedappfm.Responsive.isMobile(context) ? 100 : 150,
      height: 30,
      decoration: BoxDecoration(
        color: aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async {
          final token = await TokenSelectionPopup.getDialog(
            context,
            ref.read(environmentProvider),
          );
          if (token == null) return;
          await ref
              .read(swapFormNotifierProvider.notifier)
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
                      style: AppTextStyles.bodyLarge(context),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: SizedBox(
                        width: aedappfm.Responsive.isMobile(context) ? 90 : 100,
                        child: Row(
                          children: [
                            DexTokenIcon(
                              tokenAddress: swap.tokenToSwap!.address,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                swap.tokenToSwap!.symbol,
                                style: AppTextStyles.bodyLarge(context),
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
            if (aedappfm.Responsive.isMobile(context) == false)
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
