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
                  content: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SwapSettingsSlippageTolerance(),
                        Divider(),
                        SwapSettingsExpertMode(),
                        Divider(),
                        SizedBox(
                          width: 400,
                          height: 20,
                        ),
                        SwapSettingsCloseBtn(),
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
