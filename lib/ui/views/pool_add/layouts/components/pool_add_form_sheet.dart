import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_close.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddFormSheet extends ConsumerWidget {
  const PoolAddFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PoolAddToken1Amount(),
                      const SizedBox(
                        height: 10,
                      ),
                      const PoolAddToken2Amount(),
                      const SizedBox(
                        height: 10,
                      ),
                      DexErrorMessage(failure: poolAdd.failure),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DexButtonValidate(
                        controlOk: poolAdd.isControlsOk,
                        icon: Iconsax.wallet_money,
                        labelBtn: AppLocalizations.of(context)!.btn_pool_add,
                        onPressed: () => ref
                            .read(PoolAddFormProvider.poolAddForm.notifier)
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
