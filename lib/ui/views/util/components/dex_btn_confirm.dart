/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:flutter/material.dart';

class DexButtonConfirm extends StatelessWidget {
  const DexButtonConfirm({
    required this.labelBtn,
    required this.onPressed,
    this.background = const Color(0xFF3D1D63),
    super.key,
  });

  final String labelBtn;
  final Function onPressed;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      background: background,
      labelBtn: labelBtn,
      onPressed: onPressed,
    );
  }
}
