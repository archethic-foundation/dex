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
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
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
    DexPoolsRepository();

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  final dexPoolsRepository = ref.watch(_dexPoolsRepositoryProvider);
  return dexPoolsRepository.getPoolListForUser(
    dexConf.routerGenesisAddress,
    apiService,
    ref,
  );
}

@riverpod
Future<List<DexPool>> _getPoolListForUser(
  _GetPoolListForUserRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  return ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolList(dexConf.routerGenesisAddress, apiService, ref);
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
  Future<List<DexPool>> getPoolListForUser(
    String routerAddress,
    ApiService apiService,
    Ref ref,
  ) async {
    final dexPools = <DexPool>[];
    final poolListFuture = ref.read(DexPoolProviders.getPoolList.future);

    final verifiedTokensFuture =
        ref.read(VerifiedTokensProviders.getVerifiedTokensFromNetwork.future);

    final session = ref.read(SessionProviders.session);
    Future<Balance?> userBalanceFuture;
    if (session.isConnected && session.genesisAddress.isNotEmpty) {
      userBalanceFuture = await ref.read(
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
    final resultPoolList = results[2] as Result<List<DexPool>, Failure>?;

    await resultPoolList!.map(
      success: (poolList) async {
        for (var pool in poolList) {
          if (verifiedTokens!.contains(pool.pair!.token1.address)) {
            pool = pool.copyWith(
              pair: pool.pair!.copyWith(
                token1: pool.pair!.token1.copyWith(isVerified: true),
              ),
            );
          }

          if (verifiedTokens.contains(pool.pair!.token2.address)) {
            pool = pool.copyWith(
              pair: pool.pair!.copyWith(
                token1: pool.pair!.token2.copyWith(isVerified: true),
              ),
            );
          }

          if (userBalance != null) {
            for (final userTokensBalance in userBalance.token) {
              if (pool.lpToken != null &&
                  pool.lpToken!.address != null &&
                  pool.lpToken!.address == userTokensBalance.address) {
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
      },
      failure: (failure) {},
    );

    dexPools.sort((a, b) {
      if (a.isVerified == b.isVerified) return 0;
      return a.isVerified ? -1 : 1;
    });

    return dexPools;
  }

  Future<List<DexPool>> getPoolList(
    String routerAddress,
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
          dexPools.add(pool);
        }
      },
      failure: (failure) {},
    );

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
    return dexPool;
  }
}

abstract class DexPoolProviders {
  static final getPoolList = _getPoolListProvider;
  static const getPoolInfos = _getPoolInfosProvider;
  static const estimatePoolTVLInFiat = _estimatePoolTVLInFiatProvider;
  static const estimateTokenInFiat = _estimateTokenInFiatProvider;
  static final putPoolListToCache = _putPoolListToCacheProvider;
  static final getPoolListForUser = _getPoolListForUserProvider;
  static final getPoolListFromCache = _getPoolListFromCacheProvider;
  static const estimateStats = _estimateStatsProvider;
  static const getRatio = _getRatioProvider;
}
