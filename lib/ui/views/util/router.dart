import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoutesPath {
  factory RoutesPath() {
    return _singleton;
  }

  RoutesPath._internal();
  static final RoutesPath _singleton = RoutesPath._internal();

  final String genesisAddressParameter = 'genesisAddress';

  String home() {
    return '/';
  }

  String main() {
    return '/aedex/websites';
  }

  String welcome() {
    return '/welcome';
  }

  String swap() {
    return '${main()}/swap';
  }

  String _swap() {
    return 'swap';
  }

  String poolList() {
    return '${main()}/poolList';
  }

  String _poolList() {
    return 'poolList';
  }

  List<RouteBase> aeDexRoutes(WidgetRef ref) {
    return <RouteBase>[
      GoRoute(
        path: RoutesPath().home(),
        builder: (BuildContext context, GoRouterState state) {
          final session = ref.read(SessionProviders.session);

          if (session.isConnected) {
            return const MainScreen();
          }

          return const WelcomeScreen();
        },
      ),
      GoRoute(
        path: RoutesPath().welcome(),
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
      ),
      GoRoute(
        path: RoutesPath().main(),
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen();
        },
        routes: [
          GoRoute(
            path: _swap(),
            builder: (context, state) {
              return const SwapSheet();
            },
          ),
          GoRoute(
            path: _poolList(),
            builder: (context, state) {
              return const PoolListSheet();
            },
          ),
        ],
      ),
    ];
  }
}
