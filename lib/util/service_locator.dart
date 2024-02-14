import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

void setupServiceLocator() {
  aedappfm.sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<LogManager>(LogManager.new)
    ..registerLazySingleton<OracleService>(
      () =>
          OracleService('https://mainnet.archethic.net', logsActivation: false),
    );
}

void setupServiceLocatorApiService(String endpoint) {
  aedappfm.sl.registerLazySingleton<ApiService>(
    () => ApiService(endpoint, logsActivation: false),
  );
}
