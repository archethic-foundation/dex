import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/repositories/dex_pool.repository.dart';
import 'package:aedex/infrastructure/dex_config.repository.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DexPoolRepositoryImpl implements DexPoolRepository {
  DexPoolRepositoryImpl({required this.apiService});

  final ApiService apiService;
  @override
  Future<DexPool?> getPool(String poolAddress) async {
    final poolsListDatasource = await HivePoolsListDatasource.getInstance();

    final poolHive = poolsListDatasource.getPool(poolAddress);
    if (poolHive == null) {
      final dexConf = await DexConfigRepositoryImpl().getDexConfig();
      final resultPoolList = await RouterFactory(
        dexConf.routerGenesisAddress,
        apiService,
      ).getPoolList(null);

      return await resultPoolList.map(
        success: (poolList) async {
          for (final poolInput in poolList) {
            if (poolInput.poolAddress.toUpperCase() == poolAddress) {
              final pool = await populatePoolInfos(poolInput);
              await poolsListDatasource.setPool(pool.toHive());
            }
          }
          return null;
        },
        failure: (failure) {
          return null;
        },
      );
    }

    return poolsListDatasource.getPool(poolAddress)?.toDexPool();
  }

  @override
  Future<DexPool> populatePoolInfos(
    DexPool poolInput,
  ) async {
    final apiService = aedappfm.sl.get<ApiService>();
    final poolFactory = PoolFactory(poolInput.poolAddress, apiService);

    return poolFactory.populatePoolInfos(poolInput).valueOrThrow;
  }
}
