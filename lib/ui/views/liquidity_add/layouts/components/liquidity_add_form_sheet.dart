import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_1_balance.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_1_max_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_1_selection.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_2_balance.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_2_max_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_token_2_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddFormSheet extends ConsumerWidget {
  const LiquidityAddFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  padding: const EdgeInsets.only(left: 15, right: 15),
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
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 50, right: 50),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      LiquidityAddToken1Amount(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: LiquidityAddToken1Selection(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LiquidityAddToken1Balance(),
                          SizedBox(
                            width: 5,
                          ),
                          LiquidityAddToken1MaxButton(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      LiquidityAddToken2Amount(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: LiquidityAddToken2Selection(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LiquidityAddToken2Balance(),
                          SizedBox(
                            width: 5,
                          ),
                          LiquidityAddToken2MaxButton(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LiquidityAddButton(),
                  SizedBox(
                    height: 20,
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
