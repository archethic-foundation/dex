import 'dart:developer';

import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:coingecko_api/coingecko_api.dart';

void setupServiceLocator() {
  sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<CoinGeckoApi>(CoinGeckoApi.new)
    ..registerLazySingleton<OracleService>(
      () =>
          OracleService('https://mainnet.archethic.net', logsActivation: true),
    );
  log('Register', name: 'OracleService');
}

void setupServiceLocatorApiService(String endpoint) {
  sl.registerLazySingleton<ApiService>(
    () => ApiService(endpoint),
  );
  log('Register', name: 'ApiService');
}
