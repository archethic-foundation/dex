import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_list/layouts/components/farm_details_back.dart';
import 'package:aedex/ui/views/farm_list/layouts/components/farm_details_front.dart';
import 'package:aedex/ui/views/farm_list/layouts/components/farm_refresh_icon.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmListItem extends ConsumerStatefulWidget {
  const FarmListItem({
    super.key,
    required this.farm,
    this.widthCard,
    this.heightCard,
    this.isInPopup = false,
  });

  final DexFarm farm;
  final double? widthCard;
  final double? heightCard;
  final bool isInPopup;

  @override
  ConsumerState<FarmListItem> createState() => FarmListItemState();
}

class FarmListItemState extends ConsumerState<FarmListItem> {
  final flipCardController = FlipCardController();
  DexFarm? farmInfos;
  double? userBalance;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        await loadInfo();
      }
    });
    super.initState();
  }

  Future<void> loadInfo() async {
    if (!mounted) return;

    try {
      farmInfos = await ref.read(
        DexFarmProviders.getFarmInfos(
          widget.farm.farmAddress,
          widget.farm.poolAddress,
          dexFarmInput: widget.farm,
        ).future,
      );

      userBalance = await ref.read(
        FarmListFormProvider.balance(widget.farm.lpToken!.address).future,
      );

      if (mounted) {
        setState(() {});
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> reload() async {
    farmInfos = null;
    userBalance = null;
    await loadInfo();
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
              children: [
                SizedBox(
                  width: widget.widthCard,
                  height: widget.heightCard,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FlipCard(
                      controller: flipCardController,
                      flipOnTouch: false,
                      fill: Fill.fillBack,
                      front: FarmDetailsFront(
                        farm: farmInfos ?? widget.farm,
                        userBalance: userBalance,
                        isInPopup: widget.isInPopup,
                      ),
                      back: FarmDetailsBack(
                        farm: farmInfos ?? widget.farm,
                      ),
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
              FarmRefreshIcon(
                farmAddress: widget.farm.farmAddress,
                lpTokenAddress: widget.farm.lpToken!.address ?? '',
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
                    child: Text(
                      AppLocalizations.of(context)!.aeswap_farmCardTitle,
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
