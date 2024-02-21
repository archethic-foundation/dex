// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexNotification _$DexNotificationFromJson(Map<String, dynamic> json) {
  return _DexNotification.fromJson(json);
}

/// @nodoc
mixin _$DexNotification {
  DexActionType? get actionType => throw _privateConstructorUsedError;
  String? get txAddress => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DexNotificationCopyWith<DexNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexNotificationCopyWith<$Res> {
  factory $DexNotificationCopyWith(
          DexNotification value, $Res Function(DexNotification) then) =
      _$DexNotificationCopyWithImpl<$Res, DexNotification>;
  @useResult
  $Res call(
      {DexActionType? actionType,
      String? txAddress,
      double? amount,
      DateTime? timestamp});
}

/// @nodoc
class _$DexNotificationCopyWithImpl<$Res, $Val extends DexNotification>
    implements $DexNotificationCopyWith<$Res> {
  _$DexNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = freezed,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      actionType: freezed == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType?,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexNotificationImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationImplCopyWith(_$DexNotificationImpl value,
          $Res Function(_$DexNotificationImpl) then) =
      __$$DexNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType? actionType,
      String? txAddress,
      double? amount,
      DateTime? timestamp});
}

/// @nodoc
class __$$DexNotificationImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res, _$DexNotificationImpl>
    implements _$$DexNotificationImplCopyWith<$Res> {
  __$$DexNotificationImplCopyWithImpl(
      _$DexNotificationImpl _value, $Res Function(_$DexNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = freezed,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$DexNotificationImpl(
      actionType: freezed == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType?,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexNotificationImpl extends _DexNotification {
  const _$DexNotificationImpl(
      {this.actionType, this.txAddress, this.amount, this.timestamp})
      : super._();

  factory _$DexNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexNotificationImplFromJson(json);

  @override
  final DexActionType? actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'DexNotification(actionType: $actionType, txAddress: $txAddress, amount: $amount, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, actionType, txAddress, amount, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationImplCopyWith<_$DexNotificationImpl> get copyWith =>
      __$$DexNotificationImplCopyWithImpl<_$DexNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexNotificationImplToJson(
      this,
    );
  }
}

abstract class _DexNotification extends DexNotification {
  const factory _DexNotification(
      {final DexActionType? actionType,
      final String? txAddress,
      final double? amount,
      final DateTime? timestamp}) = _$DexNotificationImpl;
  const _DexNotification._() : super._();

  factory _DexNotification.fromJson(Map<String, dynamic> json) =
      _$DexNotificationImpl.fromJson;

  @override
  DexActionType? get actionType;
  @override
  String? get txAddress;
  @override
  double? get amount;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationImplCopyWith<_$DexNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
