import 'dart:async';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/ui/views/util/router/router.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.setupDatabase();
  setupServiceLocator();
  setPathUrlStrategy();
  runApp(
    ProviderScope(
      observers: [
        aedappfm.ProvidersLogger(),
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
      await ref.read(aedappfm.CoinPriceProviders.coinPrice.notifier).init();
      await ref
          .read(
            aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO.notifier,
          )
          .init();
      await ref.read(aedappfm.UcidsTokensProviders.ucidsTokens.notifier).init();
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
    final router = ref.watch(routerProvider);

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
        aedappfm.AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
