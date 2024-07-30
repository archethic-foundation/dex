import 'package:aedex/domain/models/dex_config.dart';

abstract class DexConfigRepository {
  Future<DexConfig> getDexConfig(String environment);
}
