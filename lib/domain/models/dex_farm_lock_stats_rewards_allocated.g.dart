// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm_lock_stats_rewards_allocated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexFarmLockStatsRewardsAllocatedImpl
    _$$DexFarmLockStatsRewardsAllocatedImplFromJson(
            Map<String, dynamic> json) =>
        _$DexFarmLockStatsRewardsAllocatedImpl(
          rewardsAllocated:
              (json['rewardsAllocated'] as num?)?.toDouble() ?? 0.0,
          startPeriod: (json['startPeriod'] as num?)?.toInt() ?? 0,
          endPeriod: (json['endPeriod'] as num?)?.toInt() ?? 0,
        );

Map<String, dynamic> _$$DexFarmLockStatsRewardsAllocatedImplToJson(
        _$DexFarmLockStatsRewardsAllocatedImpl instance) =>
    <String, dynamic>{
      'rewardsAllocated': instance.rewardsAllocated,
      'startPeriod': instance.startPeriod,
      'endPeriod': instance.endPeriod,
    };
