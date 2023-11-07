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
  String get lpTokenAddress => throw _privateConstructorUsedError;
  int get ranking => throw _privateConstructorUsedError;
  DexPair? get pair => throw _privateConstructorUsedError;
  double get token1Pooled => throw _privateConstructorUsedError;
  double get token2Pooled => throw _privateConstructorUsedError;
  double get amountOfLiquidity => throw _privateConstructorUsedError;
  double get apr => throw _privateConstructorUsedError;
  double get volume24h => throw _privateConstructorUsedError;
  double get volume7d => throw _privateConstructorUsedError;
  double get fees24h => throw _privateConstructorUsedError;

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
      String lpTokenAddress,
      int ranking,
      DexPair? pair,
      double token1Pooled,
      double token2Pooled,
      double amountOfLiquidity,
      double apr,
      double volume24h,
      double volume7d,
      double fees24h});

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
    Object? lpTokenAddress = null,
    Object? ranking = null,
    Object? pair = freezed,
    Object? token1Pooled = null,
    Object? token2Pooled = null,
    Object? amountOfLiquidity = null,
    Object? apr = null,
    Object? volume24h = null,
    Object? volume7d = null,
    Object? fees24h = null,
  }) {
    return _then(_value.copyWith(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      pair: freezed == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      token1Pooled: null == token1Pooled
          ? _value.token1Pooled
          : token1Pooled // ignore: cast_nullable_to_non_nullable
              as double,
      token2Pooled: null == token2Pooled
          ? _value.token2Pooled
          : token2Pooled // ignore: cast_nullable_to_non_nullable
              as double,
      amountOfLiquidity: null == amountOfLiquidity
          ? _value.amountOfLiquidity
          : amountOfLiquidity // ignore: cast_nullable_to_non_nullable
              as double,
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      volume7d: null == volume7d
          ? _value.volume7d
          : volume7d // ignore: cast_nullable_to_non_nullable
              as double,
      fees24h: null == fees24h
          ? _value.fees24h
          : fees24h // ignore: cast_nullable_to_non_nullable
              as double,
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
abstract class _$$DexPoolImplCopyWith<$Res> implements $DexPoolCopyWith<$Res> {
  factory _$$DexPoolImplCopyWith(
          _$DexPoolImpl value, $Res Function(_$DexPoolImpl) then) =
      __$$DexPoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String poolAddress,
      String lpTokenAddress,
      int ranking,
      DexPair? pair,
      double token1Pooled,
      double token2Pooled,
      double amountOfLiquidity,
      double apr,
      double volume24h,
      double volume7d,
      double fees24h});

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
    Object? lpTokenAddress = null,
    Object? ranking = null,
    Object? pair = freezed,
    Object? token1Pooled = null,
    Object? token2Pooled = null,
    Object? amountOfLiquidity = null,
    Object? apr = null,
    Object? volume24h = null,
    Object? volume7d = null,
    Object? fees24h = null,
  }) {
    return _then(_$DexPoolImpl(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      pair: freezed == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      token1Pooled: null == token1Pooled
          ? _value.token1Pooled
          : token1Pooled // ignore: cast_nullable_to_non_nullable
              as double,
      token2Pooled: null == token2Pooled
          ? _value.token2Pooled
          : token2Pooled // ignore: cast_nullable_to_non_nullable
              as double,
      amountOfLiquidity: null == amountOfLiquidity
          ? _value.amountOfLiquidity
          : amountOfLiquidity // ignore: cast_nullable_to_non_nullable
              as double,
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      volume7d: null == volume7d
          ? _value.volume7d
          : volume7d // ignore: cast_nullable_to_non_nullable
              as double,
      fees24h: null == fees24h
          ? _value.fees24h
          : fees24h // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DexPoolImpl implements _DexPool {
  const _$DexPoolImpl(
      {this.poolAddress = '',
      this.lpTokenAddress = '',
      this.ranking = 0,
      this.pair,
      this.token1Pooled = 0.0,
      this.token2Pooled = 0.0,
      this.amountOfLiquidity = 0.0,
      this.apr = 0.0,
      this.volume24h = 0.0,
      this.volume7d = 0.0,
      this.fees24h = 0.0});

  @override
  @JsonKey()
  final String poolAddress;
  @override
  @JsonKey()
  final String lpTokenAddress;
  @override
  @JsonKey()
  final int ranking;
  @override
  final DexPair? pair;
  @override
  @JsonKey()
  final double token1Pooled;
  @override
  @JsonKey()
  final double token2Pooled;
  @override
  @JsonKey()
  final double amountOfLiquidity;
  @override
  @JsonKey()
  final double apr;
  @override
  @JsonKey()
  final double volume24h;
  @override
  @JsonKey()
  final double volume7d;
  @override
  @JsonKey()
  final double fees24h;

  @override
  String toString() {
    return 'DexPool(poolAddress: $poolAddress, lpTokenAddress: $lpTokenAddress, ranking: $ranking, pair: $pair, token1Pooled: $token1Pooled, token2Pooled: $token2Pooled, amountOfLiquidity: $amountOfLiquidity, apr: $apr, volume24h: $volume24h, volume7d: $volume7d, fees24h: $fees24h)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolImpl &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress) &&
            (identical(other.ranking, ranking) || other.ranking == ranking) &&
            (identical(other.pair, pair) || other.pair == pair) &&
            (identical(other.token1Pooled, token1Pooled) ||
                other.token1Pooled == token1Pooled) &&
            (identical(other.token2Pooled, token2Pooled) ||
                other.token2Pooled == token2Pooled) &&
            (identical(other.amountOfLiquidity, amountOfLiquidity) ||
                other.amountOfLiquidity == amountOfLiquidity) &&
            (identical(other.apr, apr) || other.apr == apr) &&
            (identical(other.volume24h, volume24h) ||
                other.volume24h == volume24h) &&
            (identical(other.volume7d, volume7d) ||
                other.volume7d == volume7d) &&
            (identical(other.fees24h, fees24h) || other.fees24h == fees24h));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      poolAddress,
      lpTokenAddress,
      ranking,
      pair,
      token1Pooled,
      token2Pooled,
      amountOfLiquidity,
      apr,
      volume24h,
      volume7d,
      fees24h);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      __$$DexPoolImplCopyWithImpl<_$DexPoolImpl>(this, _$identity);
}

abstract class _DexPool implements DexPool {
  const factory _DexPool(
      {final String poolAddress,
      final String lpTokenAddress,
      final int ranking,
      final DexPair? pair,
      final double token1Pooled,
      final double token2Pooled,
      final double amountOfLiquidity,
      final double apr,
      final double volume24h,
      final double volume7d,
      final double fees24h}) = _$DexPoolImpl;

  @override
  String get poolAddress;
  @override
  String get lpTokenAddress;
  @override
  int get ranking;
  @override
  DexPair? get pair;
  @override
  double get token1Pooled;
  @override
  double get token2Pooled;
  @override
  double get amountOfLiquidity;
  @override
  double get apr;
  @override
  double get volume24h;
  @override
  double get volume7d;
  @override
  double get fees24h;
  @override
  @JsonKey(ignore: true)
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
