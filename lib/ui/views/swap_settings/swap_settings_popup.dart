import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap_settings/components/swap_settings_expert_mode.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SwapSettingsSlippageTolerance(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: DexThemeBase.gradient,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SwapSettingsExpertMode(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: DexThemeBase.gradient,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
