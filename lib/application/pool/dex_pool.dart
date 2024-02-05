import 'package:aedex/application/balance.dart';
import 'package:aedex/application/coin_price.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/infrastructure/dex_pool.repository.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';
part 'dex_pool_cache.dart';
part 'dex_pool_calculation.dart';
part 'dex_pool_list.dart';

@riverpod
DexPoolRepositoryImpl _dexPoolRepository(_DexPoolRepositoryRef ref) =>
    DexPoolRepositoryImpl(
      apiService: sl.get<ApiService>(),
    );

@riverpod
void _invalidateDataUseCase(_InvalidateDataUseCaseRef ref) {
  ref
    ..invalidate(_getRatioProvider)
    ..invalidate(_estimateStatsProvider)
    ..invalidate(_getPoolListForUserProvider)
    ..invalidate(_getPoolInfosProvider)
    ..invalidate(_getPoolListProvider)
    ..invalidate(_getPoolListFromCacheProvider);
}

@riverpod
Future<DexPool?> _getPool(
  _GetPoolRef ref,
  String genesisAddress,
) async {
  return ref.read(_dexPoolRepositoryProvider).getPool(ref, genesisAddress);
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

abstract class DexPoolProviders {
  static final invalidateData = _invalidateDataUseCaseProvider;

  static const getPoolInfos = _getPoolInfosProvider;
  static const estimatePoolTVLandAPRInFiat =
      _estimatePoolTVLandAPRInFiatProvider;
  static final putPoolListInfosToCache = _putPoolListInfosToCacheProvider;
  static final myPools = _myPoolsProvider;
  static final verifiedPools = _verifiedPoolsProvider;
  static final favoritePools = _favoritePoolsProvider;
  static const updatePoolInCache = _updatePoolInCacheProvider;
  static const putPoolToCache = _putPoolToCacheProvider;
  static const estimateStats = _estimateStatsProvider;
  static const getRatio = _getRatioProvider;
  static const getPoolListForSearch = _getPoolListForSearchProvider;
  static final getPoolList = _getPoolListProvider;
  static const getPool = _getPoolProvider;
  static final getPoolListFromCache = _getPoolListFromCacheProvider;
  static const populatePoolInfosWithTokenStats24h =
      _populatePoolInfosWithTokenStats24hProvider;
}
