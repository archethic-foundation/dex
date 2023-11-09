/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddToken2Balance extends ConsumerWidget {
  const LiquidityAddToken2Balance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    return Text(
      '${AppLocalizations.of(context)!.balance_title_infos} ${liquidityAdd.token2Balance.formatNumber()}',
      overflow: TextOverflow.visible,
      textAlign: TextAlign.end,
    );
  }
}
