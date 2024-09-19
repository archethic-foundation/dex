import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_confirm_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_form_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapSheet extends ConsumerStatefulWidget {
  const SwapSheet({
    this.tokenToSwap,
    this.tokenSwapped,
    this.from,
    this.to,
    this.value,
    super.key,
  });

  final DexToken? tokenToSwap;
  final DexToken? tokenSwapped;
  final String? from;
  final String? to;
  final double? value;

  static const routerPage = '/swap';

  @override
  ConsumerState<SwapSheet> createState() => _SwapSheetState();
}

class _SwapSheetState extends ConsumerState<SwapSheet> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.swap;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(swapFormNotifierProvider).processStep,
      formSheet: SwapFormSheet(
        tokenToSwap: widget.tokenToSwap,
        tokenSwapped: widget.tokenSwapped,
        from: widget.from,
        to: widget.to,
        value: widget.value,
      ),
      confirmSheet: const SwapConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
