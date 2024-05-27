import 'package:aedex/application/balance.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_add_favorite_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_back.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details_front.dart';
import 'package:aedex/ui/views/pool_list/components/pool_refresh_icon.dart';
import 'package:aedex/ui/views/pool_list/components/pool_remove_favorite_icon.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/pool_tx_list/pool_tx_list_popup.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolListItem extends ConsumerStatefulWidget {
  const PoolListItem({
    super.key,
    required this.pool,
    required this.tab,
  });

  final DexPool pool;
  final PoolsListTab tab;

  @override
  ConsumerState<PoolListItem> createState() => PoolListItemState();
}

class PoolListItemState extends ConsumerState<PoolListItem> {
  final flipCardController = FlipCardController();
  DexPool? poolInfos;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        await loadInfo();
      }
    });
    super.initState();
  }

  Future<void> loadInfo({bool forceLoadFromBC = false}) async {
    poolInfos = await ref.read(
      DexPoolProviders.loadPoolCard(
        widget.pool,
        forceLoadFromBC: forceLoadFromBC,
      ).future,
    );
    if (mounted) {
      final session = ref.watch(SessionProviders.session);
      ref.invalidate(
        BalanceProviders.getBalance(
          session.genesisAddress,
          widget.pool.lpToken.address!,
        ),
      );
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> reload() async {
    poolInfos = null;
    if (mounted) {
      setState(() {});
    }
    if (mounted) {
      await loadInfo(
        forceLoadFromBC: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: FlipCard(
                    controller: flipCardController,
                    flipOnTouch: false,
                    fill: Fill.fillBack,
                    front: PoolDetailsFront(
                      pool: poolInfos ?? widget.pool,
                      tab: widget.tab,
                    ),
                    back: PoolDetailsBack(
                      pool: poolInfos ?? widget.pool,
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
          top: -3,
          right: 20,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: PoolRefreshIcon(
                  poolAddress: widget.pool.poolAddress,
                ),
              ),
              if (poolInfos != null && poolInfos!.isFavorite)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: PoolRemoveFavoriteIcon(
                    poolAddress: widget.pool.poolAddress,
                    onRemoved: () async {
                      context.go(
                        Uri(
                          path: PoolListSheet.routerPage,
                          queryParameters: {
                            'tab': Uri.encodeComponent(
                              PoolsListTab.favoritePools.name,
                            ),
                          },
                        ).toString(),
                      );
                      await ref
                          .read(PoolListFormProvider.poolListForm.notifier)
                          .getPoolsList(
                            tabIndexSelected: PoolsListTab.favoritePools,
                            cancelToken: UniqueKey().toString(),
                          );
                    },
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: PoolAddFavoriteIcon(
                    poolAddress: widget.pool.poolAddress,
                  ),
                ),
              InkWell(
                onTap: () async {
                  await PoolTxListPopup.getDialog(
                    context,
                    poolInfos!,
                  );
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
                        aedappfm.Iconsax.receipt_item,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
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
                      top: 9,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.poolCardTitle,
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
