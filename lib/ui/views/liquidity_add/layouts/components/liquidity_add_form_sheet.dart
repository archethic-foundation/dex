import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_close.dart';
import 'package:aedex/ui/views/util/components/dex_btn_max.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/dex_ratio.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/dex_token_infos.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddFormSheet extends ConsumerWidget {
  const LiquidityAddFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

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
                      AppLocalizations.of(context)!.liquidityAddFormTitle,
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
                        poolGenesisAddress: liquidityAdd.poolGenesisAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          const LiquidityAddToken1Amount(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DexButtonMax(
                                  balanceAmount: liquidityAdd.token1Balance,
                                  onTap: () {
                                    ref
                                        .read(
                                          LiquidityAddFormProvider
                                              .liquidityAddForm.notifier,
                                        )
                                        .setToken1AmountMax();
                                  },
                                ),
                                const SizedBox(width: 10),
                                DexTokenInfos(
                                  token: liquidityAdd.token1,
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
                            tokenBalance: liquidityAdd.token1Balance,
                            tokenSymbol: liquidityAdd.token1 == null
                                ? ''
                                : liquidityAdd.token1!.symbol,
                          ),
                          const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          const LiquidityAddToken2Amount(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DexButtonMax(
                                  balanceAmount: liquidityAdd.token2Balance,
                                  onTap: () => ref
                                      .read(
                                        LiquidityAddFormProvider
                                            .liquidityAddForm.notifier,
                                      )
                                      .setToken2AmountMax(),
                                ),
                                const SizedBox(width: 10),
                                DexTokenInfos(
                                  token: liquidityAdd.token2,
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
                            tokenBalance: liquidityAdd.token2Balance,
                            tokenSymbol: liquidityAdd.token2 == null
                                ? ''
                                : liquidityAdd.token2!.symbol,
                          ),
                          DexRatio(
                            ratio: liquidityAdd.ratio,
                            token1Symbol: liquidityAdd.token1 == null
                                ? ''
                                : liquidityAdd.token1!.symbol,
                            token2Symbol: liquidityAdd.token2 == null
                                ? ''
                                : liquidityAdd.token2!.symbol,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DexErrorMessage(failure: liquidityAdd.failure),
                      const SizedBox(
                        height: 20,
                      ),
                      DexButtonValidate(
                        controlOk: liquidityAdd.isControlsOk,
                        icon: Iconsax.wallet_money,
                        labelBtn:
                            AppLocalizations.of(context)!.btn_liquidity_add,
                        onPressed: () => ref
                            .read(
                              LiquidityAddFormProvider
                                  .liquidityAddForm.notifier,
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
