/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
    return aedappfm.AppButton(
      background: background,
      labelBtn: labelBtn,
      onPressed: onPressed,
    );
  }
}
