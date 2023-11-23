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
  double get ratio => throw _privateConstructorUsedError;

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
      double ratio});

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
    Object? ratio = null,
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
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
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
      double ratio});

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
    Object? ratio = null,
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
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DexPoolImpl implements _DexPool {
  const _$DexPoolImpl(
      {this.poolAddress = '',
      this.lpToken,
      this.ranking = 0,
      this.pair,
      this.fees = 0.0,
      this.ratio = 0.0});

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
  final double ratio;

  @override
  String toString() {
    return 'DexPool(poolAddress: $poolAddress, lpToken: $lpToken, ranking: $ranking, pair: $pair, fees: $fees, ratio: $ratio)';
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
            (identical(other.ratio, ratio) || other.ratio == ratio));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, poolAddress, lpToken, ranking, pair, fees, ratio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      __$$DexPoolImplCopyWithImpl<_$DexPoolImpl>(this, _$identity);
}

abstract class _DexPool implements DexPool {
  const factory _DexPool(
      {final String poolAddress,
      final DexToken? lpToken,
      final int ranking,
      final DexPair? pair,
      final double fees,
      final double ratio}) = _$DexPoolImpl;

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
  double get ratio;
  @override
  @JsonKey(ignore: true)
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
