import 'package:aedex/domain/models/dex_pool.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DexPoolRepository {
  Future<DexPool?> getPool(Ref ref, String address);

  Future<DexPool> populatePoolInfos(
    DexPool poolInput,
  );
}
