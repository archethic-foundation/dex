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
Future<DexPool?> _getPoolInfos(
  _GetPoolInfosRef ref,
  DexPool poolInput,
) async {
  final poolInfos =
      await ref.watch(_dexPoolRepositoryProvider).populatePoolInfos(poolInput);

  return poolInfos;
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
  final tvl = ref.read(DexPoolProviders.estimatePoolTVLInFiat(poolOutput));
  final fromCriteria =
      (DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch /
              1000)
          .round();
  final transactionChainResult =
      await aedappfm.sl.get<ApiService>().getTransactionChain(
    {poolInput.poolAddress: ''},
    request:
        ' validationStamp { ledgerOperations { unspentOutputs { state } } }',
    fromCriteria: fromCriteria,
  );

  poolOutput = ref.read(
    DexPoolProviders.populatePoolInfosWithTokenStats24h(
      poolOutput,
      transactionChainResult,
    ),
  );
  final stats = ref.read(DexPoolProviders.estimateStats(poolOutput));

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
      fee24h: stats.fee24h,
      feeAllTime: stats.feeAllTime,
      volume24h: stats.volume24h,
      volumeAllTime: stats.volumeAllTime,
    ),
  );
}
