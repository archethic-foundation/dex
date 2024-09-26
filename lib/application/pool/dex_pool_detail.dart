/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<DexPool?> _pool(
  _PoolRef ref,
  String poolAddress,
) async {
  final environment = ref.watch(environmentProvider);
  final dexPoolRepository = ref.watch(_dexPoolRepositoryProvider);
  final tokenVerifiedList = await ref.watch(
    verifiedTokensProvider.future,
  );

  final pool = await dexPoolRepository.getPool(
    poolAddress,
    tokenVerifiedList,
  );

  if (pool == null) return null;

  final userBalance = await ref.watch(userBalanceProvider.future);
  final lpTokenInUserBalance = userBalance.token.any(
    (token) =>
        token.address!.toUpperCase() == pool.lpToken.address.toUpperCase(),
  );

  final tvl =
      await ref.watch(DexPoolProviders.estimatePoolTVLInFiat(pool).future);

  final poolStats =
      await ref.watch(DexPoolProviders.estimateStats(pool).future);

  // Favorite
  final favoritePoolsDatasource =
      await HiveFavoritePoolsDatasource.getInstance();
  final isFavorite = favoritePoolsDatasource.isFavoritePool(
    environment.name,
    poolAddress,
  );

  return pool.copyWith(
    isFavorite: isFavorite,
    infos: pool.infos!.copyWith(
      tvl: tvl,
    ),
    stats: poolStats,
    lpTokenInUserBalance: lpTokenInUserBalance,
  );
}
