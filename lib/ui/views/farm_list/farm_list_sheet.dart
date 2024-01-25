import 'dart:ui';

import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_back.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details_front.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmListSheet extends ConsumerWidget {
  const FarmListSheet({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ArchethicScrollbar(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 120, bottom: 100, left: 50, right: 50),
          child: FutureBuilder<List<DexFarm>>(
            future: ref.watch(
              DexFarmProviders.getFarmList.future,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: snapshot.data!
                      .map(
                        (farm) => FarmListItem(
                          key: Key(farm.farmAddress),
                          farm: farm,
                        ),
                      )
                      .toList(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class FarmListItem extends StatefulWidget {
  const FarmListItem({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  State<FarmListItem> createState() => _FarmListItemState();
}

class _FarmListItemState extends State<FarmListItem> {
  late FlipCardController flipController;

  @override
  void initState() {
    flipController = FlipCardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 500,
        height: 575,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: DexThemeBase.backgroundPopupColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          color: Colors.black.withOpacity(0.2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: FlipCard(
                      controller: flipController,
                      flipOnTouch: false,
                      fill: Fill.fillBack,
                      front: FarmDetailsFront(
                        farm: widget.farm,
                        toggleCard: flipController.toggleCard,
                      ),
                      back: FarmDetailsBack(
                        farm: widget.farm,
                        toggleCard: flipController.toggleCard,
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
}
