/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/welcome/components/welcome_connect_wallet_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexButtonValidate extends ConsumerWidget {
  const DexButtonValidate({
    required this.controlOk,
    required this.labelBtn,
    required this.onPressed,
    this.background = const Color(0xFF3D1D63),
    this.height = 40,
    this.fontSize = 16,
    super.key,
  });

  final bool controlOk;
  final String labelBtn;
  final Function onPressed;
  final Color background;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      return const WelcomeConnectWalletBtn();
    }

    if (controlOk == false) {
      return AppButton(
        background: background,
        labelBtn: labelBtn,
        disabled: true,
        height: height,
        fontSize: fontSize,
      );
    }

    return AppButton(
      background: background,
      labelBtn: labelBtn,
      onPressed: onPressed,
      height: height,
      fontSize: fontSize,
    );
  }
}
