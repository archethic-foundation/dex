import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

Future<void> setupServiceLocator() async {
  if (aedappfm.sl.isRegistered<aedappfm.LogManager>()) {
    await aedappfm.sl.unregister<aedappfm.LogManager>();
  }

  aedappfm.sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<OracleService>(
      () => OracleService('https://mainnet.archethic.net'),
    )
    ..registerLazySingleton<aedappfm.LogManager>(() {
      if (Uri.base.toString().toLowerCase().contains('dex.archethic') ||
          Uri.base.toString().toLowerCase().contains('swap.archethic')) {
        return aedappfm.LogManager(
          url:
              'https://faas-lon1-917a94a7.doserverless.co/api/v1/web/fn-279bbae3-a757-4cef-ade7-a63bdaca36f7/default/app-log-mainnet',
        );
      } else {
        return aedappfm.LogManager(
          url:
              'https://faas-lon1-917a94a7.doserverless.co/api/v1/web/fn-279bbae3-a757-4cef-ade7-a63bdaca36f7/default/app-log',
        );
      }
    });
}
