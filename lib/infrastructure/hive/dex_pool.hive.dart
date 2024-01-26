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
    required this.ranking,
    required this.pair,
    required this.fees,
    required this.ratioToken1Token2,
    required this.ratioToken2Token1,
    required this.estimatePoolTVLInFiat,
    required this.lpTokenInUserBalance,
    required this.token1TotalFee,
    required this.token1TotalVolume,
    required this.token2TotalFee,
    required this.token2TotalVolume,
  });

  factory DexPoolHive.fromDexPool(DexPool dexPool) {
    return DexPoolHive(
      poolAddress: dexPool.poolAddress,
      lpToken: dexPool.lpToken != null
          ? DexTokenHive.fromModel(dexPool.lpToken!)
          : null,
      ranking: dexPool.ranking,
      pair: dexPool.pair != null ? DexPairHive.fromModel(dexPool.pair!) : null,
      fees: dexPool.fees,
      ratioToken1Token2: dexPool.ratioToken1Token2,
      ratioToken2Token1: dexPool.ratioToken2Token1,
      estimatePoolTVLInFiat: dexPool.estimatePoolTVLInFiat,
      lpTokenInUserBalance: dexPool.lpTokenInUserBalance,
      token1TotalFee: dexPool.token1TotalFee,
      token1TotalVolume: dexPool.token1TotalVolume,
      token2TotalFee: dexPool.token2TotalFee,
      token2TotalVolume: dexPool.token2TotalVolume,
    );
  }
  @HiveField(0)
  String poolAddress;

  @HiveField(1)
  DexTokenHive? lpToken;

  @HiveField(2)
  int ranking;

  @HiveField(3)
  DexPairHive? pair;

  @HiveField(4)
  double fees;

  @HiveField(5)
  double ratioToken1Token2;

  @HiveField(6)
  double ratioToken2Token1;

  @HiveField(7)
  double estimatePoolTVLInFiat;

  @HiveField(8)
  bool lpTokenInUserBalance;

  @HiveField(9)
  double? token1TotalFee;

  @HiveField(10)
  double? token1TotalVolume;

  @HiveField(11)
  double? token2TotalFee;

  @HiveField(12)
  double? token2TotalVolume;

  DexPool toDexPool() {
    return DexPool(
      poolAddress: poolAddress,
      lpToken: lpToken != null ? lpToken!.toModel() : null,
      ranking: ranking,
      pair: pair != null ? pair!.toModel() : null,
      fees: fees,
      ratioToken1Token2: ratioToken1Token2,
      ratioToken2Token1: ratioToken2Token1,
      estimatePoolTVLInFiat: estimatePoolTVLInFiat,
      lpTokenInUserBalance: lpTokenInUserBalance,
      token1TotalFee: token1TotalFee ?? 0,
      token1TotalVolume: token1TotalVolume ?? 0,
      token2TotalFee: token2TotalFee ?? 0,
      token2TotalVolume: token2TotalVolume ?? 0,
    );
  }
}
