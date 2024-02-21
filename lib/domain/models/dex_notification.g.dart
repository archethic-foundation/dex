// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexNotificationImpl _$$DexNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$DexNotificationImpl(
      actionType:
          $enumDecodeNullable(_$DexActionTypeEnumMap, json['actionType']),
      txAddress: json['txAddress'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DexNotificationImplToJson(
        _$DexNotificationImpl instance) =>
    <String, dynamic>{
      'actionType': _$DexActionTypeEnumMap[instance.actionType],
      'txAddress': instance.txAddress,
      'amount': instance.amount,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

const _$DexActionTypeEnumMap = {
  DexActionType.swap: 'swap',
  DexActionType.addLiquidity: 'addLiquidity',
  DexActionType.removeLiquidity: 'removeLiquidity',
};
