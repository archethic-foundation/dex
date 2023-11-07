// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_blockchain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexBlockchainImpl _$$DexBlockchainImplFromJson(Map<String, dynamic> json) =>
    _$DexBlockchainImpl(
      name: json['name'] as String? ?? '',
      env: json['env'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      urlExplorerAddress: json['urlExplorerAddress'] as String? ?? '',
      urlExplorerTransaction: json['urlExplorerTransaction'] as String? ?? '',
      nativeCurrency: json['nativeCurrency'] as String? ?? '',
    );

Map<String, dynamic> _$$DexBlockchainImplToJson(_$DexBlockchainImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'env': instance.env,
      'icon': instance.icon,
      'urlExplorerAddress': instance.urlExplorerAddress,
      'urlExplorerTransaction': instance.urlExplorerTransaction,
      'nativeCurrency': instance.nativeCurrency,
    };
