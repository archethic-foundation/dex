import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/farm_factory.dart';
import 'package:aedex/application/market.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_farm.g.dart';

@riverpod
DexFarmsRepository _dexFarmsRepository(_DexFarmsRepositoryRef ref) =>
    DexFarmsRepository();

@riverpod
Future<List<DexFarm>> _getFarmList(
  _GetFarmListRef ref,
) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  var poolList = <DexPool>[];

  final poolListResult =
      await RouterFactory(dexConf.routerGenesisAddress, apiService)
          .getPoolList();
  await poolListResult.map(
    success: (success) async {
      poolList = success;
    },
    failure: (failure) {},
  );

  return ref
      .watch(_dexFarmsRepositoryProvider)
      .getFarmList(dexConf.routerGenesisAddress, apiService, ref, poolList);
}

@riverpod
Future<DexFarm?> _getFarmInfos(
  _GetFarmInfosRef ref,
  String farmGenesisAddress,
  String poolAddress, {
  DexFarm? dexFarmInput,
}) async {
  final dexConf =
      await ref.watch(DexConfigProviders.dexConfigRepository).getDexConfig();
  final apiService = sl.get<ApiService>();
  final poolListResult =
      await RouterFactory(dexConf.routerGenesisAddress, apiService)
          .getPoolList();
  DexPool? pool;
  await poolListResult.map(
    success: (success) async {
      pool = success.singleWhere(
        (poolSelect) =>
            poolSelect.poolAddress.toUpperCase() == poolAddress.toUpperCase(),
      );
    },
    failure: (failure) {},
  );

  final farmInfos = await ref.watch(_dexFarmsRepositoryProvider).getFarmInfos(
        farmGenesisAddress,
        pool!,
        ref,
        dexFarmInput: dexFarmInput,
      );

  return farmInfos;
}

@riverpod
Future<DexFarmUserInfos?> _getUserInfos(
  _GetUserInfosRef ref,
  String farmGenesisAddress,
  String userGenesisAddress,
) async {
  final farmInfos = await ref
      .watch(_dexFarmsRepositoryProvider)
      .getUserInfos(farmGenesisAddress, userGenesisAddress);

  return farmInfos;
}

@riverpod
Future<double> _estimateLPTokenInFiat(
  _EstimateLPTokenInFiatRef ref,
  DexToken token1,
  DexToken token2,
  double lpTokenAmount,
  String poolAddress,
) async {
  var fiatValueToken1 = 0.0;
  var fiatValueToken2 = 0.0;

  fiatValueToken1 =
      await ref.watch(DexPoolProviders.estimateTokenInFiat(token1).future);
  fiatValueToken2 =
      await ref.watch(DexPoolProviders.estimateTokenInFiat(token2).future);

  if (fiatValueToken1 == 0 && fiatValueToken2 == 0) {
    throw Exception();
  }

  final apiService = sl.get<ApiService>();
  final amountsResult = await PoolFactory(poolAddress, apiService)
      .getRemoveAmounts(lpTokenAmount);
  var amountToken1 = 0.0;
  var amountToken2 = 0.0;
  amountsResult.map(
    success: (success) {
      if (success != null) {
        amountToken1 =
            success['token1'] == null ? 0.0 : success['token1'] as double;
        amountToken2 =
            success['token2'] == null ? 0.0 : success['token2'] as double;
      }
    },
    failure: (failure) {},
  );

  if (fiatValueToken1 > 0 && fiatValueToken2 > 0) {
    return amountToken1 * fiatValueToken1 + amountToken2 * fiatValueToken1;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 == 0) {
    return (amountToken1 + amountToken2) * fiatValueToken1;
  }

  if (fiatValueToken1 == 0 && fiatValueToken2 > 0) {
    return (amountToken1 + amountToken2) * fiatValueToken2;
  }

  return 0;
}

class DexFarmsRepository {
  Future<List<DexFarm>> getFarmList(
    String routerAddress,
    ApiService apiService,
    Ref ref,
    List<DexPool> poolList,
  ) async {
    final resultFarmList = await RouterFactory(
      routerAddress,
      apiService,
    ).getFarmList(poolList);

    return resultFarmList.map(
      success: (farmList) async {
        return farmList;
      },
      failure: (failure) {
        return <DexFarm>[];
      },
    );
  }

  Future<DexFarm?> getFarmInfos(
    String farmGenesisAddress,
    DexPool pool,
    Ref ref, {
    DexFarm? dexFarmInput,
  }) async {
    final apiService = sl.get<ApiService>();
    final farmFactory = FarmFactory(farmGenesisAddress, apiService);

    final farmInfosResult =
        await farmFactory.getFarmInfos(pool, dexFarmInput: dexFarmInput);
    // Apr calculation
    var remainingRewardInFiat = 0.0;
    DexFarm? dexFarm;
    await farmInfosResult.map(
      success: (success) async {
        dexFarm = success;
        if (dexFarm!.rewardToken!.isUCO) {
          final archethicOracleUCO =
              ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

          remainingRewardInFiat =
              archethicOracleUCO.usd * dexFarm!.remainingReward;
        } else {
          final price = await ref.read(
            MarketProviders.getPriceFromSymbol(dexFarm!.rewardToken!.symbol)
                .future,
          );

          remainingRewardInFiat = price * dexFarm!.remainingReward;
        }
      },
      failure: (failure) {},
    );

    return dexFarm!.copyWith(
      remainingRewardInFiat: remainingRewardInFiat,
    );
  }

  Future<DexFarmUserInfos> getUserInfos(
    String farmGenesisAddress,
    String userGenesisAddress,
  ) async {
    final apiService = sl.get<ApiService>();
    final farmFactory = FarmFactory(farmGenesisAddress, apiService);

    final farmInfosResult = await farmFactory.getUserInfos(userGenesisAddress);
    return farmInfosResult.map(
      success: (success) {
        return success;
      },
      failure: (failure) {
        return const DexFarmUserInfos();
      },
    );
  }
}

abstract class DexFarmProviders {
  static final getFarmList = _getFarmListProvider;
  static const getFarmInfos = _getFarmInfosProvider;
  static const getUserInfos = _getUserInfosProvider;
  static const estimateLPTokenInFiat = _estimateLPTokenInFiatProvider;
}
