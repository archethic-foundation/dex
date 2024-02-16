import 'package:aedex/application/session/provider.dart';
import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/welcome/welcome_screen.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Splash
/// Default page route that determines if user is logged in
/// and routes them appropriately.
class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  static const routerPage = '/';

  @override
  ConsumerState<Splash> createState() => SplashState();
}

class SplashState extends ConsumerState<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await HivePreferencesDatasource.getInstance().then((value) {
        if (value.isFirstConnection()) {
          if (context.mounted) context.go(WelcomeScreen.routerPage);
        }
      });

      await ref.read(SessionProviders.session.notifier).connectToWallet(
            forceConnection: false,
          );

      var session = ref.read(SessionProviders.session);
      if (session.isConnected == false) {
        ref
            .read(SessionProviders.session.notifier)
            .connectEndpoint(session.envSelected);
      }

      session = ref.read(SessionProviders.session);
      if (session.endpoint.isNotEmpty) {
        if (context.mounted) {
          ref
              .read(
                navigationIndexMainScreenProvider.notifier,
              )
              .state = 0;
          context.go(SwapSheet.routerPage, extra: <String, dynamic>{});
        }
      } else {
        ref.invalidate(SessionProviders.session);
        if (context.mounted) context.go(WelcomeScreen.routerPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: aedappfm.AppBackground(
        backgroundImage: 'assets/images/background-welcome.png',
      ),
    );
  }
}
