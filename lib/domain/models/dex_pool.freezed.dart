// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DexPool {
  String get poolAddress => throw _privateConstructorUsedError;
  DexToken? get lpToken => throw _privateConstructorUsedError;
  int get ranking => throw _privateConstructorUsedError;
  DexPair? get pair => throw _privateConstructorUsedError;
  double get fees => throw _privateConstructorUsedError;
  double get ratioToken1Token2 => throw _privateConstructorUsedError;
  double get ratioToken2Token1 => throw _privateConstructorUsedError;
  double get estimatePoolTVLInFiat => throw _privateConstructorUsedError;
  bool get lpTokenInUserBalance => throw _privateConstructorUsedError;
  double get token1TotalFee => throw _privateConstructorUsedError;
  int get token1TotalVolume => throw _privateConstructorUsedError;
  double get token2TotalFee => throw _privateConstructorUsedError;
  int get token2TotalVolume => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexPoolCopyWith<DexPool> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPoolCopyWith<$Res> {
  factory $DexPoolCopyWith(DexPool value, $Res Function(DexPool) then) =
      _$DexPoolCopyWithImpl<$Res, DexPool>;
  @useResult
  $Res call(
      {String poolAddress,
      DexToken? lpToken,
      int ranking,
      DexPair? pair,
      double fees,
      double ratioToken1Token2,
      double ratioToken2Token1,
      double estimatePoolTVLInFiat,
      bool lpTokenInUserBalance,
      double token1TotalFee,
      int token1TotalVolume,
      double token2TotalFee,
      int token2TotalVolume});

  $DexTokenCopyWith<$Res>? get lpToken;
  $DexPairCopyWith<$Res>? get pair;
}

