/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_settings_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddTokenIconSettings extends ConsumerWidget {
  const LiquidityAddTokenIconSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        LiquidityAddSettingsPopup.getDialog(
          context,
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 5, bottom: 4),
        child: Icon(aedappfm.Iconsax.setting_2, size: 14),
      ),
    );
  }
}
