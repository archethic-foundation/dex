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
  DexToken get lpToken => throw _privateConstructorUsedError;
  DexPair get pair => throw _privateConstructorUsedError;
  bool get lpTokenInUserBalance => throw _privateConstructorUsedError;
  DexPoolInfos? get infos => throw _privateConstructorUsedError;

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
      DexToken lpToken,
      DexPair pair,
      bool lpTokenInUserBalance,
      DexPoolInfos? infos});

  $DexTokenCopyWith<$Res> get lpToken;
  $DexPairCopyWith<$Res> get pair;
  $DexPoolInfosCopyWith<$Res>? get infos;
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
    Object? lpToken = null,
    Object? pair = null,
    Object? lpTokenInUserBalance = null,
    Object? infos = freezed,
  }) {
    return _then(_value.copyWith(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: null == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken,
      pair: null == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair,
      lpTokenInUserBalance: null == lpTokenInUserBalance
          ? _value.lpTokenInUserBalance
          : lpTokenInUserBalance // ignore: cast_nullable_to_non_nullable
              as bool,
      infos: freezed == infos
          ? _value.infos
          : infos // ignore: cast_nullable_to_non_nullable
              as DexPoolInfos?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res> get lpToken {
    return $DexTokenCopyWith<$Res>(_value.lpToken, (value) {
      return _then(_value.copyWith(lpToken: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexPairCopyWith<$Res> get pair {
    return $DexPairCopyWith<$Res>(_value.pair, (value) {
      return _then(_value.copyWith(pair: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexPoolInfosCopyWith<$Res>? get infos {
    if (_value.infos == null) {
      return null;
    }

    return $DexPoolInfosCopyWith<$Res>(_value.infos!, (value) {
      return _then(_value.copyWith(infos: value) as $Val);
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
      DexToken lpToken,
      DexPair pair,
      bool lpTokenInUserBalance,
      DexPoolInfos? infos});

  @override
  $DexTokenCopyWith<$Res> get lpToken;
  @override
  $DexPairCopyWith<$Res> get pair;
  @override
  $DexPoolInfosCopyWith<$Res>? get infos;
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
    Object? lpToken = null,
    Object? pair = null,
    Object? lpTokenInUserBalance = null,
    Object? infos = freezed,
  }) {
    return _then(_$DexPoolImpl(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: null == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken,
      pair: null == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair,
      lpTokenInUserBalance: null == lpTokenInUserBalance
          ? _value.lpTokenInUserBalance
          : lpTokenInUserBalance // ignore: cast_nullable_to_non_nullable
              as bool,
      infos: freezed == infos
          ? _value.infos
          : infos // ignore: cast_nullable_to_non_nullable
              as DexPoolInfos?,
    ));
  }
}

/// @nodoc

class _$DexPoolImpl extends _DexPool {
  const _$DexPoolImpl(
      {required this.poolAddress,
      required this.lpToken,
      required this.pair,
      required this.lpTokenInUserBalance,
      this.infos})
      : super._();

  @override
  final String poolAddress;
  @override
  final DexToken lpToken;
  @override
  final DexPair pair;
  @override
  final bool lpTokenInUserBalance;
  @override
  final DexPoolInfos? infos;

  @override
  String toString() {
    return 'DexPool(poolAddress: $poolAddress, lpToken: $lpToken, pair: $pair, lpTokenInUserBalance: $lpTokenInUserBalance, infos: $infos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolImpl &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.pair, pair) || other.pair == pair) &&
            (identical(other.lpTokenInUserBalance, lpTokenInUserBalance) ||
                other.lpTokenInUserBalance == lpTokenInUserBalance) &&
            (identical(other.infos, infos) || other.infos == infos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, poolAddress, lpToken, pair, lpTokenInUserBalance, infos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      __$$DexPoolImplCopyWithImpl<_$DexPoolImpl>(this, _$identity);
}

abstract class _DexPool extends DexPool {
  const factory _DexPool(
      {required final String poolAddress,
      required final DexToken lpToken,
      required final DexPair pair,
      required final bool lpTokenInUserBalance,
      final DexPoolInfos? infos}) = _$DexPoolImpl;
  const _DexPool._() : super._();

  @override
  String get poolAddress;
  @override
  DexToken get lpToken;
  @override
  DexPair get pair;
  @override
  bool get lpTokenInUserBalance;
  @override
  DexPoolInfos? get infos;
  @override
  @JsonKey(ignore: true)
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DexPoolInfos {
// required int ranking, // TODO activate and use this
  double get fees => throw _privateConstructorUsedError;
  double get ratioToken1Token2 => throw _privateConstructorUsedError;
  double get ratioToken2Token1 =>
      throw _privateConstructorUsedError; // required double estimatePoolTVLInFiat,
  double get token1TotalFee => throw _privateConstructorUsedError;
  double get token1TotalVolume => throw _privateConstructorUsedError;
  double get token2TotalFee => throw _privateConstructorUsedError;
  double get token2TotalVolume => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexPoolInfosCopyWith<DexPoolInfos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPoolInfosCopyWith<$Res> {
  factory $DexPoolInfosCopyWith(
          DexPoolInfos value, $Res Function(DexPoolInfos) then) =
      _$DexPoolInfosCopyWithImpl<$Res, DexPoolInfos>;
  @useResult
  $Res call(
      {double fees,
      double ratioToken1Token2,
      double ratioToken2Token1,
      double token1TotalFee,
      double token1TotalVolume,
      double token2TotalFee,
      double token2TotalVolume});
}

/// @nodoc
class _$DexPoolInfosCopyWithImpl<$Res, $Val extends DexPoolInfos>
    implements $DexPoolInfosCopyWith<$Res> {
  _$DexPoolInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fees = null,
    Object? ratioToken1Token2 = null,
    Object? ratioToken2Token1 = null,
    Object? token1TotalFee = null,
    Object? token1TotalVolume = null,
    Object? token2TotalFee = null,
    Object? token2TotalVolume = null,
  }) {
    return _then(_value.copyWith(
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
      token1TotalFee: null == token1TotalFee
          ? _value.token1TotalFee
          : token1TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume: null == token1TotalVolume
          ? _value.token1TotalVolume
          : token1TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalFee: null == token2TotalFee
          ? _value.token2TotalFee
          : token2TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume: null == token2TotalVolume
          ? _value.token2TotalVolume
          : token2TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexPoolInfosImplCopyWith<$Res>
    implements $DexPoolInfosCopyWith<$Res> {
  factory _$$DexPoolInfosImplCopyWith(
          _$DexPoolInfosImpl value, $Res Function(_$DexPoolInfosImpl) then) =
      __$$DexPoolInfosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double fees,
      double ratioToken1Token2,
      double ratioToken2Token1,
      double token1TotalFee,
      double token1TotalVolume,
      double token2TotalFee,
      double token2TotalVolume});
}

/// @nodoc
class __$$DexPoolInfosImplCopyWithImpl<$Res>
    extends _$DexPoolInfosCopyWithImpl<$Res, _$DexPoolInfosImpl>
    implements _$$DexPoolInfosImplCopyWith<$Res> {
  __$$DexPoolInfosImplCopyWithImpl(
      _$DexPoolInfosImpl _value, $Res Function(_$DexPoolInfosImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fees = null,
    Object? ratioToken1Token2 = null,
    Object? ratioToken2Token1 = null,
    Object? token1TotalFee = null,
    Object? token1TotalVolume = null,
    Object? token2TotalFee = null,
    Object? token2TotalVolume = null,
  }) {
    return _then(_$DexPoolInfosImpl(
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
      token1TotalFee: null == token1TotalFee
          ? _value.token1TotalFee
          : token1TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume: null == token1TotalVolume
          ? _value.token1TotalVolume
          : token1TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalFee: null == token2TotalFee
          ? _value.token2TotalFee
          : token2TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume: null == token2TotalVolume
          ? _value.token2TotalVolume
          : token2TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DexPoolInfosImpl extends _DexPoolInfos {
  const _$DexPoolInfosImpl(
      {required this.fees,
      required this.ratioToken1Token2,
      required this.ratioToken2Token1,
      required this.token1TotalFee,
      required this.token1TotalVolume,
      required this.token2TotalFee,
      required this.token2TotalVolume})
      : super._();

// required int ranking, // TODO activate and use this
  @override
  final double fees;
  @override
  final double ratioToken1Token2;
  @override
  final double ratioToken2Token1;
// required double estimatePoolTVLInFiat,
  @override
  final double token1TotalFee;
  @override
  final double token1TotalVolume;
  @override
  final double token2TotalFee;
  @override
  final double token2TotalVolume;

  @override
  String toString() {
    return 'DexPoolInfos(fees: $fees, ratioToken1Token2: $ratioToken1Token2, ratioToken2Token1: $ratioToken2Token1, token1TotalFee: $token1TotalFee, token1TotalVolume: $token1TotalVolume, token2TotalFee: $token2TotalFee, token2TotalVolume: $token2TotalVolume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolInfosImpl &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.ratioToken1Token2, ratioToken1Token2) ||
                other.ratioToken1Token2 == ratioToken1Token2) &&
            (identical(other.ratioToken2Token1, ratioToken2Token1) ||
                other.ratioToken2Token1 == ratioToken2Token1) &&
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
      fees,
      ratioToken1Token2,
      ratioToken2Token1,
      token1TotalFee,
      token1TotalVolume,
      token2TotalFee,
      token2TotalVolume);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolInfosImplCopyWith<_$DexPoolInfosImpl> get copyWith =>
      __$$DexPoolInfosImplCopyWithImpl<_$DexPoolInfosImpl>(this, _$identity);
}

abstract class _DexPoolInfos extends DexPoolInfos {
  const factory _DexPoolInfos(
      {required final double fees,
      required final double ratioToken1Token2,
      required final double ratioToken2Token1,
      required final double token1TotalFee,
      required final double token1TotalVolume,
      required final double token2TotalFee,
      required final double token2TotalVolume}) = _$DexPoolInfosImpl;
  const _DexPoolInfos._() : super._();

  @override // required int ranking, // TODO activate and use this
  double get fees;
  @override
  double get ratioToken1Token2;
  @override
  double get ratioToken2Token1;
  @override // required double estimatePoolTVLInFiat,
  double get token1TotalFee;
  @override
  double get token1TotalVolume;
  @override
  double get token2TotalFee;
  @override
  double get token2TotalVolume;
  @override
  @JsonKey(ignore: true)
  _$$DexPoolInfosImplCopyWith<_$DexPoolInfosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
