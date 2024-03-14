import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_back.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_front.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmListSheet extends ConsumerStatefulWidget {
  const FarmListSheet({
    super.key,
  });

  static const routerPage = '/farmList';
  @override
  ConsumerState<FarmListSheet> createState() => _FarmListSheetState();
}

class _FarmListSheetState extends ConsumerState<FarmListSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.farm;
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
  final asyncFarms = ref.watch(
    DexFarmProviders.getFarmList,
  );

  return Center(
    child: Padding(
      padding: EdgeInsets.only(
        top: 100,
        bottom: aedappfm.Responsive.isDesktop(context) ? 40 : 80,
      ),
      child: asyncFarms.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        error: (error, stacktrace) => const aedappfm.Loading(),
        loading: aedappfm.Loading.new,
        data: (farms) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width >= 1500
                ? 3
                : aedappfm.Responsive.isDesktop(context)
                    ? 2
                    : 1,
            mainAxisExtent: 640,
            crossAxisSpacing: 30,
            mainAxisSpacing: 10,
          ),
          padding: EdgeInsets.only(
            left: aedappfm.Responsive.isDesktop(context) ? 50 : 5,
            right: aedappfm.Responsive.isDesktop(context) ? 50 : 5,
          ),
          itemCount: farms.length,
          itemBuilder: (context, index) {
            final farm = farms[index];
            return FarmListItem(
              key: Key(farm.farmAddress),
              farm: farm,
            );
          },
        ),
      ),
    ),
  );
}

class FarmListItem extends ConsumerStatefulWidget {
  const FarmListItem({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  ConsumerState<FarmListItem> createState() => _FarmListItemState();
}

class _FarmListItemState extends ConsumerState<FarmListItem> {
  final flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: aedappfm.SingleCard(
            globalPadding: 0,
            cardContent: FutureBuilder<DexFarm?>(
              future: ref.watch(
                DexFarmProviders.getFarmInfos(
                  widget.farm.farmAddress,
                  widget.farm.poolAddress,
                  dexFarmInput: widget.farm,
                ).future,
              ),
              builder: (context, farmInfosSnapshot) {
                if (farmInfosSnapshot.hasData) {
                  final farmInfos = farmInfosSnapshot.data;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: FlipCard(
                          controller: flipCardController,
                          flipOnTouch: false,
                          fill: Fill.fillBack,
                          front: FarmDetailsFront(
                            farm: farmInfos!,
                          ),
                          back: FarmDetailsBack(
                            farm: farmInfos,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: DexArchethicOracleUco(),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: FlipCard(
                        controller: flipCardController,
                        flipOnTouch: false,
                        fill: Fill.fillBack,
                        front: FarmDetailsFront(
                          farm: widget.farm,
                        ),
                        back: FarmDetailsBack(
                          farm: widget.farm,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: DexArchethicOracleUco(),
                    ),
                  ],
                );
              },
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
                      'Farming',
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
