/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/market.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';
part 'dex_pool_cache.dart';
part 'dex_pool_calculation.dart';

@riverpod
DexPoolsRepository _dexPoolsRepository(_DexPoolsRepositoryRef ref) =>
    DexPoolsRepository(
      apiService: sl.get<ApiService>(),
    );

@riverpod
void _invalidateDataUseCase(_InvalidateDataUseCaseRef ref) {
  ref
    ..invalidate(_getRatioProvider)
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
  DexPool? pool;
  await ref.read(_dexPoolsRepositoryProvider).getPool(genesisAddress);
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  final poolHive = poolsListDatasource.getPool(genesisAddress);
  if (poolHive != null) {
    pool = poolHive.toDexPool();
    final poolInfos = await ref
        .read(_dexPoolsRepositoryProvider)
        .getPoolInfos(genesisAddress);
    pool = pool.copyWith(infos: poolInfos);
  }
  return pool;
}

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  return ref.watch(_dexPoolsRepositoryProvider).getPoolList(
        dexConf.routerGenesisAddress,
      );
}

@riverpod
Future<List<DexPool>> _getPoolListForUser(
  _GetPoolListForUserRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  return ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolListForUser(dexConf.routerGenesisAddress, ref);
}

@riverpod
Future<DexPoolInfos?> _getPoolInfos(
  _GetPoolInfosRef ref,
  String poolGenesisAddress,
) async {
  final poolInfos = await ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolInfos(poolGenesisAddress);

  // if (poolInfos != null) {
  //   final estimatePoolTVLInFiat = await ref.watch(
  //     DexPoolProviders.estimatePoolTVLInFiat(
  //       poolInfos,
  //     ).future,
  //   );

  //   poolInfos =
  //       poolInfos.copyWith(estimatePoolTVLInFiat: estimatePoolTVLInFiat);
  // }

  return poolInfos;
}

@riverpod
Future<double> _getRatio(
  _GetRatioRef ref,
  String poolGenesisAddress,
  DexToken token,
) async {
  final apiService = sl.get<ApiService>();
  final poolRatioResult = await PoolFactory(
    poolGenesisAddress,
    apiService,
  ).getPoolRatio(
    token.isUCO ? 'UCO' : token.address!,
  );
  var ratio = 0.0;
  poolRatioResult.map(
    success: (success) {
      if (success != null) {
        ratio = success;
      }
    },
    failure: (failure) {},
  );
  return ratio;
}

class DexPoolsRepository {
  DexPoolsRepository({required this.apiService});

  final ApiService apiService;

  // Future<DexPool?> getPool(String address) async {
  //   final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  //   if (poolsListDatasource.shouldBeReloaded) {
  //     await _cachePoolsFromRemote();
  //   }

  //   return poolsListDatasource.getPool(address)?.toDexPool();
  // }

  // Future<DexPoolInfos?> getPoolInfos(String address) async {
  //   //     final poolsListDatasource = await HivePoolsListDatasource.getInstance();

  //   // if (poolsListDatasource.shouldBeReloaded) {
  //   //   await _cachePoolsFromRemote();
  //   // }

  //   // return poolsListDatasource.getPool(address)?.toDexPool();

  // }

  Future<List<DexPool>> getPoolListForUser(
    Ref ref,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    final dexPools = <DexPool>[];
    final poolListFuture = ref.read(_getPoolListProvider.future);

    final verifiedTokensFuture =
        ref.read(VerifiedTokensProviders.getVerifiedTokensFromNetwork.future);

    final session = ref.read(SessionProviders.session);
    Future<Balance?> userBalanceFuture;
    if (session.isConnected && session.genesisAddress.isNotEmpty) {
      userBalanceFuture = ref.read(
        BalanceProviders.getUserTokensBalance(session.genesisAddress).future,
      );
    } else {
      userBalanceFuture = Future.value();
    }

    final results = await Future.wait(
      [verifiedTokensFuture, userBalanceFuture, poolListFuture],
    );

    final verifiedTokens = results[0] as List<String>?;
    final userBalance = results[1] as Balance?;
    final poolList = results[2] as List<DexPool>? ?? [];

    for (var pool in poolList) {
      if (verifiedTokens!.contains(pool.pair.token1.address)) {
        pool = pool.copyWith(
          pair: pool.pair.copyWith(
            token1: pool.pair.token1.copyWith(isVerified: true),
          ),
        );
      }

      if (verifiedTokens.contains(pool.pair.token2.address)) {
        pool = pool.copyWith(
          pair: pool.pair.copyWith(
            token2: pool.pair.token2.copyWith(isVerified: true),
          ),
        );
      }

      if (userBalance != null) {
        for (final userTokensBalance in userBalance.token) {
          if (pool.lpToken.address != null &&
              pool.lpToken.address == userTokensBalance.address) {
            pool = pool.copyWith(
              lpTokenInUserBalance: true,
            );
          }
        }
      }

      if (pool.isVerified || pool.lpTokenInUserBalance) {
        dexPools.add(pool);
      }
    }

    dexPools.sort((a, b) {
      if (a.isVerified == b.isVerified) return 0;
      return a.isVerified ? -1 : 1;
    });

    return dexPools;
  }

  Future<List<DexPool>> getPoolList(
    String routerAddress,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    final dexPools = <DexPool>[];
    final resultPoolList = await RouterFactory(
      routerAddress,
      apiService,
    ).getPoolList();

    await resultPoolList.map(
      success: (poolList) async {
        for (final pool in poolList) {
          dexPools.add(pool);
        }
      },
      failure: (failure) {},
    );

    return dexPools;
  }

  Future<DexPoolInfos?> getPoolInfos(
    String poolGenesisAddress,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    final apiService = sl.get<ApiService>();
    final poolFactory = PoolFactory(poolGenesisAddress, apiService);

    return poolFactory.getPoolInfos().valueOrThrow;
  }
}

abstract class DexPoolProviders {
  static final invalidateData = _invalidateDataUseCaseProvider;

  static const getPoolInfos = _getPoolInfosProvider;
  static const estimatePoolTVLInFiat = _estimatePoolTVLInFiatProvider;
  static const estimateTokenInFiat = _estimateTokenInFiatProvider;
  static final putPoolListInfosToCache = _putPoolListInfosToCacheProvider;
  static final userTokenPools = _userTokenPoolsProvider;
  static final verifiedPools = _verifiedPoolsProvider;

  static const estimateStats = _estimateStatsProvider;
  static const getRatio = _getRatioProvider;

  static const getPool = _getPoolProvider;
}
