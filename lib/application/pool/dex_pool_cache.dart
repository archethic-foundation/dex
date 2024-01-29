/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<List<DexPool>> _getPoolListFromCache(
  _GetPoolListFromCacheRef ref,
) async {
  final poolListCache = <DexPool>[];
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolListCached = poolsListDatasource.getPoolsList();

  debugPrint('poolListCached ${poolListCached.length}');

  for (final poolHive in poolListCached) {
    final pool = poolHive.toDexPool();
    poolListCache.add(pool);
  }

  poolListCache.sort((a, b) {
    if (a.lpTokenInUserBalance && !b.lpTokenInUserBalance) {
      return -1;
    } else if (!a.lpTokenInUserBalance && b.lpTokenInUserBalance) {
      return 1;
    }
    if (a.isVerified && !b.isVerified) {
      return -1;
    } else if (!a.isVerified && b.isVerified) {
      return 1;
    }
    return 0;
  });

  return poolListCache;
}

@riverpod
Future<void> _putPoolListToCache(
  _PutPoolListToCacheRef ref,
) async {
  // To gain some time, we are loading the first only verified pools
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  final poolListCache = <DexPoolHive>[];

  final session = ref.read(SessionProviders.session);
  Balance? userBalance;
  if (session.isConnected && session.genesisAddress.isNotEmpty) {
    userBalance = await ref.read(
      BalanceProviders.getUserTokensBalance(session.genesisAddress).future,
    );
  }

  final poolList = await ref.read(DexPoolProviders.getPoolListForUser.future);
  for (final pool in poolList) {
    var poolInfos =
        await ref.read(DexPoolProviders.getPoolInfos(pool.poolAddress).future);

    if (poolInfos != null) {
      final estimatePoolTVLInFiat = await ref.read(
        DexPoolProviders.estimatePoolTVLInFiat(
          poolInfos,
        ).future,
      );

      if (userBalance != null) {
        for (final userTokensBalance in userBalance.token) {
          if (poolInfos != null &&
              poolInfos.lpToken != null &&
              poolInfos.lpToken!.address != null &&
              poolInfos.lpToken!.address == userTokensBalance.address) {
            poolInfos = poolInfos.copyWith(
              lpTokenInUserBalance: true,
            );
          }
        }
      }

      poolInfos =
          poolInfos!.copyWith(estimatePoolTVLInFiat: estimatePoolTVLInFiat);

      poolListCache.add(
        DexPoolHive.fromDexPool(poolInfos),
      );
    }
  }
  await poolsListDatasource.setPoolsList(poolListCache);

  debugPrint('poolList stored');
  ref.read(SessionProviders.session.notifier).setCacheFirstLoading(false);
  ref.invalidate(
    DexPoolProviders.getPoolListFromCache,
  );
}
