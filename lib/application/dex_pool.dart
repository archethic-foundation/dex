/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/market.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';

@riverpod
DexPoolsRepository _dexPoolsRepository(_DexPoolsRepositoryRef ref) =>
    DexPoolsRepository();

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
  bool onlyVerified,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  return ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolList(dexConf.routerGenesisAddress, onlyVerified, apiService, ref);
}

@riverpod
Future<DexPool?> _getPoolInfos(
  _GetPoolInfosRef ref,
  String poolGenesisAddress,
) async {
  var poolInfos = await ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolInfos(poolGenesisAddress);
  if (poolInfos != null) {
    final estimatePoolTVLInFiat = await ref.watch(
      DexPoolProviders.estimatePoolTVLInFiat(
        poolInfos,
      ).future,
    );

    poolInfos =
        poolInfos.copyWith(estimatePoolTVLInFiat: estimatePoolTVLInFiat);
  }

  return poolInfos;
}

@riverpod
Future<List<DexPool>> _getPoolListFromCache(
  _GetPoolListFromCacheRef ref,
  bool onlyVerified,
  bool onlyPoolsWithLiquidityPositions,
) async {
  final poolListCache = <DexPool>[];
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  final poolListCached = poolsListDatasource.getPoolsList();

  debugPrint('poolListCached ${poolListCached.length}');

  for (final poolHive in poolListCached) {
    final pool = poolHive.toDexPool();
    if ((onlyPoolsWithLiquidityPositions && pool.lpTokenInUserBalance ||
            !onlyPoolsWithLiquidityPositions) &&
        (onlyVerified && pool.isVerified || !onlyVerified)) {
      poolListCache.add(pool);
    }
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

  final poolList = await ref.read(DexPoolProviders.getPoolList(false).future);
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
  final poolListForm = ref.read(PoolListFormProvider.poolListForm);
  ref.invalidate(
    DexPoolProviders.getPoolListFromCache(
      poolListForm.onlyVerifiedPools,
      poolListForm.onlyPoolsWithLiquidityPositions,
    ),
  );
}

@riverpod
Future<double> _estimateTokenInFiat(
  _EstimateTokenInFiatRef ref,
  DexToken token,
) async {
  var fiatValue = 0.0;
  if (token.symbol == 'UCO') {
    final archethicOracleUCO =
        ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

    fiatValue = archethicOracleUCO.usd;
  } else {
    final price = await ref
        .watch(MarketProviders.getPriceFromSymbol(token.symbol).future);

    fiatValue = price;
  }
  return fiatValue;
}

@riverpod
Future<double> _estimatePoolTVLInFiat(
  _EstimatePoolTVLInFiatRef ref,
  DexPool pool,
) async {
  var fiatValueToken1 = 0.0;
  var fiatValueToken2 = 0.0;

  fiatValueToken1 = await ref
      .watch(DexPoolProviders.estimateTokenInFiat(pool.pair!.token1).future);
  fiatValueToken2 = await ref
      .watch(DexPoolProviders.estimateTokenInFiat(pool.pair!.token2).future);

  if (fiatValueToken1 > 0 && fiatValueToken2 > 0) {
    return pool.pair!.token1.reserve * fiatValueToken1 +
        pool.pair!.token2.reserve * fiatValueToken1;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 == 0) {
    return pool.pair!.token1.reserve * fiatValueToken1 * 2;
  }

  if (fiatValueToken1 == 0 && fiatValueToken2 > 0) {
    return pool.pair!.token2.reserve * fiatValueToken2 * 2;
  }

  return 0;
}

class DexPoolsRepository {
  Future<List<DexPool>> getPoolList(
    String routerAddress,
    bool onlyVerified,
    ApiService apiService,
    Ref ref,
  ) async {
    final dexPools = <DexPool>[];
    final resultPoolList = await RouterFactory(
      routerAddress,
      apiService,
    ).getPoolList();

    await resultPoolList.map(
      success: (poolList) async {
        for (final pool in poolList) {
          if (onlyVerified && pool.isVerified == true) {
            dexPools.add(pool);
          } else {
            if (onlyVerified == false) {
              dexPools.add(pool);
            }
          }
        }
      },
      failure: (failure) {},
    );

    dexPools.sort((a, b) {
      if (a.isVerified == b.isVerified) return 0;
      return a.isVerified ? -1 : 1;
    });

    return dexPools;
  }

  Future<DexPool?> getPoolInfos(
    String poolGenesisAddress,
  ) async {
    DexPool? dexPool;
    final apiService = sl.get<ApiService>();
    final poolFactory = PoolFactory(poolGenesisAddress, apiService);

    final poolInfosResult = await poolFactory.getPoolInfos();
    poolInfosResult.map(
      success: (success) {
        dexPool = success;
      },
      failure: (failure) {},
    );

    return dexPool!;
  }
}

abstract class DexPoolProviders {
  static const getPoolList = _getPoolListProvider;
  static const getPoolInfos = _getPoolInfosProvider;
  static const estimatePoolTVLInFiat = _estimatePoolTVLInFiatProvider;
  static const estimateTokenInFiat = _estimateTokenInFiatProvider;
  static final putPoolListToCache = _putPoolListToCacheProvider;
  static const getPoolListFromCache = _getPoolListFromCacheProvider;
}