/// @nodoc
class _$DexPoolCopyWithImpl<$Res, $Val extends DexPool>
    implements $DexPoolCopyWith<$Res> {
  _$DexPoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? lpToken = freezed,
    Object? ranking = null,
    Object? pair = freezed,
    Object? fees = null,
    Object? ratioToken1Token2 = null,
    Object? ratioToken2Token1 = null,
    Object? estimatePoolTVLInFiat = null,
    Object? lpTokenInUserBalance = null,
    Object? token1TotalFee = null,
    Object? token1TotalVolume = null,
    Object? token2TotalFee = null,
    Object? token2TotalVolume = null,
  }) {
    return _then(_value.copyWith(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      pair: freezed == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken1Token2: null == ratioToken1Token2
          ? _value.ratioToken1Token2
          : ratioToken1Token2 // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken2Token1: null == ratioToken2Token1
          ? _value.ratioToken2Token1
          : ratioToken2Token1 // ignore: cast_nullable_to_non_nullable
              as double,
      estimatePoolTVLInFiat: null == estimatePoolTVLInFiat
          ? _value.estimatePoolTVLInFiat
          : estimatePoolTVLInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenInUserBalance: null == lpTokenInUserBalance
          ? _value.lpTokenInUserBalance
          : lpTokenInUserBalance // ignore: cast_nullable_to_non_nullable
              as bool,
      token1TotalFee: null == token1TotalFee
          ? _value.token1TotalFee
          : token1TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume: null == token1TotalVolume
          ? _value.token1TotalVolume
          : token1TotalVolume // ignore: cast_nullable_to_non_nullable
              as int,
      token2TotalFee: null == token2TotalFee
          ? _value.token2TotalFee
          : token2TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume: null == token2TotalVolume
          ? _value.token2TotalVolume
          : token2TotalVolume // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get lpToken {
    if (_value.lpToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.lpToken!, (value) {
      return _then(_value.copyWith(lpToken: value) as $Val);
    });
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
abstract class _$$DexPoolImplCopyWith<$Res> implements $DexPoolCopyWith<$Res> {
  factory _$$DexPoolImplCopyWith(
          _$DexPoolImpl value, $Res Function(_$DexPoolImpl) then) =
      __$$DexPoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String poolAddress,
      DexToken? lpToken,
      int ranking,
      DexPair? pair,
      double fees,
      double ratioToken1Token2,
      double ratioToken2Token1,
      double estimatePoolTVLInFiat,
      bool lpTokenInUserBalance,
      double token1TotalFee,
      int token1TotalVolume,
      double token2TotalFee,
      int token2TotalVolume});

  @override
  $DexTokenCopyWith<$Res>? get lpToken;
  @override
  $DexPairCopyWith<$Res>? get pair;
}

/// @nodoc
class __$$DexPoolImplCopyWithImpl<$Res>
    extends _$DexPoolCopyWithImpl<$Res, _$DexPoolImpl>
    implements _$$DexPoolImplCopyWith<$Res> {
  __$$DexPoolImplCopyWithImpl(
      _$DexPoolImpl _value, $Res Function(_$DexPoolImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? lpToken = freezed,
    Object? ranking = null,
    Object? pair = freezed,
    Object? fees = null,
    Object? ratioToken1Token2 = null,
    Object? ratioToken2Token1 = null,
    Object? estimatePoolTVLInFiat = null,
    Object? lpTokenInUserBalance = null,
    Object? token1TotalFee = null,
    Object? token1TotalVolume = null,
    Object? token2TotalFee = null,
    Object? token2TotalVolume = null,
  }) {
    return _then(_$DexPoolImpl(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      pair: freezed == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken1Token2: null == ratioToken1Token2
          ? _value.ratioToken1Token2
          : ratioToken1Token2 // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken2Token1: null == ratioToken2Token1
          ? _value.ratioToken2Token1
          : ratioToken2Token1 // ignore: cast_nullable_to_non_nullable
              as double,
      estimatePoolTVLInFiat: null == estimatePoolTVLInFiat
          ? _value.estimatePoolTVLInFiat
          : estimatePoolTVLInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenInUserBalance: null == lpTokenInUserBalance
          ? _value.lpTokenInUserBalance
          : lpTokenInUserBalance // ignore: cast_nullable_to_non_nullable
              as bool,
      token1TotalFee: null == token1TotalFee
          ? _value.token1TotalFee
          : token1TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume: null == token1TotalVolume
          ? _value.token1TotalVolume
          : token1TotalVolume // ignore: cast_nullable_to_non_nullable
              as int,
      token2TotalFee: null == token2TotalFee
          ? _value.token2TotalFee
          : token2TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume: null == token2TotalVolume
          ? _value.token2TotalVolume
          : token2TotalVolume // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DexPoolImpl extends _DexPool {
  const _$DexPoolImpl(
      {this.poolAddress = '',
      this.lpToken,
      this.ranking = 0,
      this.pair,
      this.fees = 0.0,
      this.ratioToken1Token2 = 0.0,
      this.ratioToken2Token1 = 0.0,
      this.estimatePoolTVLInFiat = 0.0,
      this.lpTokenInUserBalance = false,
      this.token1TotalFee = 0.0,
      this.token1TotalVolume = 0,
      this.token2TotalFee = 0.0,
      this.token2TotalVolume = 0})
      : super._();

  @override
  @JsonKey()
  final String poolAddress;
  @override
  final DexToken? lpToken;
  @override
  @JsonKey()
  final int ranking;
  @override
  final DexPair? pair;
  @override
  @JsonKey()
  final double fees;
  @override
  @JsonKey()
  final double ratioToken1Token2;
  @override
  @JsonKey()
  final double ratioToken2Token1;
  @override
  @JsonKey()
  final double estimatePoolTVLInFiat;
  @override
  @JsonKey()
  final bool lpTokenInUserBalance;
  @override
  @JsonKey()
  final double token1TotalFee;
  @override
  @JsonKey()
  final int token1TotalVolume;
  @override
  @JsonKey()
  final double token2TotalFee;
  @override
  @JsonKey()
  final int token2TotalVolume;

  @override
  String toString() {
    return 'DexPool(poolAddress: $poolAddress, lpToken: $lpToken, ranking: $ranking, pair: $pair, fees: $fees, ratioToken1Token2: $ratioToken1Token2, ratioToken2Token1: $ratioToken2Token1, estimatePoolTVLInFiat: $estimatePoolTVLInFiat, lpTokenInUserBalance: $lpTokenInUserBalance, token1TotalFee: $token1TotalFee, token1TotalVolume: $token1TotalVolume, token2TotalFee: $token2TotalFee, token2TotalVolume: $token2TotalVolume)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolImpl &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.ranking, ranking) || other.ranking == ranking) &&
            (identical(other.pair, pair) || other.pair == pair) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.ratioToken1Token2, ratioToken1Token2) ||
                other.ratioToken1Token2 == ratioToken1Token2) &&
            (identical(other.ratioToken2Token1, ratioToken2Token1) ||
                other.ratioToken2Token1 == ratioToken2Token1) &&
            (identical(other.estimatePoolTVLInFiat, estimatePoolTVLInFiat) ||
                other.estimatePoolTVLInFiat == estimatePoolTVLInFiat) &&
            (identical(other.lpTokenInUserBalance, lpTokenInUserBalance) ||
                other.lpTokenInUserBalance == lpTokenInUserBalance) &&
            (identical(other.token1TotalFee, token1TotalFee) ||
                other.token1TotalFee == token1TotalFee) &&
            (identical(other.token1TotalVolume, token1TotalVolume) ||
                other.token1TotalVolume == token1TotalVolume) &&
            (identical(other.token2TotalFee, token2TotalFee) ||
                other.token2TotalFee == token2TotalFee) &&
            (identical(other.token2TotalVolume, token2TotalVolume) ||
                other.token2TotalVolume == token2TotalVolume));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      poolAddress,
      lpToken,
      ranking,
      pair,
      fees,
      ratioToken1Token2,
      ratioToken2Token1,
      estimatePoolTVLInFiat,
      lpTokenInUserBalance,
      token1TotalFee,
      token1TotalVolume,
      token2TotalFee,
      token2TotalVolume);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      __$$DexPoolImplCopyWithImpl<_$DexPoolImpl>(this, _$identity);
}

abstract class _DexPool extends DexPool {
  const factory _DexPool(
      {final String poolAddress,
      final DexToken? lpToken,
      final int ranking,
      final DexPair? pair,
      final double fees,
      final double ratioToken1Token2,
      final double ratioToken2Token1,
      final double estimatePoolTVLInFiat,
      final bool lpTokenInUserBalance,
      final double token1TotalFee,
      final int token1TotalVolume,
      final double token2TotalFee,
      final int token2TotalVolume}) = _$DexPoolImpl;
  const _DexPool._() : super._();

  @override
  String get poolAddress;
  @override
  DexToken? get lpToken;
  @override
  int get ranking;
  @override
  DexPair? get pair;
  @override
  double get fees;
  @override
  double get ratioToken1Token2;
  @override
  double get ratioToken2Token1;
  @override
  double get estimatePoolTVLInFiat;
  @override
  bool get lpTokenInUserBalance;
  @override
  double get token1TotalFee;
  @override
  int get token1TotalVolume;
  @override
  double get token2TotalFee;
  @override
  int get token2TotalVolume;
  @override
  @JsonKey(ignore: true)
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
