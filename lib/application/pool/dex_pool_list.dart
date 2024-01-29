/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  final dexPools = <DexPool>[];
  final userBalance =
      await ref.read(BalanceProviders.getUserTokensBalance.future);

  final resultPoolList = await RouterFactory(
    dexConf.routerGenesisAddress,
    apiService,
  ).getPoolList(userBalance!);

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
