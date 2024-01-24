import 'dart:ui';

import 'package:aedex/application/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_back.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_front.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSheet extends ConsumerWidget {
  const PoolListSheet({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final cardKey = GlobalKey<FlipCardState>();

    final poolListForm = ref.watch(PoolListFormProvider.poolListForm);
    return Stack(
      children: [
        ArchethicScrollbar(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 140,
                bottom: 100,
                left: 50,
                right: 50,
              ),
              child: FutureBuilder<List<DexPool>>(
                future: ref.watch(
                  DexPoolProviders.getPoolListFromCache(
                    poolListForm.onlyVerifiedPools,
                    poolListForm.onlyPoolsWithLiquidityPositions,
                  ).future,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: snapshot.data!.map((pool) {
                        return SizedBox(
                          width: 500,
                          height: 510,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: DexThemeBase.backgroundPopupColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                            color: Colors.black.withOpacity(0.4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: FlipCard(
                                        key: cardKey,
                                        flipOnTouch: false,
                                        fill: Fill.fillBack,
                                        front: PoolDetailsFront(
                                          pool: pool,
                                          cardKey: cardKey,
                                        ),
                                        back: PoolDetailsBack(
                                          pool: pool,
                                          cardKey: cardKey,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: DexArchethicOracleUco(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 60),
          child: PoolListSearch(),
        ),
      ],
    );
  }
}
