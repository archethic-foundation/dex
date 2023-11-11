// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pool_infos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPoolInfosResponseImpl _$$GetPoolInfosResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPoolInfosResponseImpl(
      token1: Token.fromJson(json['token1'] as Map<String, dynamic>),
      token2: Token.fromJson(json['token2'] as Map<String, dynamic>),
      lpToken: LPToken.fromJson(json['lp_token'] as Map<String, dynamic>),
      fee: (json['fee'] as num).toDouble(),
    );

Map<String, dynamic> _$$GetPoolInfosResponseImplToJson(
        _$GetPoolInfosResponseImpl instance) =>
    <String, dynamic>{
      'token1': instance.token1,
      'token2': instance.token2,
      'lp_token': instance.lpToken,
      'fee': instance.fee,
    };

_$TokenImpl _$$TokenImplFromJson(Map<String, dynamic> json) => _$TokenImpl(
      address: json['address'] as String,
      reserve: (json['reserve'] as num).toDouble(),
    );

Map<String, dynamic> _$$TokenImplToJson(_$TokenImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'reserve': instance.reserve,
    };

_$LPTokenImpl _$$LPTokenImplFromJson(Map<String, dynamic> json) =>
    _$LPTokenImpl(
      address: json['address'] as String,
      supply: (json['supply'] as num).toDouble(),
    );

Map<String, dynamic> _$$LPTokenImplToJson(_$LPTokenImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'supply': instance.supply,
    };
