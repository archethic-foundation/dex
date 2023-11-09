import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_btn.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_close_btn.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_1_balance.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_1_max_btn.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_1_selection.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_2_balance.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_2_max_btn.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_2_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddFormSheet extends ConsumerWidget {
  const PoolAddFormSheet({super.key});

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
                      AppLocalizations.of(context)!.poolAddFormTitle,
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
                      PoolAddToken1Amount(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: PoolAddToken1Selection(),
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
                          PoolAddToken1Balance(),
                          SizedBox(
                            width: 5,
                          ),
                          PoolAddToken1MaxButton(),
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
                      PoolAddToken2Amount(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: PoolAddToken2Selection(),
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
                          PoolAddToken2Balance(),
                          SizedBox(
                            width: 5,
                          ),
                          PoolAddToken2MaxButton(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PoolAddButton(),
                  SizedBox(
                    height: 20,
                  ),
                  PoolAddCloseButton(),
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
