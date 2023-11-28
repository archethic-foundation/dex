import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:coingecko_api/coingecko_api.dart';

void setupServiceLocator() {
  sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<CoinGeckoApi>(CoinGeckoApi.new)
    ..registerLazySingleton<LogManager>(LogManager.new)
    ..registerLazySingleton<OracleService>(
      () =>
          OracleService('https://mainnet.archethic.net', logsActivation: false),
    );
}

void setupServiceLocatorApiService(String endpoint) {
  sl.registerLazySingleton<ApiService>(
    () => ApiService(endpoint, logsActivation: false),
  );
}
