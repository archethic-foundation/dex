import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm_lock_stats.freezed.dart';
part 'dex_farm_lock_stats.g.dart';

@freezed
class DexFarmLockStats with _$DexFarmLockStats {
  const factory DexFarmLockStats({
    @Default(0) int depositsCount,
    @Default(0.0) double lpTokensDeposited,
    @Default(0.0) double rewardsAllocated,
    @Default(0.0) double tvlRatio,
    @Default(0.0) double weight,
    @Default(0.0) double aprEstimation,
  }) = _DexFarmLockStats;
  const DexFarmLockStats._();

  factory DexFarmLockStats.fromJson(Map<String, dynamic> json) =>
      _$DexFarmLockStatsFromJson(json);
}
