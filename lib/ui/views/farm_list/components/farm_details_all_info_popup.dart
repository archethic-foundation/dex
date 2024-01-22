import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details.dart';
import 'package:aedex/ui/views/util/components/popup_template.dart';
import 'package:flutter/material.dart';

class FarmDetailsAllInfoPopup {
  static Future<void> getDialog(
    BuildContext context,
    final DexFarm farm,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return PopupTemplate(
          popupContent: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: FarmDetails(farm: farm, allInfo: true),
          ),
          popupTitle: "Farm's information",
          popupHeight: 600,
        );
      },
    );
  }
}
