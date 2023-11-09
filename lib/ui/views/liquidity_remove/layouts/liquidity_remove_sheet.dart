/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/state.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_form_sheet.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class LiquidityRemoveSheet extends ConsumerStatefulWidget {
  const LiquidityRemoveSheet({
    required this.poolGenesisAddress,
    required this.lpToken,
    super.key,
  });

  final String poolGenesisAddress;
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
        ..setPoolGenesisAddress(widget.poolGenesisAddress)
        ..setLpToken(widget.lpToken)
        ..initBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
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
                        if (liquidityRemove.liquidityRemoveProcessStep ==
                            LiquidityRemoveProcessStep.form)
                          const LiquidityRemoveFormSheet()
                        else
                          const LiquidityRemoveConfirmSheet(),
                        const LiquidityRemoveArchethicOracleUco(),
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
