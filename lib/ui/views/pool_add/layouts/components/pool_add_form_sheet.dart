import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';

import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                    child: SelectableText(
                      AppLocalizations.of(context)!.poolAddFormTitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: aedappfm.AppThemeBase.gradient,
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
                      if (poolAdd.messageMaxHalfUCO)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 40,
                            child: aedappfm.InfoBanner(
                              r'This process requires a maximum of $0.5 in transaction fees to be completed.',
                              aedappfm.InfoBannerType.request,
                            ),
                          ),
                        ),
                      DexErrorMessage(failure: poolAdd.failure),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DexButtonValidate(
                        controlOk: poolAdd.isControlsOk,
                        labelBtn: AppLocalizations.of(context)!.btn_pool_add,
                        onPressed: () => ref
                            .read(PoolAddFormProvider.poolAddForm.notifier)
                            .validateForm(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      aedappfm.ButtonClose(
                        onPressed: () {
                          ref
                              .read(navigationIndexMainScreenProvider.notifier)
                              .state = 1;
                          context.go(PoolListSheet.routerPage);
                        },
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
