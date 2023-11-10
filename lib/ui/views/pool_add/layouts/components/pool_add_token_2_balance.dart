/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddToken2Balance extends ConsumerWidget {
  const PoolAddToken2Balance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    if (poolAdd.token2 == null) {
      return const SizedBox(
        height: 30,
      );
    }
    return SizedBox(
      height: 30,
      child: Text(
        '${AppLocalizations.of(context)!.balance_title_infos} ${poolAdd.token2Balance.formatNumber()} ${poolAdd.token2!.symbol}',
      )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 500),
          )
          .scale(
            duration: const Duration(milliseconds: 500),
          ),
    );
  }
}
