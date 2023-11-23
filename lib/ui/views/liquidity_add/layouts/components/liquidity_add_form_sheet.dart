import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_close_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_error_message.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_ratio.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_1_balance.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_1_max_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_2_balance.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_2_max_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_infos.dart';
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                const LiquidityAddToken1MaxButton(),
                                const SizedBox(width: 10),
                                LiquidityAddTokenInfos(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LiquidityAddToken1Balance(),
                          SizedBox.shrink(),
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
                                const LiquidityAddToken2MaxButton(),
                                const SizedBox(width: 10),
                                LiquidityAddTokenInfos(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LiquidityAddToken2Balance(),
                          LiquidityAddRatio(),
                        ],
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LiquidityAddErrorMessage(),
                      SizedBox(
                        height: 20,
                      ),
                      LiquidityAddButton(),
                      SizedBox(
                        height: 20,
                      ),
                      LiquidityAddCloseButton(),
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
