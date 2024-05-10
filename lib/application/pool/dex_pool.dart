import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/infrastructure/dex_pool.repository.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/favorite_pools.hive.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/infrastructure/pool.repository.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';
part 'dex_pool_cache.dart';
part 'dex_pool_calculation.dart';
part 'dex_pool_detail.dart';
part 'dex_pool_favorite.dart';
part 'dex_pool_list.dart';

@riverpod
DexPoolRepositoryImpl _dexPoolRepository(_DexPoolRepositoryRef ref) =>
    DexPoolRepositoryImpl(
      apiService: aedappfm.sl.get<ApiService>(),
    );

@riverpod
void _invalidateDataUseCase(_InvalidateDataUseCaseRef ref) {
  ref
    ..invalidate(_getRatioProvider)
    ..invalidate(_getPoolListForUserProvider)
    ..invalidate(_getPoolInfosProvider)
    ..invalidate(_getPoolListProvider);
}

abstract class DexPoolProviders {
  static final invalidateData = _invalidateDataUseCaseProvider;

  // Pool List
  static final getPoolList = _getPoolListProvider;
  static final getPoolListForUser = _getPoolListForUserProvider;
  static const getPoolListForSearch = _getPoolListForSearchProvider;

  // Pool Detail
  static const getPoolInfos = _getPoolInfosProvider;
  static const getPool = _getPoolProvider;
  static const loadPoolCard = _loadPoolCardProvider;

  // Cache
  static final putPoolListInfosToCache = _putPoolListInfosToCacheProvider;
  static const updatePoolInCache = _updatePoolInCacheProvider;
  static const putPoolToCache = _putPoolToCacheProvider;

  // Calculation
  static const getRatio = _getRatioProvider;
  static const estimatePoolTVLInFiat = _estimatePoolTVLInFiatProvider;
  static const populatePoolInfosWithTokenStats24h =
      _populatePoolInfosWithTokenStats24hProvider;
  static const estimateStats = _estimateStatsProvider;

  // Favorite
  static const addPoolFromFavorite = _addPoolFromFavoriteProvider;
  static const removePoolFromFavorite = _removePoolFromFavoriteProvider;
}
