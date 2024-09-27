import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:aedex/domain/repositories/dex_pool.repository.dart';
import 'package:aedex/infrastructure/dex_config.repository.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DexPoolRepositoryImpl with ModelParser implements DexPoolRepository {
  DexPoolRepositoryImpl({
    required this.apiService,
    required this.verifiedTokensRepository,
  });

  final ApiService apiService;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;

  @override
  Future<DexPool?> getPool(
    String poolAddress,
    List<String> tokenVerifiedList,
  ) async {
    final environment = aedappfm.Environment.byEndpoint(apiService.endpoint);
    final poolsLocalDatasource = await HivePoolsListDatasource.getInstance();
    final poolHive = poolsLocalDatasource.getPool(
      environment.name,
      poolAddress,
    );
    if (poolHive == null) {
      final dexConf = await DexConfigRepositoryImpl().getDexConfig(environment);
      final resultPoolList = await RouterFactory(
        dexConf.routerGenesisAddress,
        apiService,
        verifiedTokensRepository,
      ).getPoolList(environment, tokenVerifiedList);

      return await resultPoolList.map(
        success: (poolList) async {
          for (final pool in poolList) {
            if (pool.poolAddress.toUpperCase() == poolAddress.toUpperCase()) {
              await poolsLocalDatasource.setPool(
                environment.name,
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

    return poolsLocalDatasource
        .getPool(environment.name, poolAddress)
        ?.toDexPool();
  }
}
