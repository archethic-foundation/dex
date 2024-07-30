import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/repositories/dex_pool.repository.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DexPoolRepositoryImpl implements DexPoolRepository {
  DexPoolRepositoryImpl({required this.apiService});

  final ApiService apiService;

  @override
  Future<DexPool?> getPool(
    String routerGenesisAddress,
    String poolAddress,
    List<String> tokenVerifiedList,
  ) async {
    final poolsListDatasource = await HivePoolsListDatasource.getInstance();
    final poolHive = poolsListDatasource.getPool(
      aedappfm.EndpointUtil.getEnvironnement(),
      poolAddress,
    );
    if (poolHive == null) {
      final resultPoolList = await RouterFactory(
        routerGenesisAddress,
        apiService,
      ).getPoolList(tokenVerifiedList);

      return await resultPoolList.map(
        success: (poolList) async {
          for (final poolInput in poolList) {
            if (poolInput.poolAddress.toUpperCase() ==
                poolAddress.toUpperCase()) {
              final pool = await populatePoolInfos(poolInput);
              await poolsListDatasource.setPool(
                aedappfm.EndpointUtil.getEnvironnement(),
                pool.toHive(),
              );
              return pool;
            }
          }
          return null;
        },
        failure: (failure) {
          return null;
        },
      );
    }

    return poolsListDatasource
        .getPool(aedappfm.EndpointUtil.getEnvironnement(), poolAddress)
        ?.toDexPool();
  }

  @override
  Future<DexPool> populatePoolInfos(
    DexPool poolInput,
  ) async {
    final apiService = aedappfm.sl.get<ApiService>();
    final poolFactory =
        PoolFactoryRepositoryImpl(poolInput.poolAddress, apiService);

    return poolFactory.populatePoolInfos(poolInput).valueOrThrow;
  }
}
