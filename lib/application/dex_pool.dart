/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';

@riverpod
DexPoolsRepository _dexPoolsRepository(_DexPoolsRepositoryRef ref) =>
    DexPoolsRepository();

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final dexConf = await ref
      .watch(DexConfigProviders.dexConfigRepository)
      .getDexConfig('devnet');
  final apiService = sl.get<ApiService>();
  return ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolList(dexConf.routerGenesisAddress, apiService);
}

class DexPoolsRepository {
  Future<List<DexPool>> getPoolList(
    String routerAddress,
    ApiService apiService,
  ) async {
    final dexPools = <DexPool>[];
    final resultPoolList = await RouterFactory(
      routerAddress,
      apiService,
    ).getPoolList();

    await resultPoolList.map(
      success: (poolList) async {
        final apiService = sl.get<ApiService>();
        for (final pool in poolList) {
          final poolFactory = PoolFactory(pool.poolAddress, apiService);
          final poolInfosResult = await poolFactory.getPoolInfos();
          poolInfosResult.map(
            success: (dexPool) {
              dexPools.add(dexPool);
            },
            failure: (failure) {},
          );
        }
      },
      failure: (failure) {},
    );
    return dexPools;
  }
}

abstract class DexPoolProviders {
  static final getPoolList = _getPoolListProvider;
}
