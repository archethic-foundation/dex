/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<DexPool?> _getPool(
  _GetPoolRef ref,
  String genesisAddress,
) async {
  final tokenVerifiedList = ref
      .read(aedappfm.VerifiedTokensProviders.verifiedTokens)
      .verifiedTokensList;

  return ref
      .read(_dexPoolRepositoryProvider)
      .getPool(genesisAddress, tokenVerifiedList);
}

@riverpod
Future<DexPool> _loadPoolCard(
  _LoadPoolCardRef ref,
  DexPool poolInput, {
  bool forceLoadFromBC = false,
}) async {
  DexPool poolOutput;

  // Load from cache
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  final poolHive = poolsListDatasource.getPool(
    aedappfm.EndpointUtil.getEnvironnement(),
    poolInput.poolAddress,
  );

  if (forceLoadFromBC == true || poolHive == null) {
    // Load from BC
    final apiService = aedappfm.sl.get<ApiService>();
    final poolFactory =
        PoolFactoryRepositoryImpl(poolInput.poolAddress, apiService);
    poolOutput = await poolFactory.populatePoolInfos(poolInput).valueOrThrow;

    // Set to cache
    await poolsListDatasource.setPool(
      aedappfm.EndpointUtil.getEnvironnement(),
      poolOutput.toHive(),
    );
  } else {
    poolOutput = poolHive.toDexPool();
  }

  // Load dynamic values
  final userBalance = ref.read(SessionProviders.session).userBalance;
  var lpTokenInUserBalance = false;
  if (userBalance != null) {
    for (final userTokensBalance in userBalance.token) {
      if (poolOutput.lpToken.address!.toUpperCase() ==
          userTokensBalance.address!.toUpperCase()) {
        lpTokenInUserBalance = true;
      }
    }
  }
  poolOutput = poolOutput.copyWith(
    lpTokenInUserBalance: lpTokenInUserBalance,
  );

  final tvl = ref.read(DexPoolProviders.estimatePoolTVLInFiat(poolOutput));

  poolOutput =
      await ref.read(DexPoolProviders.estimateStats(poolOutput).future);

  // Favorite
  final favoritePoolsDatasource =
      await HiveFavoritePoolsDatasource.getInstance();
  final isFavorite = favoritePoolsDatasource.isFavoritePool(
    aedappfm.EndpointUtil.getEnvironnement(),
    poolInput.poolAddress,
  );

  return poolOutput.copyWith(
    isFavorite: isFavorite,
    infos: poolOutput.infos!.copyWith(
      tvl: tvl,
    ),
  );
}
