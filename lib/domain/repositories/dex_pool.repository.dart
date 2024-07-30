import 'package:aedex/domain/models/dex_pool.dart';

abstract class DexPoolRepository {
  Future<DexPool?> getPool(
    String routerGenesisAddress,
    String poolAddress,
    List<String> tokenVerifiedList,
  );

  Future<DexPool> populatePoolInfos(
    DexPool poolInput,
  );
}
