/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_confirm_infos.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_in_progress_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
        mainAxisSize: MainAxisSize.min,
        children: [
          aedappfm.ButtonConfirmBack(
            title: AppLocalizations.of(context)!.poolAddConfirmTitle,
            onPressed: poolAdd.token1 == null
                ? null
                : () {
                    ref.read(PoolAddFormProvider.poolAddForm.notifier)
                      ..setPoolAddProcessStep(
                        PoolAddProcessStep.form,
                      )
                      ..setMessageMaxHalfUCO(false);
                  },
          ),
          const SizedBox(height: 15),
          const PoolAddConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          aedappfm.ButtonConfirm(
            labelBtn: AppLocalizations.of(context)!.btn_confirm_pool_add,
            onPressed: () async {
              final poolAddNotifier =
                  ref.read(PoolAddFormProvider.poolAddForm.notifier);
              unawaited(poolAddNotifier.add(context, ref));
              await PoolAddInProgressPopup.getDialog(
                context,
                ref,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
