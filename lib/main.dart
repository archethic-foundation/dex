import 'dart:async';

import 'package:aedex/application/coin_price.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/ucids_tokens.dart';
import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_background.dart';
import 'package:aedex/ui/views/util/router.dart';
import 'package:aedex/ui/views/welcome/welcome_screen.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/generic/providers_observer.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.setupDatabase();
  setupServiceLocator();
  setPathUrlStrategy();

  final preferences = await HivePreferencesDatasource.getInstance();
  sl.get<LogManager>().logsActived = preferences.isLogsActived();
  runApp(
    ProviderScope(
      observers: [
        ProvidersLogger(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final router = RoutesPath(rootNavigatorKey).createRouter();
  Timer? _poolListTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(CoinPriceProviders.coinPrice.notifier).init();
      await ref.read(SessionProviders.session.notifier).connectToWallet(
            forceConnection: false,
          );

      var session = ref.read(SessionProviders.session);
      if (session.isConnected == false) {
        ref
            .read(SessionProviders.session.notifier)
            .connectEndpoint(session.envSelected);
      }

      await ref
          .read(ArchethicOracleUCOProviders.archethicOracleUCO.notifier)
          .init();
      await ref.read(UcidsTokensProviders.ucidsTokens.notifier).init(ref);
      await ref.read(DexPoolProviders.putPoolListInfosToCache.future);
      _poolListTimer =
          Timer.periodic(const Duration(minutes: 1), (timer) async {
        await ref.read(DexPoolProviders.putPoolListInfosToCache.future);
      });

      session = ref.read(SessionProviders.session);
      if (session.endpoint.isNotEmpty) {
        if (mounted) {
          ref
              .read(
                navigationIndexMainScreenProvider.notifier,
              )
              .state = 0;
          context.go(SwapSheet.routerPage, extra: <String, dynamic>{});
        }
      } else {
        ref.invalidate(SessionProviders.session);
        if (mounted) context.go(WelcomeScreen.routerPage);
      }
    });
  }

  @override
  void dispose() {
    _poolListTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'aeSwap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'PPTelegraf',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'PPTelegraf',
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

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
          if (mounted) context.go(WelcomeScreen.routerPage);
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
        if (mounted) {
          ref
              .read(
                navigationIndexMainScreenProvider.notifier,
              )
              .state = 0;
          context.go(SwapSheet.routerPage, extra: <String, dynamic>{});
        }
      } else {
        ref.invalidate(SessionProviders.session);
        if (mounted) context.go(WelcomeScreen.routerPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DexBackground(),
    );
  }
}
