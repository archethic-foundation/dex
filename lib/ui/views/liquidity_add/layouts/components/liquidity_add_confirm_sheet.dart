/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_confirm_back_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_confirm_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddConfirmSheet extends ConsumerWidget {
  const LiquidityAddConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null) {
      return const SizedBox.shrink();
    }

    return const Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiquidityAddConfirmBackButton(),
          SizedBox(height: 15),
          Spacer(),
          LiquidityAddConfirmBtn(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
