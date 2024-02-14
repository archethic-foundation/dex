/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/welcome/components/welcome_connect_wallet_btn.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
    this.displayWalletConnect = false,
    super.key,
  });

  final bool controlOk;
  final String labelBtn;
  final Function onPressed;
  final Color background;
  final double height;
  final double fontSize;
  final bool displayWalletConnect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      if (displayWalletConnect) {
        return const WelcomeConnectWalletBtn();
      }
      return SizedBox(width: 10, height: height);
    }

    if (controlOk == false) {
      return aedappfm.AppButton(
        background: background,
        labelBtn: labelBtn,
        disabled: true,
        height: height,
        fontSize: fontSize,
      );
    }

    return aedappfm.AppButton(
      background: background,
      labelBtn: labelBtn,
      onPressed: onPressed,
      height: height,
      fontSize: fontSize,
    );
  }
}
