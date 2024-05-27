// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_pool_tx.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexPoolTx _$DexPoolTxFromJson(Map<String, dynamic> json) {
  return _DexPoolTx.fromJson(json);
}

/// @nodoc
mixin _$DexPoolTx {
  String? get addressTx => throw _privateConstructorUsedError;
  DexActionType? get typeTx => throw _privateConstructorUsedError;
  DexPair? get pair => throw _privateConstructorUsedError;
  double? get totalValue => throw _privateConstructorUsedError;
  double? get token1Amount => throw _privateConstructorUsedError;
  double? get token2Amount => throw _privateConstructorUsedError;
  String? get addressAccount => throw _privateConstructorUsedError;
  DateTime? get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DexPoolTxCopyWith<DexPoolTx> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPoolTxCopyWith<$Res> {
  factory $DexPoolTxCopyWith(DexPoolTx value, $Res Function(DexPoolTx) then) =
      _$DexPoolTxCopyWithImpl<$Res, DexPoolTx>;
  @useResult
  $Res call(
      {String? addressTx,
      DexActionType? typeTx,
      DexPair? pair,
      double? totalValue,
      double? token1Amount,
      double? token2Amount,
      String? addressAccount,
      DateTime? time});

  $DexPairCopyWith<$Res>? get pair;
}

/// @nodoc
class _$DexPoolTxCopyWithImpl<$Res, $Val extends DexPoolTx>
    implements $DexPoolTxCopyWith<$Res> {
  _$DexPoolTxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressTx = freezed,
    Object? typeTx = freezed,
    Object? pair = freezed,
    Object? totalValue = freezed,
    Object? token1Amount = freezed,
    Object? token2Amount = freezed,
    Object? addressAccount = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      addressTx: freezed == addressTx
          ? _value.addressTx
          : addressTx // ignore: cast_nullable_to_non_nullable
              as String?,
      typeTx: freezed == typeTx
          ? _value.typeTx
          : typeTx // ignore: cast_nullable_to_non_nullable
              as DexActionType?,
      pair: freezed == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double?,
      token1Amount: freezed == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double?,
      token2Amount: freezed == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double?,
      addressAccount: freezed == addressAccount
          ? _value.addressAccount
          : addressAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexPairCopyWith<$Res>? get pair {
    if (_value.pair == null) {
      return null;
    }

    return $DexPairCopyWith<$Res>(_value.pair!, (value) {
      return _then(_value.copyWith(pair: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DexPoolTxImplCopyWith<$Res>
    implements $DexPoolTxCopyWith<$Res> {
  factory _$$DexPoolTxImplCopyWith(
          _$DexPoolTxImpl value, $Res Function(_$DexPoolTxImpl) then) =
      __$$DexPoolTxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? addressTx,
      DexActionType? typeTx,
      DexPair? pair,
      double? totalValue,
      double? token1Amount,
      double? token2Amount,
      String? addressAccount,
      DateTime? time});

  @override
  $DexPairCopyWith<$Res>? get pair;
}

/// @nodoc
class __$$DexPoolTxImplCopyWithImpl<$Res>
    extends _$DexPoolTxCopyWithImpl<$Res, _$DexPoolTxImpl>
    implements _$$DexPoolTxImplCopyWith<$Res> {
  __$$DexPoolTxImplCopyWithImpl(
      _$DexPoolTxImpl _value, $Res Function(_$DexPoolTxImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressTx = freezed,
    Object? typeTx = freezed,
    Object? pair = freezed,
    Object? totalValue = freezed,
    Object? token1Amount = freezed,
    Object? token2Amount = freezed,
    Object? addressAccount = freezed,
    Object? time = freezed,
  }) {
    return _then(_$DexPoolTxImpl(
      addressTx: freezed == addressTx
          ? _value.addressTx
          : addressTx // ignore: cast_nullable_to_non_nullable
              as String?,
      typeTx: freezed == typeTx
          ? _value.typeTx
          : typeTx // ignore: cast_nullable_to_non_nullable
              as DexActionType?,
      pair: freezed == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double?,
      token1Amount: freezed == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double?,
      token2Amount: freezed == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double?,
      addressAccount: freezed == addressAccount
          ? _value.addressAccount
          : addressAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexPoolTxImpl extends _DexPoolTx {
  const _$DexPoolTxImpl(
      {this.addressTx,
      this.typeTx,
      this.pair,
      this.totalValue,
      this.token1Amount,
      this.token2Amount,
      this.addressAccount,
      this.time})
      : super._();

  factory _$DexPoolTxImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexPoolTxImplFromJson(json);

  @override
  final String? addressTx;
  @override
  final DexActionType? typeTx;
  @override
  final DexPair? pair;
  @override
  final double? totalValue;
  @override
  final double? token1Amount;
  @override
  final double? token2Amount;
  @override
  final String? addressAccount;
  @override
  final DateTime? time;

  @override
  String toString() {
    return 'DexPoolTx(addressTx: $addressTx, typeTx: $typeTx, pair: $pair, totalValue: $totalValue, token1Amount: $token1Amount, token2Amount: $token2Amount, addressAccount: $addressAccount, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolTxImpl &&
            (identical(other.addressTx, addressTx) ||
                other.addressTx == addressTx) &&
            (identical(other.typeTx, typeTx) || other.typeTx == typeTx) &&
            (identical(other.pair, pair) || other.pair == pair) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.token1Amount, token1Amount) ||
                other.token1Amount == token1Amount) &&
            (identical(other.token2Amount, token2Amount) ||
                other.token2Amount == token2Amount) &&
            (identical(other.addressAccount, addressAccount) ||
                other.addressAccount == addressAccount) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, addressTx, typeTx, pair,
      totalValue, token1Amount, token2Amount, addressAccount, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolTxImplCopyWith<_$DexPoolTxImpl> get copyWith =>
      __$$DexPoolTxImplCopyWithImpl<_$DexPoolTxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexPoolTxImplToJson(
      this,
    );
  }
}

abstract class _DexPoolTx extends DexPoolTx {
  const factory _DexPoolTx(
      {final String? addressTx,
      final DexActionType? typeTx,
      final DexPair? pair,
      final double? totalValue,
      final double? token1Amount,
      final double? token2Amount,
      final String? addressAccount,
      final DateTime? time}) = _$DexPoolTxImpl;
  const _DexPoolTx._() : super._();

  factory _DexPoolTx.fromJson(Map<String, dynamic> json) =
      _$DexPoolTxImpl.fromJson;

  @override
  String? get addressTx;
  @override
  DexActionType? get typeTx;
  @override
  DexPair? get pair;
  @override
  double? get totalValue;
  @override
  double? get token1Amount;
  @override
  double? get token2Amount;
  @override
  String? get addressAccount;
  @override
  DateTime? get time;
  @override
  @JsonKey(ignore: true)
  _$$DexPoolTxImplCopyWith<_$DexPoolTxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
