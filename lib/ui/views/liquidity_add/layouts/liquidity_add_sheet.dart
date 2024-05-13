/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_confirm_sheet.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityAddSheet extends ConsumerStatefulWidget {
  const LiquidityAddSheet({
    required this.pool,
    required this.pair,
    required this.poolsListTab,
    super.key,
  });

  final DexPool pool;
  final DexPair pair;
  final PoolsListTab poolsListTab;

  static const routerPage = '/liquidityAdd';

  @override
  ConsumerState<LiquidityAddSheet> createState() => _LiquidityAddSheetState();
}

class _LiquidityAddSheetState extends ConsumerState<LiquidityAddSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        ref.read(navigationIndexMainScreenProvider.notifier).state =
            NavigationIndex.pool;

        await ref
            .read(SessionProviders.session.notifier)
            .updateCtxInfo(context);

        ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier)
          ..setPoolsListTab(widget.poolsListTab)
          ..setToken1(widget.pair.token1)
          ..setToken2(widget.pair.token2);

        await ref
            .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
            .setPool(widget.pool);
        await ref
            .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
            .initBalances();
        await ref
            .read(LiquidityAddFormProvider.liquidityAddForm.notifier)
            .initRatio();
      } catch (e) {
        if (mounted) {
          context.go(
            Uri(
              path: PoolListSheet.routerPage,
              queryParameters: {
                'tab': widget.poolsListTab,
              },
            ).toString(),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep:
          ref.watch(LiquidityAddFormProvider.liquidityAddForm).processStep,
      formSheet: const LiquidityAddFormSheet(),
      confirmSheet: const LiquidityAddConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
