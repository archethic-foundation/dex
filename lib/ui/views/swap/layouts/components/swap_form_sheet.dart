import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_icon_settings.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_swapped_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_to_swap_amount.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapFormSheet extends ConsumerWidget {
  const SwapFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SelectionArea(
                    child: Text(
                      AppLocalizations.of(context)!.swapFormTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: DexThemeBase.gradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.swap_settings_slippage_tolerance} ${swap.slippageTolerance}%',
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: SwapTokenIconSettings(),
                          ),
                        ],
                      ),
                      const SwapTokenToSwapAmount(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SwapTokenSwappedAmount(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DexErrorMessage(failure: swap.failure),
                      if (swap.poolGenesisAddress.isNotEmpty)
                        const SizedBox(
                          height: 20,
                        ),
                      PoolInfoCard(
                        poolGenesisAddress: swap.poolGenesisAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DexButtonValidate(
                        controlOk: swap.isControlsOk,
                        icon: Iconsax.arrange_circle_2,
                        labelBtn: AppLocalizations.of(context)!.btn_swap,
                        onPressed: () => ref
                            .read(SwapFormProvider.swapForm.notifier)
                            .validateForm(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
