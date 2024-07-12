// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm_lock_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexFarmLockStatsImpl _$$DexFarmLockStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$DexFarmLockStatsImpl(
      depositsCount: (json['depositsCount'] as num?)?.toInt() ?? 0,
      lpTokensDeposited: (json['lpTokensDeposited'] as num?)?.toDouble() ?? 0.0,
      rewardsAllocated: (json['rewardsAllocated'] as List<dynamic>?)
              ?.map((e) => DexFarmLockStatsRewardsAllocated.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      aprEstimation: (json['aprEstimation'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DexFarmLockStatsImplToJson(
        _$DexFarmLockStatsImpl instance) =>
    <String, dynamic>{
      'depositsCount': instance.depositsCount,
      'lpTokensDeposited': instance.lpTokensDeposited,
      'rewardsAllocated': instance.rewardsAllocated,
      'weight': instance.weight,
      'aprEstimation': instance.aprEstimation,
    };
