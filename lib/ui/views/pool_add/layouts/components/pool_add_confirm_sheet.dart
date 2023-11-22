/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
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
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  poolAdd.token1!.symbol,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(poolAdd.token1!.name),
                                const SizedBox(height: 40),
                                Text(
                                  '+ ${poolAdd.token1Amount} ${poolAdd.token1!.symbol}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ArchethicThemeBase.neutral900
                                        .withOpacity(0.3),
                                    ArchethicThemeBase.neutral900
                                        .withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  poolAdd.token2!.symbol,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(poolAdd.token2!.name),
                                const SizedBox(height: 40),
                                Text(
                                  '+ ${poolAdd.token2Amount} ${poolAdd.token2!.symbol}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
