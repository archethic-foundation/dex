import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap_settings/components/swap_settings_close_btn.dart';
import 'package:aedex/ui/views/swap_settings/components/swap_settings_expert_mode.dart';
import 'package:aedex/ui/views/swap_settings/components/swap_settings_slippage_tolerance.dart';
import 'package:flutter/material.dart';

class SwapSettingsPopup {
  static Future<void> getDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                  backgroundColor: DexThemeBase.backgroundPopupColor,
                  content: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SwapSettingsSlippageTolerance(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            width: 400,
                            height: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: DexThemeBase.gradient,
                              ),
                            ),
                          ),
                        ),
                        const SwapSettingsExpertMode(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            width: 400,
                            height: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: DexThemeBase.gradient,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 400,
                          height: 20,
                        ),
                        const SwapSettingsCloseBtn(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
