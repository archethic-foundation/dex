import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_btn.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_close_btn.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_error_message.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_lp_token_balance.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_lp_token_max_btn.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_lp_tokens_get_back.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_textfield_lp_token_amount.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_token_infos.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveFormSheet extends ConsumerWidget {
  const LiquidityRemoveFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

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
                      AppLocalizations.of(context)!.liquidityRemoveFormTitle,
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
                      PoolInfoCard(
                        poolGenesisAddress: liquidityRemove.poolGenesisAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          const LiquidityRemoveLPTokenAmount(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const LiquidityRemoveLPTokenMaxButton(),
                                const SizedBox(width: 10),
                                LiquidityRemoveTokenInfos(
                                  token: liquidityRemove.lpToken,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LiquidityRemoveLPTokenBalance(),
                          SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const LiquidityRemoveTokensGetBack(),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LiquidityRemoveErrorMessage(),
                      SizedBox(
                        height: 20,
                      ),
                      LiquidityRemoveButton(),
                      SizedBox(
                        height: 20,
                      ),
                      LiquidityRemoveCloseButton(),
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
