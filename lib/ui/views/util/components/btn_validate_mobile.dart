/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/mobile_info/layouts/mobile_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonValidateMobile extends ConsumerWidget {
  const ButtonValidateMobile({
    super.key,
    required this.controlOk,
    required this.labelBtn,
    required this.onPressed,
    required this.isConnected,
    required this.displayWalletConnectOnPressed,
    this.backgroundGradient,
    this.height = 40,
    this.fontSize = 16,
    this.displayWalletConnect = false,
    this.dimens = aedappfm.Dimens.buttonDimens,
  });

  final bool controlOk;
  final String labelBtn;
  final Function onPressed;
  final Gradient? backgroundGradient;
  final double height;
  final double fontSize;
  final bool displayWalletConnect;
  final bool isConnected;
  final VoidCallback displayWalletConnectOnPressed;
  final List<double> dimens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    VoidCallback _displayWalletConnectOnPressed;
    if (ref.read(SessionProviders.session).isConnected == false &&
        context.mounted &&
        aedappfm.Responsive.isMobile(context)) {
      _displayWalletConnectOnPressed = () {
        showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: Colors.transparent.withAlpha(120),
              body: const Align(
                child: MobileInfoScreen(),
              ),
            );
          },
        );
      };
    } else {
      _displayWalletConnectOnPressed = displayWalletConnectOnPressed;
    }

    return aedappfm.ButtonValidate(
      controlOk: controlOk,
      labelBtn: labelBtn,
      onPressed: onPressed,
      isConnected: isConnected,
      displayWalletConnectOnPressed: _displayWalletConnectOnPressed,
      backgroundGradient: backgroundGradient,
      height: height,
      fontSize: fontSize,
      displayWalletConnect: displayWalletConnect,
      dimens: dimens,
      key: key,
    );
  }
}
