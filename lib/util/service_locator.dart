import 'dart:developer';

import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

void setupServiceLocator() {
  sl.registerLazySingleton<DBHelper>(DBHelper.new);
}

void setupServiceLocatorApiService(String endpoint) {
  sl.registerLazySingleton<ApiService>(
    () => ApiService(endpoint),
  );
  log('Register', name: 'ApiService');
  sl.registerLazySingleton<OracleService>(
    () => OracleService(endpoint),
  );
  log('Register', name: 'OracleService');
}
