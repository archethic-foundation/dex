import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider_item.dart';
import 'package:aedex/ui/views/pool_list/components/pool_add_favorite_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_back.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_front.dart';
import 'package:aedex/ui/views/pool_list/components/pool_refresh_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_remove_favorite_icon.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListItem extends ConsumerStatefulWidget {
  const PoolListItem({
    super.key,
    required this.poolAddress,
  });

  final String poolAddress;

  @override
  ConsumerState<PoolListItem> createState() => _PoolListItemState();
}

class _PoolListItemState extends ConsumerState<PoolListItem> {
  final flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    final asyncPoolDetail =
        ref.watch(DexPoolProviders.getPool(widget.poolAddress));

    return asyncPoolDetail.when(
      data: (poolDetail) {
        if (poolDetail == null) {
          return const SizedBox.shrink();
        }

        Future.delayed(Duration.zero, () {
          ref
              .read(PoolItemProvider.poolItem(poolDetail.poolAddress).notifier)
              .setPool(poolDetail);
        });

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: aedappfm.SingleCard(
                globalPadding: 0,
                cardContent: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: FlipCard(
                        controller: flipCardController,
                        flipOnTouch: false,
                        fill: Fill.fillBack,
                        front: PoolDetailsFront(
                          pool: poolDetail,
                          poolAddress: poolDetail.poolAddress,
                        ),
                        back: PoolDetailsBack(
                          pool: poolDetail,
                          poolAddress: poolDetail.poolAddress,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: PoolRefreshIcon(
                      poolAddress: poolDetail.poolAddress,
                    ),
                  ),
                  if (poolDetail.isFavorite)
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: PoolRemoveFavoriteIcon(
                        poolAddress: poolDetail.poolAddress,
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: PoolAddFavoriteIcon(
                        poolAddress: poolDetail.poolAddress,
                      ),
                    ),
                  SizedBox(
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
      },
      loading: () {
        return const SizedBox.shrink();
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
