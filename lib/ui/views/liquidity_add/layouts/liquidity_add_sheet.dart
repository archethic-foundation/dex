/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/state.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_confirm_sheet.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_form_sheet.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class LiquidityAddSheet extends ConsumerStatefulWidget {
  const LiquidityAddSheet({
    required this.poolGenesisAddress,
    required this.pair,
    super.key,
  });

  final String poolGenesisAddress;
  final DexPair pair;
  @override
  ConsumerState<LiquidityAddSheet> createState() => _LiquidityAddSheetState();
}

class _LiquidityAddSheetState extends ConsumerState<LiquidityAddSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier)
        ..setPoolGenesisAddress(widget.poolGenesisAddress)
        ..setToken1(widget.pair.token1)
        ..setToken2(widget.pair.token2)
        ..initBalances()
        ..initRatio();
    });
  }

  @override
  Widget build(BuildContext context) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    return Align(
      child: Container(
        width: 650,
        constraints: const BoxConstraints(minHeight: 400, maxHeight: 600),
        decoration: BoxDecoration(
          gradient: DexThemeBase.gradientSheetBackground,
          border: GradientBoxBorder(
            gradient: DexThemeBase.gradientSheetBorder,
          ),
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/background-sheet.png',
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: ArchethicThemeBase.neutral900,
              blurRadius: 40,
              spreadRadius: 10,
              offset: const Offset(1, 10),
            ),
          ],
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
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        if (liquidityAdd.liquidityAddProcessStep ==
                            LiquidityAddProcessStep.form)
                          const LiquidityAddFormSheet()
                        else
                          const LiquidityAddConfirmSheet(),
                        const LiquidityAddArchethicOracleUco(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
