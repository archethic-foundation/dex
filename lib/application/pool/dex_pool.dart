import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/enum/dex_action_type.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool_tx.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/infrastructure/dex_pool.repository.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/favorite_pools.hive.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';
part 'dex_pool_calculation.dart';
part 'dex_pool_detail.dart';
part 'dex_pool_favorite.dart';
part 'dex_pool_list.dart';
part 'dex_pool_tx_list.dart';

@riverpod
DexPoolRepositoryImpl _dexPoolRepository(_DexPoolRepositoryRef ref) =>
    DexPoolRepositoryImpl(
      apiService: aedappfm.sl.get<ApiService>(),
    );

@riverpod
void _invalidateDataUseCase(_InvalidateDataUseCaseRef ref) {
  ref
    ..invalidate(_getRatioProvider)
    ..invalidate(_getPoolListProvider);
}

abstract class DexPoolProviders {
  static final invalidateData = _invalidateDataUseCaseProvider;

  // Pool List
  static final getPoolList = _getPoolListProvider;
  static const getPoolListForSearch = _getPoolListForSearchProvider;

  // Pool transactions list
  static const getPoolTxList = _getPoolTxListProvider;

  // Pool Detail
  static const getPool = _getPoolProvider;
  static const loadPoolCard = _loadPoolCardProvider;

  // Calculation
  static const getRatio = _getRatioProvider;
  static const estimatePoolTVLInFiat = _estimatePoolTVLInFiatProvider;
  static const estimateStats = _estimateStatsProvider;

  // Favorite
  static const addPoolFromFavorite = _addPoolFromFavoriteProvider;
  static const removePoolFromFavorite = _removePoolFromFavoriteProvider;
}
