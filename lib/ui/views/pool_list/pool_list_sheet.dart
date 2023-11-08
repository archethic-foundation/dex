/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/components/pool_card.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSheet extends ConsumerWidget {
  const PoolListSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenPairs = ref.watch(DexPoolProviders.getPoolList);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!Responsive.isDesktop(context)) const SizedBox(width: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SelectionArea(
                        child: Text(
                          AppLocalizations.of(context)!.poolListTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 25,
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x003C89B9),
                              Color(0xFFCC00FF),
                            ],
                            stops: [0, 1],
                            begin: AlignmentDirectional.centerEnd,
                            end: AlignmentDirectional.centerStart,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                tokenPairs.map(
                  data: (data) {
                    return Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: data.value.length,
                          itemBuilder: (context, index) {
                            return PoolCard(pool: data.value[index]);
                          },
                        ),
                      ),
                    );
                  },
                  error: (error) => const SizedBox.shrink(),
                  loading: (loading) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton.extended(
            onPressed: () {
              ref
                  .read(
                    MainScreenWidgetDisplayedProviders
                        .mainScreenWidgetDisplayedProvider.notifier,
                  )
                  .setWidget(const PoolAddSheet(), ref);
            },
            icon: const Icon(Icons.add),
            label: Text(
              AppLocalizations.of(context)!.addPool,
            ),
          ),
        ),
      ],
    );
  }
}
