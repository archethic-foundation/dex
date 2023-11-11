import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_btn.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_close_btn.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_error_message.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_2_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddFormSheet extends ConsumerWidget {
  const PoolAddFormSheet({
    super.key,
  });

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
                  padding: const EdgeInsets.only(right: 15),
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
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PoolAddToken1Amount(),
                      SizedBox(
                        height: 10,
                      ),
                      PoolAddToken2Amount(),
                      SizedBox(
                        height: 10,
                      ),
                      PoolAddErrorMessage(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
