import 'package:aedex/ui/views/swap_settings/components/swap_settings_slippage_tolerance.dart';
import 'package:aedex/ui/views/util/components/popup_template.dart';
import 'package:flutter/material.dart';

class SwapSettingsPopup {
  static Future<void> getDialog(
    BuildContext context,
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SwapSettingsSlippageTolerance(),
              ],
            ),
          ),
          popupTitle: '',
          popupHeight: 200,
        );
      },
    );
  }
}
