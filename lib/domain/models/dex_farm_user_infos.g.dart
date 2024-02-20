// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm_user_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexFarmUserInfosImpl _$$DexFarmUserInfosImplFromJson(
        Map<String, dynamic> json) =>
    _$DexFarmUserInfosImpl(
      depositedAmount: (json['depositedAmount'] as num?)?.toDouble() ?? 0.0,
      rewardAmount: (json['rewardAmount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DexFarmUserInfosImplToJson(
        _$DexFarmUserInfosImpl instance) =>
    <String, dynamic>{
      'depositedAmount': instance.depositedAmount,
      'rewardAmount': instance.rewardAmount,
    };
