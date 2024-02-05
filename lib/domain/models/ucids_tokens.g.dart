// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ucids_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UcidsTokensImpl _$$UcidsTokensImplFromJson(Map<String, dynamic> json) =>
    _$UcidsTokensImpl(
      mainnet: Map<String, int>.from(json['mainnet'] as Map),
      testnet: Map<String, int>.from(json['testnet'] as Map),
      devnet: Map<String, int>.from(json['devnet'] as Map),
    );

Map<String, dynamic> _$$UcidsTokensImplToJson(_$UcidsTokensImpl instance) =>
    <String, dynamic>{
      'mainnet': instance.mainnet,
      'testnet': instance.testnet,
      'devnet': instance.devnet,
    };
