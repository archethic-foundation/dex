// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_farm_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetFarmListResponseImpl _$$GetFarmListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetFarmListResponseImpl(
      lpTokenAddress: json['lp_token_address'] as String,
      startDate: json['start_date'] as int,
      endDate: json['end_date'] as int,
      rewardTokenAddress: json['reward_token'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$$GetFarmListResponseImplToJson(
        _$GetFarmListResponseImpl instance) =>
    <String, dynamic>{
      'lp_token_address': instance.lpTokenAddress,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'reward_token': instance.rewardTokenAddress,
      'address': instance.address,
    };
