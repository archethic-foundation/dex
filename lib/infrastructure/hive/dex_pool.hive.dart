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
    this.details,
  });

  DexPoolHive copyWith({
    DexPoolInfosHive? details,
  }) =>
      DexPoolHive(
        poolAddress: poolAddress,
        lpToken: lpToken,
        pair: pair,
        details: details ?? this.details,
        lpTokenInUserBalance: lpTokenInUserBalance,
      );

  @HiveField(0)
  String poolAddress;

  @HiveField(1)
  DexTokenHive lpToken;

  @HiveField(2)
  DexPairHive pair;

  @HiveField(3)
  bool lpTokenInUserBalance;

  @HiveField(4)
  DexPoolInfosHive? details;

  DexPool toDexPool() {
    return DexPool(
      lpTokenInUserBalance: lpTokenInUserBalance,
      poolAddress: poolAddress,
      lpToken: lpToken.toModel(),
      pair: pair.toModel(),
      infos: details?.toModel(),
    );
  }
}

@HiveType(typeId: HiveTypeIds.dexPoolInfos)
class DexPoolInfosHive extends HiveObject {
  DexPoolInfosHive({
    required this.fees,
    required this.ratioToken1Token2,
    required this.ratioToken2Token1,
    required this.token1TotalFee,
    required this.token1TotalVolume,
    required this.token2TotalFee,
    required this.token2TotalVolume,
  });

  @HiveField(1)
  double fees;

  @HiveField(2)
  double ratioToken1Token2;

  @HiveField(3)
  double ratioToken2Token1;

  @HiveField(4)
  double? token1TotalFee;

  @HiveField(5)
  double? token1TotalVolume;

  @HiveField(6)
  double? token2TotalFee;

  @HiveField(7)
  double? token2TotalVolume;

  // @HiveField(8)
  // double estimatePoolTVLInFiat;

  DexPoolInfos toModel() => DexPoolInfos(
        fees: fees,
        ratioToken1Token2: ratioToken1Token2,
        ratioToken2Token1: ratioToken2Token1,
        token1TotalFee: token1TotalFee ?? 0,
        token1TotalVolume: token1TotalVolume ?? 0,
        token2TotalFee: token2TotalFee ?? 0,
        token2TotalVolume: token2TotalVolume ?? 0,
      );
}

extension DexPoolInfosHiveConversionExt on DexPoolInfos {
  DexPoolInfosHive toHive() => DexPoolInfosHive(
        fees: fees,
        ratioToken1Token2: ratioToken1Token2,
        ratioToken2Token1: ratioToken2Token1,
        token1TotalFee: token1TotalFee,
        token1TotalVolume: token1TotalVolume,
        token2TotalFee: token2TotalFee,
        token2TotalVolume: token2TotalVolume,
      );
}

extension DexPoolHiveConversionExt on DexPool {
  DexPoolHive toHive() => DexPoolHive(
        lpTokenInUserBalance: lpTokenInUserBalance,
        poolAddress: poolAddress,
        lpToken: DexTokenHive.fromModel(lpToken),
        pair: DexPairHive.fromModel(pair),
        details: infos?.toHive(),
      );
}
