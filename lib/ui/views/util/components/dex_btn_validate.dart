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
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final bool controlOk;
  final String labelBtn;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      return const WelcomeConnectWalletBtn();
    }

    if (controlOk == false) {
      return AppButton(
        labelBtn: labelBtn,
        disabled: true,
      );
    }

    return AppButton(
      labelBtn: labelBtn,
      onPressed: onPressed,
    );
  }
}
