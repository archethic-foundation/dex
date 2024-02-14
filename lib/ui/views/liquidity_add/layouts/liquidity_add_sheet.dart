/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/state.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_confirm_sheet.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddSheet extends ConsumerStatefulWidget {
  const LiquidityAddSheet({
    required this.pool,
    required this.pair,
    super.key,
  });

  final DexPool pool;
  final DexPair pair;

  static const routerPage = '/liquidityAdd';

  @override
  ConsumerState<LiquidityAddSheet> createState() => _LiquidityAddSheetState();
}

class _LiquidityAddSheetState extends ConsumerState<LiquidityAddSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier)
        ..setPool(widget.pool)
        ..setToken1(widget.pair.token1)
        ..setToken2(widget.pair.token2)
        ..initBalances()
        ..initRatio();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
  final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
  return Align(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 650,
          decoration: BoxDecoration(
            color: aedappfm.AppThemeBase.sheetBackground,
            border: Border.all(
              color: aedappfm.AppThemeBase.sheetBorder,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 11,
              bottom: 5,
            ),
            child: LayoutBuilder(
              builder: (context, constraint) {
                return aedappfm.ArchethicScrollbar(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 100,
                      maxHeight: constraint.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          if (liquidityAdd.liquidityAddProcessStep ==
                              LiquidityAddProcessStep.form)
                            const LiquidityAddFormSheet()
                          else
                            const LiquidityAddConfirmSheet(),
                          const aedappfm.ArchethicOracleUco(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
