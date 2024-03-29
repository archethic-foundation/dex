import 'package:aedex/application/farm/farm_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/repositories/dex_farm.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DexFarmRepositoryImpl implements DexFarmRepository {
  @override
  Future<List<DexFarm>> getFarmList(
    String routerAddress,
    ApiService apiService,
    List<DexPool> poolList,
  ) async =>
      RouterFactory(
        routerAddress,
        apiService,
      ).getFarmList(poolList).valueOrThrow;

  @override
  Future<DexFarm> populateFarmInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarm farmInput,
  ) async {
    final apiService = aedappfm.sl.get<ApiService>();
    final farmFactory = FarmFactory(farmGenesisAddress, apiService);

    return farmFactory.populateFarmInfos(pool, farmInput).valueOrThrow;
  }

  @override
  Future<DexFarmUserInfos> getUserInfos(
    String farmGenesisAddress,
    String userGenesisAddress,
  ) async {
    final apiService = aedappfm.sl.get<ApiService>();
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
