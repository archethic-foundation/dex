import 'package:aedex/ui/views/swap_settings/components/swap_settings_slippage_tolerance.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/popup_template.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SwapSettingsSlippageTolerance(),
                DexButtonValidate(
                  controlOk: true,
                  icon: Iconsax.setting_3,
                  labelBtn: AppLocalizations.of(context)!.btn_save,
                  onPressed: () {
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          popupTitle: AppLocalizations.of(context)!.settingsTitle,
          popupHeight: 200,
        );
      },
    );
  }
}
