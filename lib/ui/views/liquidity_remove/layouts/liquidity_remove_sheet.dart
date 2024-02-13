/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/state.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_form_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
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
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    return Align(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 650,
            decoration: BoxDecoration(
              color: DexThemeBase.sheetBackground,
              border: Border.all(
                color: DexThemeBase.sheetBorder,
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
                  return ArchethicScrollbar(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 100,
                        maxHeight: constraint.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            if (liquidityRemove.liquidityRemoveProcessStep ==
                                LiquidityRemoveProcessStep.form)
                              const LiquidityRemoveFormSheet()
                            else
                              const LiquidityRemoveConfirmSheet(),
                            const DexArchethicOracleUco(),
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
}
