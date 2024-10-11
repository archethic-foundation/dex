import 'dart:async';

import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/router/router.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
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
  aedappfm.LoggerOutput.setup();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await DBHelper.setupDatabase();
  await setupServiceLocator();

  setPathUrlStrategy();
  runApp(
    ProviderScope(
      observers: [
        aedappfm.ProvidersLogger(),
      ],
      child: const ProvidersInitialization(child: MyApp()),
    ),
  );
}

/// Eagerly initializes providers (https://riverpod.dev/docs/essentials/eager_initialization).
///
/// Add Watch here for any provider you want to init when app is displayed.
/// Those providers will be kept alive during application lifetime.
class ProvidersInitialization extends ConsumerWidget {
  const ProvidersInitialization({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..watch(DexPoolProviders.getPoolList)
      ..watch(DexTokensProviders.tokensCommonBases)
      ..watch(verifiedTokensProvider)
      ..watch(DexTokensProviders.tokensFromAccount)
      ..watch(poolsToDisplayProvider)
      ..watch(farmLockFormFarmLockProvider);

    return child;
  }
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
