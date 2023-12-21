/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:flutter/material.dart';

class DexButtonConfirm extends StatelessWidget {
  const DexButtonConfirm({
    required this.labelBtn,
    required this.onPressed,
    super.key,
  });

  final String labelBtn;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      labelBtn: labelBtn,
      onPressed: onPressed,
    );
  }
}
