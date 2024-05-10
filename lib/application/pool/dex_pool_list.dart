/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final dexConf =
      await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = aedappfm.sl.get<ApiService>();
  final dexPools = <DexPool>[];

  await ref.read(SessionProviders.session.notifier).refreshUserBalance();

  final tokenVerifiedList = ref
      .read(aedappfm.VerifiedTokensProviders.verifiedTokens)
      .verifiedTokensList;

  final resultPoolList = await RouterFactory(
    dexConf.routerGenesisAddress,
    apiService,
  ).getPoolList(tokenVerifiedList);

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
List<DexPool> _getPoolListForSearch(
  _GetPoolListForSearchRef ref,
  String searchText,
  List<DexPool> poolList,
) {
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

  for (final pool in poolList) {
    if (_poolMatchesSearch(pool)) dexPools.add(pool);
  }
  return dexPools;
}
