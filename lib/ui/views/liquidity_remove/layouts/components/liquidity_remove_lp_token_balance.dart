/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveLPTokenBalance extends ConsumerWidget {
  const LiquidityRemoveLPTokenBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    return Text(
      '${AppLocalizations.of(context)!.balance_title_infos} ${liquidityRemove.lpTokenBalance.formatNumber()}',
      overflow: TextOverflow.visible,
      textAlign: TextAlign.end,
    );
  }
}
