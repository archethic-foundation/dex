// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CryptoPriceImpl _$$CryptoPriceImplFromJson(Map<String, dynamic> json) =>
    _$CryptoPriceImpl(
      timestamp: json['timestamp'] as int?,
      polygon: (json['polygon'] as num?)?.toDouble() ?? 0.0,
      ethereum: (json['ethereum'] as num?)?.toDouble() ?? 0.0,
      bsc: (json['bsc'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$CryptoPriceImplToJson(_$CryptoPriceImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'polygon': instance.polygon,
      'ethereum': instance.ethereum,
      'bsc': instance.bsc,
    };
