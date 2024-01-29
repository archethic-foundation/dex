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

  debugPrint('poolListCached ${poolListCached.length}');
  return poolListCached;
}

@riverpod
Future<void> _putPoolListInfosToCache(
  _PutPoolListInfosToCacheRef ref,
) async {
  // To gain some time, we are loading the first only verified pools
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolList = await ref.read(_getPoolListForUserProvider.future);
  for (final pool in poolList) {
    final poolWithInfos = await ref.read(
      DexPoolProviders.getPoolInfos(pool).future,
    );

    await poolsListDatasource.setPool(poolWithInfos!.toHive());
  }

  debugPrint('poolList stored');
  ref.invalidate(_getPoolListFromCacheProvider);
}
