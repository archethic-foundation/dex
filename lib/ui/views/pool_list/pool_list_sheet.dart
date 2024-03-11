import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_add_add_favorite_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_add_remove_favorite_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_back.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_front.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSheet extends ConsumerStatefulWidget {
  const PoolListSheet({
    super.key,
  });

  static const routerPage = '/poolList';

  @override
  ConsumerState<PoolListSheet> createState() => _PoolListSheetState();
}

class _PoolListSheetState extends ConsumerState<PoolListSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.pool;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenList(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
  final selectedTab =
      ref.watch(PoolListFormProvider.poolListForm).tabIndexSelected;
  final asyncPools = ref.watch(
    PoolListFormProvider.poolsToDisplay(selectedTab),
  );
  final poolListForm = ref.watch(PoolListFormProvider.poolListForm);
  final session = ref.watch(SessionProviders.session);
  return Stack(
    children: [
      Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 140,
            bottom: aedappfm.Responsive.isDesktop(context) ? 40 : 80,
          ),
          child: asyncPools.when(
            skipLoadingOnReload: selectedTab.skipLoadingOnReload,
            loading: () => Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (selectedTab == PoolsListTab.searchPool)
                      SelectableText(
                        'Searching in progress. Please wait',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    else
                      SelectableText(
                        'Loading in progress. Please wait',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
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
            error: (error, stackTrace) => aedappfm.ErrorMessage(
              failure: aedappfm.Failure.fromError(error),
              failureMessage: FailureMessage(
                context: context,
                failure: aedappfm.Failure.fromError(error),
              ).getMessage(),
            ),
            data: (pools) {
              if (session.isConnected == false &&
                  poolListForm.tabIndexSelected == PoolsListTab.myPools) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      'Please, connect your wallet to list your pools with position.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                );
              }
              if (pools.isEmpty &&
                  poolListForm.tabIndexSelected == PoolsListTab.searchPool) {
                if (poolListForm.searchText.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        'Please enter your search criteria.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        'No results found.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  );
                }
              }
              if (pools.isEmpty &&
                  poolListForm.tabIndexSelected == PoolsListTab.favoritePools) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      'To add your favorite pools to this tab, please click on the',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 2, right: 5),
                      child: Icon(
                        aedappfm.Iconsax.star,
                        size: 14,
                      ),
                    ),
                    SelectableText(
                      'icon in the pool cards header.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                );
              }
              return GridView.builder(
                gridDelegate: const aedappfm.SliverGridDelegateWithFixedSize(
                  crossAxisExtent: 500,
                  mainAxisExtent: 550,
                  crossAxisSpacing: 30,
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
        padding: EdgeInsets.only(
          top: 60,
        ),
        child: PoolListSearch(),
      ),
    ],
  );
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: aedappfm.SingleCard(
            globalPadding: 0,
            cardContent: Column(
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
        Positioned(
          top: 5,
          right: 20,
          child: Row(
            children: [
              if (widget.pool.isFavorite)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: PoolAddRemoveFavoriteIcon(
                    poolAddress: widget.pool.poolAddress,
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: PoolAddAddFavoriteIcon(
                    poolAddress: widget.pool.poolAddress,
                  ),
                ),
              SizedBox(
                height: 40,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                          .withOpacity(1),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  color: aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                      .withOpacity(1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: SelectableText(
                      'Pool',
                      style: Theme.of(context).textTheme.bodyMedium,
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
                        color: aedappfm
                            .ArchethicThemeBase.brightPurpleHoverBorder
                            .withOpacity(1),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    color: aedappfm
                        .ArchethicThemeBase.brightPurpleHoverBackground
                        .withOpacity(1),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: Icon(
                        aedappfm.Iconsax.convertshape,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
