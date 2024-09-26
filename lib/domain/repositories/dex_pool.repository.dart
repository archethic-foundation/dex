import 'package:aedex/domain/models/dex_pool.dart';

abstract class DexPoolRepository {
  Future<DexPool?> getPool(
    String poolAddress,
    List<String> tokenVerifiedList,
  );
}
