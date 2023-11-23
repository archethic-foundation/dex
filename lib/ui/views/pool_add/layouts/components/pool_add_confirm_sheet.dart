/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_in_progress_popup.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm.dart';
import 'package:aedex/ui/views/util/components/dex_btn_confirm_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmSheet extends ConsumerWidget {
  const PoolAddConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
    if (poolAdd.token1 == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: DexButtonConfirmBack(
              title: AppLocalizations.of(context)!.poolAddConfirmTitle,
              onPressed: poolAdd.token1 == null
                  ? null
                  : () {
                      ref
                          .read(PoolAddFormProvider.poolAddForm.notifier)
                          .setPoolAddProcessStep(
                            PoolAddProcessStep.form,
                          );
                    },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  poolAdd.token1!.symbol,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(poolAdd.token1!.name),
                                const SizedBox(height: 40),
                                Text(
                                  '+ ${poolAdd.token1Amount} ${poolAdd.token1!.symbol}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ArchethicThemeBase.neutral900
                                        .withOpacity(0.3),
                                    ArchethicThemeBase.neutral900
                                        .withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  poolAdd.token2!.symbol,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(poolAdd.token2!.name),
                                const SizedBox(height: 40),
                                Text(
                                  '+ ${poolAdd.token2Amount} ${poolAdd.token2!.symbol}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DexButtonConfirm(
                        labelBtn:
                            AppLocalizations.of(context)!.btn_confirm_pool_add,
                        onPressed: () async {
                          final poolAddNotifier = ref
                              .read(PoolAddFormProvider.poolAddForm.notifier);
                          unawaited(poolAddNotifier.add(context, ref));
                          await PoolAddInProgressPopup.getDialog(
                            context,
                            ref,
                          );
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
