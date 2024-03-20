/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@Riverpod(keepAlive: true)
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = aedappfm.sl.get<ApiService>();
  final dexPools = <DexPool>[];
  final userBalance =
      await ref.read(BalanceProviders.getUserTokensBalance.future);

  final tokenVerifiedList = ref
      .read(aedappfm.VerifiedTokensProviders.verifiedTokens)
      .verifiedTokensList;

  final resultPoolList = await RouterFactory(
    dexConf.routerGenesisAddress,
    apiService,
  ).getPoolList(userBalance, tokenVerifiedList);

  await resultPoolList.map(
    success: (poolList) async {
      for (final pool in poolList) {
        dexPools.add(pool);
      }
    },
    failure: (failure) {},
  );

  return dexPools;
}

@riverpod
Future<List<DexPool>> _getPoolListForUser(
  _GetPoolListForUserRef ref,
) async {
  final dexPools = <DexPool>[];
  final poolList = await ref.read(_getPoolListProvider.future);

  for (final pool in poolList) {
    if (pool.isVerified || pool.lpTokenInUserBalance) {
      dexPools.add(pool);
    }
  }

  dexPools.sort((a, b) {
    if (a.isVerified == b.isVerified) return 0;
    return a.isVerified ? -1 : 1;
  });

  return dexPools;
}

@riverpod
Future<List<DexPool>> _getPoolListForSearch(
  _GetPoolListForUserRef ref,
  String searchText,
) async {
  bool _poolMatchesSearch(DexPool pool) {
    return (pool.poolAddress.toUpperCase() == searchText.toUpperCase() ||
            pool.pair.token1.address!.toUpperCase() ==
                searchText.toUpperCase() ||
            pool.pair.token2.address!.toUpperCase() ==
                searchText.toUpperCase() ||
            pool.lpToken.address!.toUpperCase() == searchText.toUpperCase()) ||
        (searchText.toUpperCase() == 'UCO' &&
            (pool.pair.token1.isUCO || pool.pair.token2.isUCO));
  }

  final dexPools = <DexPool>[];
  if (searchText.isEmpty ||
      (searchText.length != 68 && searchText.toUpperCase() != 'UCO')) {
    return dexPools;
  }

  final poolList = await ref.read(_getPoolListProvider.future);
  //final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  for (final pool in poolList) {
    if (!_poolMatchesSearch(pool)) continue;

    final poolHive =
        await ref.read(DexPoolProviders.getPool(pool.poolAddress).future);

    //final poolHive = poolsListDatasource.getPool(pool.poolAddress);
    if (poolHive == null) {
      final poolWithInfos = await ref.read(
        DexPoolProviders.getPoolInfos(pool).future,
      );
      if (poolWithInfos != null) {
        dexPools.add(poolWithInfos);
      }
    } else {
      dexPools.add(poolHive);
    }
  }
  return dexPools;
}
