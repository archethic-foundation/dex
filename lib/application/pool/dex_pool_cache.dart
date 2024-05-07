/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<void> _putPoolListInfosToCache(
  _PutPoolListInfosToCacheRef ref,
) async {
  ref.invalidate(_getPoolListProvider);

  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolList = await ref.read(_getPoolListForUserProvider.future);
  final tx24hAddress = <String, String>{};
  for (final pool in poolList) {
    tx24hAddress[pool.poolAddress] = '';
  }

  final fromCriteria =
      (DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch /
              1000)
          .round();
  final transactionChainResult =
      await aedappfm.sl.get<ApiService>().getTransactionChain(
            tx24hAddress,
            request:
                ' validationStamp { ledgerOperations { unspentOutputs { state } } }',
            fromCriteria: fromCriteria,
          );

  //
  final apiService = aedappfm.sl.get<ApiService>();
  final poolListWithInfos =
      await PoolRepositoryImpl(apiService).getPoolInfosBatch(poolList);

  for (var poolWithInfos in poolListWithInfos) {
    poolWithInfos = ref.read(
      DexPoolProviders.populatePoolInfosWithTokenStats24h(
        poolWithInfos,
        transactionChainResult,
      ),
    );

    // Check if favorite in cache
    final isPoolFavorite =
        poolsListDatasource.getPool(poolWithInfos.poolAddress);
    if (isPoolFavorite != null &&
        isPoolFavorite.isFavorite != null &&
        isPoolFavorite.isFavorite == true) {
      poolWithInfos =
          poolWithInfos.copyWith(isFavorite: isPoolFavorite.isFavorite!);
    }

    await poolsListDatasource.setPool(poolWithInfos.toHive());
  }
}

@riverpod
Future<void> _updatePoolInCache(
  _UpdatePoolInCacheRef ref,
  DexPool pool,
) async {
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  await poolsListDatasource.removePool(pool.poolAddress);
  var poolWithInfos = await ref.read(_getPoolInfosProvider(pool).future);

  final fromCriteria =
      (DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch /
              1000)
          .round();
  final transactionChainResult =
      await aedappfm.sl.get<ApiService>().getTransactionChain(
    {pool.poolAddress: ''},
    request:
        ' validationStamp { ledgerOperations { unspentOutputs { state } } }',
    fromCriteria: fromCriteria,
  );
  poolWithInfos = ref.read(
    DexPoolProviders.populatePoolInfosWithTokenStats24h(
      poolWithInfos!,
      transactionChainResult,
    ),
  );
  await poolsListDatasource.setPool(poolWithInfos!.toHive());
  ref.invalidate(DexPoolProviders.getPool(poolWithInfos.poolAddress));
}

@riverpod
Future<void> _putPoolToCache(
  _PutPoolToCacheRef ref,
  String poolGenesisAddress, {
  bool isFavorite = false,
}) async {
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolList = await ref.read(_getPoolListProvider.future);

  final pool = poolList.firstWhere(
    (element) =>
        element.poolAddress.toUpperCase() == poolGenesisAddress.toUpperCase(),
    orElse: () => throw const aedappfm.Failure.poolNotExists(),
  );

  final fromCriteria =
      (DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch /
              1000)
          .round();
  final transactionChainResult =
      await aedappfm.sl.get<ApiService>().getTransactionChain(
    {pool.poolAddress: ''},
    request:
        ' validationStamp { ledgerOperations { unspentOutputs { state } } }',
    fromCriteria: fromCriteria,
  );
  var poolWithInfos = await ref.read(
    DexPoolProviders.getPoolInfos(pool).future,
  );
  poolWithInfos = ref.read(
    DexPoolProviders.populatePoolInfosWithTokenStats24h(
      poolWithInfos!,
      transactionChainResult,
    ),
  );
  poolWithInfos = poolWithInfos!.copyWith(isFavorite: isFavorite);

  await poolsListDatasource.setPool(poolWithInfos.toHive());

  await ref
      .read(
        PoolItemProvider.poolItem(poolWithInfos.poolAddress).notifier,
      )
      .setPool(poolWithInfos);
}
