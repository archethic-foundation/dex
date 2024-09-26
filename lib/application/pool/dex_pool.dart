import 'package:aedex/application/api_service.dart';
import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/domain/enum/dex_action_type.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool_infos.dart';
import 'package:aedex/domain/models/dex_pool_tx.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/repositories/dex_pool.repository.dart';
import 'package:aedex/infrastructure/dex_pool.repository.dart';
import 'package:aedex/infrastructure/hive/favorite_pools.hive.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';
part 'dex_pool_calculation.dart';
part 'dex_pool_detail.dart';
part 'dex_pool_favorite.dart';
part 'dex_pool_list.dart';
part 'dex_pool_tx_list.dart';

@Riverpod(keepAlive: true)
DexPoolRepository _dexPoolRepository(
  _DexPoolRepositoryRef ref,
) =>
    DexPoolRepositoryImpl(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
    );

abstract class DexPoolProviders {
  // Pool List
  static final getPoolList = _getPoolListProvider;
  static const getPoolListForSearch = _getPoolListForSearchProvider;

  // Pool transactions list
  static const getPoolTxList = _getPoolTxListProvider;

  // Pool Detail
  static const getPool = _poolProvider;

  // Calculation
  static const getRatio = _getRatioProvider;
  static const estimatePoolTVLInFiat = _estimatePoolTVLInFiatProvider;
  static const estimateStats = _estimateStatsProvider;

  // Favorite
  static const addPoolFromFavorite = _addPoolFromFavoriteProvider;
  static const removePoolFromFavorite = _removePoolFromFavoriteProvider;
}
