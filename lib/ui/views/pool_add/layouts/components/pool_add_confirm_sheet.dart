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

    return Expanded(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: PoolAddConfirmBackButton(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(poolAdd.token1!.name),
                          const SizedBox(width: 8),
                          Text(
                            '${poolAdd.token1Amount} ${poolAdd.token1!.symbol}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(poolAdd.token2!.name),
                          const SizedBox(width: 8),
                          Text(
                            '${poolAdd.token2Amount} ${poolAdd.token2!.symbol}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Network Fees'),
                          const SizedBox(width: 8),
                          Text('${poolAdd.networkFees}'),
                        ],
                      ),
                      const SizedBox(height: 3),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PoolAddConfirmBtn(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
