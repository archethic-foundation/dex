/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_confirm_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_form_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapSheet extends ConsumerStatefulWidget {
  const SwapSheet({
    this.tokenToSwap,
    this.tokenSwapped,
    super.key,
  });

  final DexToken? tokenToSwap;
  final DexToken? tokenSwapped;

  @override
  ConsumerState<SwapSheet> createState() => _SwapSheetState();
}

class _SwapSheetState extends ConsumerState<SwapSheet> {
  @override
  void initState() {
    if (widget.tokenToSwap != null && widget.tokenSwapped != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(SwapFormProvider.swapForm.notifier)
          ..setTokenToSwap(widget.tokenToSwap!)
          ..setTokenSwapped(widget.tokenSwapped!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final swap = ref.watch(SwapFormProvider.swapForm);
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
                            if (swap.swapProcessStep == SwapProcessStep.form)
                              const SwapFormSheet()
                            else
                              const SwapConfirmSheet(),
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
