import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DexFarmRepository {
  Future<List<DexFarm>> getFarmList(
    String routerAddress,
    ApiService apiService,
    Ref ref,
    List<DexPool> poolList,
  );

  Future<DexFarm> populateFarmInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarm farmInput,
  );

  Future<DexFarmUserInfos> getUserInfos(
    String farmGenesisAddress,
    String userGenesisAddress,
  );
}
