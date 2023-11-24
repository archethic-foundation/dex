/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap_settings/swap_settings_popup.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenIconSettings extends ConsumerWidget {
  const SwapTokenIconSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        SwapSettingsPopup.getDialog(
          context,
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 5, bottom: 4),
        child: Icon(Iconsax.setting_2, size: 14),
      ),
    );
  }
}
