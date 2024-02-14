import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_infos.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_swapped_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_to_swap_amount.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SwapFormSheet extends ConsumerWidget {
  const SwapFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwapTokenToSwapAmount(),
                      SwapTokenSwappedAmount(),
                      SwapInfos(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (swap.messageMaxHalfUCO)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 40,
                            child: InfoBanner(
                              r'The swap process requires a maximum of $0.5 in transaction fees to be completed.',
                              InfoBannerType.request,
                            ),
                          ),
                        ),
                      DexErrorMessage(failure: swap.failure),
                      if (swap.failure is PoolNotExists &&
                          swap.tokenToSwap != null &&
                          swap.tokenSwapped != null &&
                          swap.tokenToSwap!.address !=
                              swap.tokenSwapped!.address)
                        TextButton.icon(
                          label: const Text('Create this pool'),
                          onPressed: () {
                            ref
                                .read(
                                  navigationIndexMainScreenProvider.notifier,
                                )
                                .state = 1;
                            context.go(
                              PoolAddSheet.routerPage,
                              extra: {
                                'token1': swap.tokenToSwap,
                                'token2': swap.tokenSwapped,
                              },
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      DexButtonValidate(
                        controlOk: swap.isControlsOk,
                        labelBtn: AppLocalizations.of(context)!.btn_swap,
                        onPressed: () => ref
                            .read(SwapFormProvider.swapForm.notifier)
                            .validateForm(context),
                        displayWalletConnect: true,
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
