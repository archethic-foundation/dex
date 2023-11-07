/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_confirm_back_btn.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_confirm_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddConfirmSheet extends ConsumerWidget {
  const PoolAddConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
    if (poolAdd.token1 == null) {
      return const SizedBox.shrink();
    }

    return const Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PoolAddConfirmBackButton(),
          SizedBox(height: 15),
          Spacer(),
          PoolAddConfirmBtn(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
