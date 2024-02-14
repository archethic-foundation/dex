/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeConnectWalletBtn extends ConsumerStatefulWidget {
  const WelcomeConnectWalletBtn({
    super.key,
  });
  @override
  WelcomeConnectWalletBtnState createState() => WelcomeConnectWalletBtnState();
}

class WelcomeConnectWalletBtnState
    extends ConsumerState<WelcomeConnectWalletBtn> {
  @override
  Widget build(BuildContext context) {
    return aedappfm.AppButton(
      labelBtn: AppLocalizations.of(context)!.connectionWalletConnect,
      onPressed: () async {
        final sessionNotifier = ref.read(SessionProviders.session.notifier);
        await sessionNotifier.connectToWallet();

        final session = ref.read(SessionProviders.session);
        if (session.error.isNotEmpty) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: SelectableText(
                session.error,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          if (!context.mounted) return;
          context.go(
            '/',
          );
        }
      },
    );
  }
}
