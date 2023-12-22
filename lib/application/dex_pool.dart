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
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/util/cache_manager_hive.dart';
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
  final cacheManagerHive = await CacheManagerHive.getInstance();
  if (cacheManagerHive.contains('poolList') == false) {
    return <DexPool>[];
  }
  final poolListCached =
      cacheManagerHive.get<List<DexPoolHive>>('poolList') ?? [];

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
  final cacheManagerHive = await CacheManagerHive.getInstance();
  var onlyVerified = false;
  if (cacheManagerHive.contains('poolList') == false) {
    onlyVerified = true;
  }
  final poolListCache = <DexPoolHive>[];

  final session = ref.read(SessionProviders.session);
  Balance? userBalance;
  if (session.isConnected && session.genesisAddress.isNotEmpty) {
    userBalance = await ref.read(
      BalanceProviders.getUserTokensBalance(session.genesisAddress).future,
    );
  }

  final poolList =
      await ref.read(DexPoolProviders.getPoolList(onlyVerified).future);
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
  await cacheManagerHive.put('poolList', CacheItemHive(poolListCache));

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
  var fiatValue = 0.0;
  var tvl = 0.0;
  fiatValue = await ref
      .watch(DexPoolProviders.estimateTokenInFiat(pool.pair!.token1).future);

  if (fiatValue > 0) {
    tvl = pool.pair!.token1.reserve * fiatValue * 2;
  }

  if (fiatValue == 0) {
    fiatValue = await ref
        .watch(DexPoolProviders.estimateTokenInFiat(pool.pair!.token2).future);
    if (fiatValue > 0) {
      tvl = pool.pair!.token2.reserve * fiatValue * 2;
    }
  }

  return tvl;
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
