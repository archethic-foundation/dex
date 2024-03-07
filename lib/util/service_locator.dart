import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

void setupServiceLocator() {
  aedappfm.sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<OracleService>(
      () =>
          OracleService('https://mainnet.archethic.net', logsActivation: false),
    );
}

void setupServiceLocatorApiService(String endpoint) {
  aedappfm.sl
    ..registerLazySingleton<ApiService>(
      () => ApiService(endpoint, logsActivation: false),
    )
    ..registerLazySingleton<aedappfm.LogManager>(() {
      // TODO(reddwarf03): Get url
      if (aedappfm.EndpointUtil.getEnvironnement() == 'mainnet') {
        return aedappfm.LogManager(
          url: '',
        );
      } else {
        return aedappfm.LogManager(
          url:
              'https://faas-lon1-917a94a7.doserverless.co/api/v1/web/fn-279bbae3-a757-4cef-ade7-a63bdaca36f7/default/app-log',
        );
      }
    });
}
