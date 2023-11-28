import 'package:aedex/application/oracle/provider.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(ArchethicOracleUCOProviders.archethicOracleUCO.notifier).init();

    // GoRouter configuration
    final _router = GoRouter(
      routes: RoutesPath().aeDexRoutes(ref),
    );

    return MaterialApp.router(
      routerConfig: _router,
      title: 'AEDex',
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
