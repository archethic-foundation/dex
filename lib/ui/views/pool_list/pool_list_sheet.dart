import 'dart:ui';

import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_back.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_front.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/grid_view.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lit_starfield/view.dart';

class PoolListSheet extends ConsumerWidget {
  const PoolListSheet({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final asyncPools = ref.watch(
      PoolListFormProvider.poolsToDisplay(
        ref.watch(PoolListFormProvider.poolListForm).tabIndexSelected,
      ),
    );

    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 140,
              bottom: 100,
            ),
            child: asyncPools.when(
              skipLoadingOnRefresh: true,
              skipLoadingOnReload: true,
              loading: () => Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: LitStarfieldContainer(
                      velocity: 0.2,
                      number: 200,
                      starColor: ArchethicThemeBase.neutral0,
                      scale: 3,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.3,
                    child: LitStarfieldContainer(
                      velocity: 0.5,
                      number: 100,
                      scale: 10,
                      starColor: ArchethicThemeBase.blue500,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loading in progress. Please wait'),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              error: (error, stackTrace) =>
                  DexErrorMessage(failure: Failure.fromError(error)),
              data: (pools) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedSize(
                    crossAxisExtent: 500,
                    mainAxisExtent: 510,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  itemCount: pools.length,
                  itemBuilder: (context, index) {
                    final pool = pools[index];
                    return PoolListItem(
                      key: Key(pool.poolAddress),
                      pool: pool,
                    );
                  },
                );
              },
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

class PoolListItem extends StatefulWidget {
  const PoolListItem({
    super.key,
    required this.pool,
  });

  final DexPool pool;

  @override
  State<PoolListItem> createState() => _PoolListItemState();
}

class _PoolListItemState extends State<PoolListItem> {
  final flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return Card(
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: FlipCard(
                  controller: flipCardController,
                  flipOnTouch: false,
                  fill: Fill.fillBack,
                  front: PoolDetailsFront(
                    pool: widget.pool,
                    toggleCard: flipCardController.toggleCard,
                  ),
                  back: PoolDetailsBack(
                    pool: widget.pool,
                    toggleCard: flipCardController.toggleCard,
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
    );
  }
}
