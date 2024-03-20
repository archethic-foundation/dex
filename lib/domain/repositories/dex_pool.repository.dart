import 'package:aedex/domain/models/dex_pool.dart';

abstract class DexPoolRepository {
  Future<DexPool?> getPool(String poolAddress);

  Future<DexPool> populatePoolInfos(
    DexPool poolInput,
  );
}
