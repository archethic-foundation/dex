/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/verified_pools.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';

@riverpod
DexPoolsRepository _dexPoolsRepository(_DexPoolsRepositoryRef ref) =>
    DexPoolsRepository();

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
  bool onlyVerified,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  return ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolList(dexConf.routerGenesisAddress, onlyVerified, apiService, ref);
}

@riverpod
Future<DexPool?> _getPoolInfos(
  _GetPoolInfosRef ref,
  String poolGenesisAddress,
) async {
  return ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolInfos(poolGenesisAddress);
}

class DexPoolsRepository {
  Future<List<DexPool>> getPoolList(
    String routerAddress,
    bool onlyVerified,
    ApiService apiService,
    Ref ref,
  ) async {
    final dexPools = <DexPool>[];
    final resultPoolList = await RouterFactory(
      routerAddress,
      apiService,
    ).getPoolList();

    await resultPoolList.map(
      success: (poolList) async {
        for (final pool in poolList) {
          var dexPool = pool;
          final isVerified = await ref.read(
            VerifiedPoolsProviders.isVerifiedPool(dexPool.poolAddress).future,
          );
          dexPool = dexPool.copyWith(verified: isVerified);
          if (onlyVerified && isVerified == true) {
            dexPools.add(dexPool);
          } else {
            if (onlyVerified == false) {
              dexPools.add(dexPool);
            }
          }
        }
      },
      failure: (failure) {},
    );

    dexPools.sort((a, b) {
      if (a.verified == b.verified) return 0;
      return a.verified ? -1 : 1;
    });

    return dexPools;
  }

  Future<DexPool?> getPoolInfos(
    String poolGenesisAddress,
  ) async {
    DexPool? dexPool;
    final apiService = sl.get<ApiService>();
    final poolFactory = PoolFactory(poolGenesisAddress, apiService);

    final poolInfosResult = await poolFactory.getPoolInfos();
    poolInfosResult.map(
      success: (success) {
        dexPool = success;
      },
      failure: (failure) {},
    );

    return dexPool!;
  }
}

abstract class DexPoolProviders {
  static const getPoolList = _getPoolListProvider;
  static const getPoolInfos = _getPoolInfosProvider;
}
