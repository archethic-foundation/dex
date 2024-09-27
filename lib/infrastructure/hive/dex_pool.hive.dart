import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:aedex/infrastructure/hive/dex_pair.hive.dart';
import 'package:aedex/infrastructure/hive/dex_token.hive.dart';
import 'package:hive/hive.dart';

part 'dex_pool.hive.g.dart';

@HiveType(typeId: HiveTypeIds.dexPool)
class DexPoolHive extends HiveObject {
  DexPoolHive({
    required this.poolAddress,
    required this.lpToken,
    required this.pair,
    required this.lpTokenInUserBalance,
    required this.isFavorite,
  });

  @HiveField(0)
  String poolAddress;

  @HiveField(1)
  DexTokenHive lpToken;

  @HiveField(2)
  DexPairHive pair;

  @HiveField(3)
  bool lpTokenInUserBalance;

  // @HiveField(4)
  // DexPoolInfosHive? details;

  @HiveField(5)
  bool? isFavorite;

  DexPool toDexPool() {
    return DexPool(
      lpTokenInUserBalance: lpTokenInUserBalance,
      isFavorite: isFavorite ?? false,
      poolAddress: poolAddress,
      lpToken: lpToken.toModel(),
      pair: pair.toModel(),
    );
  }
}

extension DexPoolHiveConversionExt on DexPool {
  DexPoolHive toHive() => DexPoolHive(
        lpTokenInUserBalance: lpTokenInUserBalance,
        poolAddress: poolAddress,
        lpToken: DexTokenHive.fromModel(lpToken),
        pair: DexPairHive.fromModel(pair),
        isFavorite: isFavorite,
      );
}
