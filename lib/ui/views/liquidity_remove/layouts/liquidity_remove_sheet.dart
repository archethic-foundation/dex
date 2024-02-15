/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveSheet extends ConsumerStatefulWidget {
  const LiquidityRemoveSheet({
    required this.pool,
    required this.pair,
    required this.lpToken,
    super.key,
  });

  final DexPool pool;
  final DexPair pair;
  final DexToken lpToken;

  static const routerPage = '/liquidityRemove';

  @override
  ConsumerState<LiquidityRemoveSheet> createState() =>
      _LiquidityRemoveSheetState();
}

class _LiquidityRemoveSheetState extends ConsumerState<LiquidityRemoveSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(LiquidityRemoveFormProvider.liquidityRemoveForm.notifier)
        ..setPool(widget.pool)
        ..setToken1(widget.pair.token1)
        ..setToken2(widget.pair.token2)
        ..setLpToken(widget.lpToken)
        ..initBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref
          .watch(LiquidityRemoveFormProvider.liquidityRemoveForm)
          .processStep,
      formSheet: const LiquidityRemoveFormSheet(),
      confirmSheet: const LiquidityRemoveConfirmSheet(),
      bottomWidget: const aedappfm.ArchethicOracleUco(),
    );
  }
}
