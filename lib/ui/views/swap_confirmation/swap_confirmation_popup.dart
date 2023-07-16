/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/theme_base.dart';
import 'package:aedex/ui/views/swap_confirmation/components/swap_confirmation_infos.dart';
import 'package:aedex/ui/views/swap_confirmation/components/swap_confirmation_swap_btn.dart';
import 'package:flutter/material.dart';

class SwapConfirmationPopup {
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
                  backgroundColor: ThemeBase.backgroundPopupColor,
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
                        SizedBox(
                          width: 400,
                          height: 20,
                        ),
                        SwapConfirmationInfos(),
                        SwapConfirmationSwapBtn(),
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
