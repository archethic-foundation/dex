/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_back_btn.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_confirm_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveConfirmSheet extends ConsumerWidget {
  const LiquidityRemoveConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.lpToken == null) {
      return const SizedBox.shrink();
    }

    return const Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiquidityRemoveConfirmBackButton(),
          SizedBox(height: 15),
          Spacer(),
          LiquidityRemoveConfirmBtn(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
