/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddToken2Balance extends ConsumerWidget {
  const PoolAddToken2Balance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    return Text(
      '${AppLocalizations.of(context)!.balance_title_infos} ${poolAdd.token2Balance.toString().replaceAll(RegExp(r"0*$"), "").replaceAll(RegExp(r"\.$"), "")}',
    );
  }
}
