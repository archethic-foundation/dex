// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool_tx.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexPoolTxImpl _$$DexPoolTxImplFromJson(Map<String, dynamic> json) =>
    _$DexPoolTxImpl(
      addressTx: json['addressTx'] as String?,
      typeTx: $enumDecodeNullable(_$DexActionTypeEnumMap, json['typeTx']),
      pair: json['pair'] == null
          ? null
          : DexPair.fromJson(json['pair'] as Map<String, dynamic>),
      totalValue: (json['totalValue'] as num?)?.toDouble(),
      token1Amount: (json['token1Amount'] as num?)?.toDouble(),
      token2Amount: (json['token2Amount'] as num?)?.toDouble(),
      addressAccount: json['addressAccount'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$DexPoolTxImplToJson(_$DexPoolTxImpl instance) =>
    <String, dynamic>{
      'addressTx': instance.addressTx,
      'typeTx': _$DexActionTypeEnumMap[instance.typeTx],
      'pair': instance.pair,
      'totalValue': instance.totalValue,
      'token1Amount': instance.token1Amount,
      'token2Amount': instance.token2Amount,
      'addressAccount': instance.addressAccount,
      'time': instance.time?.toIso8601String(),
    };

const _$DexActionTypeEnumMap = {
  DexActionType.swap: 'swap',
  DexActionType.addLiquidity: 'addLiquidity',
  DexActionType.removeLiquidity: 'removeLiquidity',
  DexActionType.claimFarm: 'claimFarm',
  DexActionType.depositFarm: 'depositFarm',
  DexActionType.withdrawFarm: 'withdrawFarm',
  DexActionType.addPool: 'addPool',
};
