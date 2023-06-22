/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class SwapSettingsCloseBtn extends StatelessWidget {
  const SwapSettingsCloseBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_close,
      icon: Iconsax.close_square,
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );
  }
}
