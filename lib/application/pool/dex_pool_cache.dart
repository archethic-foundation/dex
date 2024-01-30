/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<List<DexPool>> _userTokenPools(
  _UserTokenPoolsRef ref,
) async {
  final pools = await ref.watch(_getPoolListFromCacheProvider.future);
  return pools
      .where(
        (element) => element.lpTokenInUserBalance,
      )
      .toList();
}

@riverpod
Future<List<DexPool>> _verifiedPools(
  _VerifiedPoolsRef ref,
) async {
  final pools = await ref.watch(_getPoolListFromCacheProvider.future);
  return pools
      .where(
        (element) => element.isVerified,
      )
      .toList();
}

@riverpod
Future<List<DexPool>> _myPools(
  _VerifiedPoolsRef ref,
) async {
  final pools = await ref.watch(_getPoolListFromCacheProvider.future);
  return pools;
}

@riverpod
Future<List<DexPool>> _getPoolListFromCache(
  _GetPoolListFromCacheRef ref,
) async {
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolListCached = poolsListDatasource
      .getPoolsList()
      .map(
        (hiveObject) => hiveObject.toDexPool(),
      )
      .toList();

  return poolListCached;
}

@riverpod
Future<void> _putPoolListInfosToCache(
  _PutPoolListInfosToCacheRef ref,
) async {
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolList = await ref.read(_getPoolListForUserProvider.future);
  for (final pool in poolList) {
    final poolWithInfos = await ref.read(
      DexPoolProviders.getPoolInfos(pool).future,
    );

    await poolsListDatasource.setPool(poolWithInfos!.toHive());
  }

  ref.invalidate(_getPoolListFromCacheProvider);
}

@riverpod
Future<void> _updatePoolInCache(
  _UpdatePoolInCacheRef ref,
  DexPool pool,
) async {
  final poolWithInfos = await ref.read(_getPoolInfosProvider(pool).future);
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  await poolsListDatasource.setPool(poolWithInfos!.toHive());
  ref.invalidate(_getPoolListFromCacheProvider);
}

@riverpod
Future<void> _putPoolToCache(
  _PutPoolToCacheRef ref,
  String poolGenesisAddress,
) async {
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolList = await ref.read(_getPoolListProvider.future);

  final pool = poolList.firstWhere(
    (element) =>
        element.poolAddress.toUpperCase() == poolGenesisAddress.toUpperCase(),
    orElse: () => throw const Failure.poolNotExists(),
  );
  await poolsListDatasource.setPool(pool.toHive());
  ref.invalidate(_getPoolListFromCacheProvider);
}
