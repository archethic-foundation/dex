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
import 'package:flutter_gen/gen_l10n/localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    final farmInfos = ref.watch(
      DexFarmProviders.getFarmInfos(
        widget.farm.farmAddress,
        widget.farm.poolAddress,
        dexFarmInput: widget.farm,
      ),
    );

    final userBalance = ref.watch(
      FarmListFormProvider.balance(widget.farm.lpToken!.address),
    );

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
                        farm: farmInfos.valueOrNull ?? widget.farm,
                        userBalance: userBalance.valueOrNull,
                        isInPopup: widget.isInPopup,
                      ),
                      back: FarmDetailsBack(
                        farm: farmInfos.valueOrNull ?? widget.farm,
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
                farm: widget.farm,
                lpTokenAddress: widget.farm.lpToken!.address,
              ),
              SizedBox(
                height: 40,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                          .withValues(alpha: 1),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  color: aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                      .withValues(alpha: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.farmCardTitle,
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
                            .withValues(alpha: 1),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    color: aedappfm
                        .ArchethicThemeBase.brightPurpleHoverBackground
                        .withValues(alpha: 1),
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
