import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_pool.dart';

abstract class DexFarmRepository {
  Future<List<DexFarm>> getFarmList(
    String routerAddress,
    List<DexPool> poolList,
  );

  Future<DexFarm> populateFarmInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarm farmInput,
    String userGenesisAddress,
  );
}
