import 'dart:ui';

import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_add_add_cache_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_add_remove_cache_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_back.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_front.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/grid_view.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
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
            padding: EdgeInsets.only(
              top: 140,
              bottom: Responsive.isDesktop(context) ? 0 : 80,
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
                      SelectableText('Loading in progress. Please wait'),
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
                    mainAxisExtent: 550,
                    crossAxisSpacing: 20,
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

class PoolListItem extends ConsumerStatefulWidget {
  const PoolListItem({
    super.key,
    required this.pool,
  });

  final DexPool pool;

  @override
  ConsumerState<PoolListItem> createState() => _PoolListItemState();
}

class _PoolListItemState extends ConsumerState<PoolListItem> {
  final flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    final poolListForm = ref.watch(PoolListFormProvider.poolListForm);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
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
                        ),
                        back: PoolDetailsBack(
                          pool: widget.pool,
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
        ),
        Positioned(
          top: 5,
          right: 20,
          child: Row(
            children: [
              SizedBox(
                height: 40,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: DexThemeBase.backgroundPopupColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  color: ArchethicThemeBase.purple500,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: SelectableText(
                      'Pool',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ArchethicThemeBase.raspberry300,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () async {
                  await flipCardController.toggleCard();
                  setState(() {});
                },
                child: SizedBox(
                  height: 40,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: DexThemeBase.backgroundPopupColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    color: DexThemeBase.backgroundPopupColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: Icon(
                        flipCardController.state != null &&
                                flipCardController.state!.isFront == true
                            ? Icons.home
                            : Icons.info_outline,
                        size: 16,
                        color: ArchethicThemeBase.raspberry300,
                      ),
                    ),
                  ),
                ),
              ),
              if (poolListForm.tabIndexSelected == PoolsListTab.searchPool)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: PoolAddAddCacheIcon(
                    poolAddress: widget.pool.poolAddress,
                  ),
                ),
              if (widget.pool.isFavorite)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: PoolAddRemoveCacheIcon(
                    poolAddress: widget.pool.poolAddress,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
