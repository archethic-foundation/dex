import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/farm_factory.dart';
import 'package:aedex/application/market.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
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
  return ref
      .watch(_dexFarmsRepositoryProvider)
      .getFarmList(dexConf.routerGenesisAddress, apiService, ref);
}

@riverpod
Future<DexFarm?> _getFarmInfos(
  _GetFarmInfosRef ref,
  String farmGenesisAddress, {
  DexFarm? dexFarmInput,
}) async {
  final farmInfos = await ref
      .watch(_dexFarmsRepositoryProvider)
      .getFarmInfos(farmGenesisAddress, ref, dexFarmInput: dexFarmInput);

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

class DexFarmsRepository {
  Future<List<DexFarm>> getFarmList(
    String routerAddress,
    ApiService apiService,
    Ref ref,
  ) async {
    final resultFarmList = await RouterFactory(
      routerAddress,
      apiService,
    ).getFarmList();

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
    Ref ref, {
    DexFarm? dexFarmInput,
  }) async {
    final apiService = sl.get<ApiService>();
    final farmFactory = FarmFactory(farmGenesisAddress, apiService);

    final farmInfosResult =
        await farmFactory.getFarmInfos(dexFarmInput: dexFarmInput);
    return farmInfosResult.map(
      success: (dexFarm) async {
        // Apr calculation
        var remainingRewardInFiat = 0.0;
        if (dexFarm.rewardToken!.isUCO) {
          final archethicOracleUCO =
              ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

          remainingRewardInFiat =
              archethicOracleUCO.usd * dexFarm.remainingReward;
        } else {
          final price = await ref.read(
            MarketProviders.getPriceFromSymbol(dexFarm.rewardToken!.symbol)
                .future,
          );

          remainingRewardInFiat = price * dexFarm.remainingReward;
        }
        var lpTokenDepositedInFiat = 0.0;
        if (dexFarm.rewardToken!.isUCO) {
          final archethicOracleUCO =
              ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

          lpTokenDepositedInFiat =
              archethicOracleUCO.usd * dexFarm.lpTokenDeposited;
        } else {
          final price = await ref.read(
            MarketProviders.getPriceFromSymbol(dexFarm.rewardToken!.symbol)
                .future,
          );

          lpTokenDepositedInFiat = price * dexFarm.lpTokenDeposited;
        }

        var apr = 0.0;
        if (lpTokenDepositedInFiat > 0) {
          apr = (Decimal.parse('$remainingRewardInFiat') /
                  Decimal.parse('$lpTokenDepositedInFiat'))
              .toDouble();
        }

        return dexFarm.copyWith(
          apr: apr,
        );
      },
      failure: (failure) {
        return const DexFarm();
      },
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
}
