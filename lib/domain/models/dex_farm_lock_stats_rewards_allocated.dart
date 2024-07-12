import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm_lock_stats_rewards_allocated.freezed.dart';
part 'dex_farm_lock_stats_rewards_allocated.g.dart';

@freezed
class DexFarmLockStatsRewardsAllocated with _$DexFarmLockStatsRewardsAllocated {
  const factory DexFarmLockStatsRewardsAllocated({
    @Default(0.0) double rewardsAllocated,
    @Default(0) int startPeriod,
    @Default(0) int endPeriod,
  }) = _DexFarmLockStatsRewardsAllocated;
  const DexFarmLockStatsRewardsAllocated._();

  factory DexFarmLockStatsRewardsAllocated.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DexFarmLockStatsRewardsAllocatedFromJson(json);
}
