import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';

abstract class DexFarmLockRepository {
  Future<List<DexFarm>> getFarmLockList(
    String routerAddress,
    List<DexPool> poolList,
  );

  Future<DexFarmLock> populateFarmLockInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarmLock farmLockInput,
    String userGenesisAddress,
  );
}
