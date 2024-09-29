import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/layouts/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityRemoveSheet extends ConsumerStatefulWidget {
  const LiquidityRemoveSheet({
    required this.pool,
    required this.pair,
    required this.lpToken,
    required this.poolsListTab,
    super.key,
  });

  final DexPool pool;
  final DexPair pair;
  final DexToken lpToken;
  final PoolsListTab poolsListTab;

  static const routerPage = '/liquidityRemove';

  @override
  ConsumerState<LiquidityRemoveSheet> createState() =>
      _LiquidityRemoveSheetState();
}

class _LiquidityRemoveSheetState extends ConsumerState<LiquidityRemoveSheet> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      try {
        ref.read(liquidityRemoveFormNotifierProvider.notifier)
          ..setPoolsListTab(widget.poolsListTab)
          ..setToken1(widget.pair.token1)
          ..setToken2(widget.pair.token2)
          ..setLpToken(widget.lpToken);

        // ignore: cascade_invocations
        await ref
            .read(liquidityRemoveFormNotifierProvider.notifier)
            .setPool(widget.pool);
        await ref
            .read(liquidityRemoveFormNotifierProvider.notifier)
            .initBalance();
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
      currentStep: ref.watch(liquidityRemoveFormNotifierProvider).processStep,
      formSheet: const LiquidityRemoveFormSheet(),
      confirmSheet: const LiquidityRemoveConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
