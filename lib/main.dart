import 'dart:async';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/router/router.dart';
import 'package:aedex/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await DBHelper.setupDatabase();
  await setupServiceLocator();
  await setupServiceLocatorApiService(
    aedappfm.EndpointUtil.getEnvironnementUrl('mainnet'),
  );

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
  const MyApp({
    super.key,
  });

  @override
  ConsumerState<MyApp> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    unawaited(
      ref.read(aedappfm.CoinPriceProviders.coinPrices.notifier).startTimer(),
    );
    unawaited(
      ref
          .read(
            aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO.notifier,
          )
          .startSubscription(),
    );
    // Faire un futur provider. Donc pas besoin du init
    unawaited(
      ref
          .read(
            aedappfm.VerifiedTokensProviders.verifiedTokens.notifier,
          )
          .init('mainnet'),
    );

    ref.read(sessionNotifierProvider);
    super.initState();
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
