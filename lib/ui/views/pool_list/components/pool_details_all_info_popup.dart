import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/components/pool_details.dart';
import 'package:aedex/ui/views/util/components/popup_template.dart';
import 'package:flutter/material.dart';

class PoolDetailsAllInfoPopup {
  static Future<void> getDialog(
    BuildContext context,
    final DexPool pool,
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
            child: PoolDetails(pool: pool, allInfo: true),
          ),
          popupTitle: "Pool's information",
          popupHeight: 400,
        );
      },
    );
  }
}
