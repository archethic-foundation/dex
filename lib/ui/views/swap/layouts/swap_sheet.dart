/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_confirm_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_form_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SwapSheet extends ConsumerStatefulWidget {
  const SwapSheet({
    this.tokenToSwap,
    this.tokenSwapped,
    super.key,
  });

  final DexToken? tokenToSwap;
  final DexToken? tokenSwapped;

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

      await ref.read(SessionProviders.session.notifier).updateCtxInfo(context);

      try {
        if (widget.tokenToSwap != null && widget.tokenSwapped != null) {
          await ref
              .read(SwapFormProvider.swapForm.notifier)
              .setTokenToSwap(widget.tokenToSwap!);
          await ref
              .read(SwapFormProvider.swapForm.notifier)
              .setTokenSwapped(widget.tokenSwapped!);
        }
      } catch (e) {
        if (mounted) {
          context.go(SwapSheet.routerPage);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(SwapFormProvider.swapForm).processStep,
      formSheet: const SwapFormSheet(),
      confirmSheet: const SwapConfirmSheet(),
      bottomWidget: const DexArchethicOracleUco(),
    );
  }
}
