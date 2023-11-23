/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';

class DexButtonConfirm extends StatelessWidget {
  const DexButtonConfirm({
    required this.labelBtn,
    required this.onPressed,
    this.icon = Iconsax.tick_square,
    super.key,
  });

  final String labelBtn;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      labelBtn: labelBtn,
      icon: icon,
      onPressed: onPressed,
    );
  }
}
