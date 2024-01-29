import 'dart:async';

import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/ui/views/util/router.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/generic/providers_observer.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.setupDatabase();
  setupServiceLocator();

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
  Timer? _poolListTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(SessionProviders.session.notifier).connectToWallet(
            forceConnection: false,
          );

      final session = ref.read(SessionProviders.session);
      if (session.isConnected == false) {
        ref
            .read(SessionProviders.session.notifier)
            .connectEndpoint(session.envSelected);
      }

      await ref
          .read(ArchethicOracleUCOProviders.archethicOracleUCO.notifier)
          .init();
      await ref.read(DexPoolProviders.putPoolListInfosToCache.future);

      _poolListTimer =
          Timer.periodic(const Duration(minutes: 1), (timer) async {
        await ref.read(DexPoolProviders.putPoolListInfosToCache.future);
      });
    });
  }

  @override
  void dispose() {
    _poolListTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // GoRouter configuration
    final _router = GoRouter(
      routes: RoutesPath().aeDexRoutes(ref),
    );

    return MaterialApp.router(
      routerConfig: _router,
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
