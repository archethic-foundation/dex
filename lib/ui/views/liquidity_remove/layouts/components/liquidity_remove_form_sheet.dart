import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_lp_tokens_get_back.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_textfield_lp_token_amount.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_close.dart';
import 'package:aedex/ui/views/util/components/dex_btn_max.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/dex_token_infos.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
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
                                DexButtonMax(
                                  balanceAmount: liquidityRemove.lpTokenBalance,
                                  onTap: () => ref
                                      .read(
                                        LiquidityRemoveFormProvider
                                            .liquidityRemoveForm.notifier,
                                      )
                                      .setLpTokenAmountMax(),
                                ),
                                const SizedBox(width: 10),
                                DexTokenInfos(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DexTokenBalance(
                            tokenBalance: liquidityRemove.lpTokenBalance,
                            tokenSymbol: liquidityRemove.lpToken == null
                                ? ''
                                : liquidityRemove.lpToken!.symbol,
                          ),
                          const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const LiquidityRemoveTokensGetBack(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DexErrorMessage(failure: liquidityRemove.failure),
                      const SizedBox(
                        height: 20,
                      ),
                      DexButtonValidate(
                        controlOk: liquidityRemove.isControlsOk,
                        icon: Iconsax.wallet_money,
                        labelBtn:
                            AppLocalizations.of(context)!.btn_liquidity_remove,
                        onPressed: () => ref
                            .read(
                              LiquidityRemoveFormProvider
                                  .liquidityRemoveForm.notifier,
                            )
                            .validateForm(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DexButtonClose(
                        target: PoolListSheet(),
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
