// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PoolItemState {
  String get poolAddress => throw _privateConstructorUsedError;
  DexPool? get pool => throw _privateConstructorUsedError;
  double get volume24h => throw _privateConstructorUsedError;
  double get fee24h => throw _privateConstructorUsedError;
  double get volumeAllTime => throw _privateConstructorUsedError;
  double get feeAllTime => throw _privateConstructorUsedError;
  bool get refreshInProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PoolItemStateCopyWith<PoolItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolItemStateCopyWith<$Res> {
  factory $PoolItemStateCopyWith(
          PoolItemState value, $Res Function(PoolItemState) then) =
      _$PoolItemStateCopyWithImpl<$Res, PoolItemState>;
  @useResult
  $Res call(
      {String poolAddress,
      DexPool? pool,
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime,
      bool refreshInProgress});

  $DexPoolCopyWith<$Res>? get pool;
}

/// @nodoc
class _$PoolItemStateCopyWithImpl<$Res, $Val extends PoolItemState>
    implements $PoolItemStateCopyWith<$Res> {
  _$PoolItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? pool = freezed,
    Object? volume24h = null,
    Object? fee24h = null,
    Object? volumeAllTime = null,
    Object? feeAllTime = null,
    Object? refreshInProgress = null,
  }) {
    return _then(_value.copyWith(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      fee24h: null == fee24h
          ? _value.fee24h
          : fee24h // ignore: cast_nullable_to_non_nullable
              as double,
      volumeAllTime: null == volumeAllTime
          ? _value.volumeAllTime
          : volumeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
      feeAllTime: null == feeAllTime
          ? _value.feeAllTime
          : feeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
      refreshInProgress: null == refreshInProgress
          ? _value.refreshInProgress
          : refreshInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexPoolCopyWith<$Res>? get pool {
    if (_value.pool == null) {
      return null;
    }

    return $DexPoolCopyWith<$Res>(_value.pool!, (value) {
      return _then(_value.copyWith(pool: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PoolItemStateImplCopyWith<$Res>
    implements $PoolItemStateCopyWith<$Res> {
  factory _$$PoolItemStateImplCopyWith(
          _$PoolItemStateImpl value, $Res Function(_$PoolItemStateImpl) then) =
      __$$PoolItemStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String poolAddress,
      DexPool? pool,
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime,
      bool refreshInProgress});

  @override
  $DexPoolCopyWith<$Res>? get pool;
}

/// @nodoc
class __$$PoolItemStateImplCopyWithImpl<$Res>
    extends _$PoolItemStateCopyWithImpl<$Res, _$PoolItemStateImpl>
    implements _$$PoolItemStateImplCopyWith<$Res> {
  __$$PoolItemStateImplCopyWithImpl(
      _$PoolItemStateImpl _value, $Res Function(_$PoolItemStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? pool = freezed,
    Object? volume24h = null,
    Object? fee24h = null,
    Object? volumeAllTime = null,
    Object? feeAllTime = null,
    Object? refreshInProgress = null,
  }) {
    return _then(_$PoolItemStateImpl(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      fee24h: null == fee24h
          ? _value.fee24h
          : fee24h // ignore: cast_nullable_to_non_nullable
              as double,
      volumeAllTime: null == volumeAllTime
          ? _value.volumeAllTime
          : volumeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
      feeAllTime: null == feeAllTime
          ? _value.feeAllTime
          : feeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
      refreshInProgress: null == refreshInProgress
          ? _value.refreshInProgress
          : refreshInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PoolItemStateImpl extends _PoolItemState {
  const _$PoolItemStateImpl(
      {required this.poolAddress,
      this.pool,
      this.volume24h = 0.0,
      this.fee24h = 0.0,
      this.volumeAllTime = 0.0,
      this.feeAllTime = 0.0,
      this.refreshInProgress = false})
      : super._();

  @override
  final String poolAddress;
  @override
  final DexPool? pool;
  @override
  @JsonKey()
  final double volume24h;
  @override
  @JsonKey()
  final double fee24h;
  @override
  @JsonKey()
  final double volumeAllTime;
  @override
  @JsonKey()
  final double feeAllTime;
  @override
  @JsonKey()
  final bool refreshInProgress;

  @override
  String toString() {
    return 'PoolItemState(poolAddress: $poolAddress, pool: $pool, volume24h: $volume24h, fee24h: $fee24h, volumeAllTime: $volumeAllTime, feeAllTime: $feeAllTime, refreshInProgress: $refreshInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolItemStateImpl &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.volume24h, volume24h) ||
                other.volume24h == volume24h) &&
            (identical(other.fee24h, fee24h) || other.fee24h == fee24h) &&
            (identical(other.volumeAllTime, volumeAllTime) ||
                other.volumeAllTime == volumeAllTime) &&
            (identical(other.feeAllTime, feeAllTime) ||
                other.feeAllTime == feeAllTime) &&
            (identical(other.refreshInProgress, refreshInProgress) ||
                other.refreshInProgress == refreshInProgress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poolAddress, pool, volume24h,
      fee24h, volumeAllTime, feeAllTime, refreshInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolItemStateImplCopyWith<_$PoolItemStateImpl> get copyWith =>
      __$$PoolItemStateImplCopyWithImpl<_$PoolItemStateImpl>(this, _$identity);
}

abstract class _PoolItemState extends PoolItemState {
  const factory _PoolItemState(
      {required final String poolAddress,
      final DexPool? pool,
      final double volume24h,
      final double fee24h,
      final double volumeAllTime,
      final double feeAllTime,
      final bool refreshInProgress}) = _$PoolItemStateImpl;
  const _PoolItemState._() : super._();

  @override
  String get poolAddress;
  @override
  DexPool? get pool;
  @override
  double get volume24h;
  @override
  double get fee24h;
  @override
  double get volumeAllTime;
  @override
  double get feeAllTime;
  @override
  bool get refreshInProgress;
  @override
  @JsonKey(ignore: true)
  _$$PoolItemStateImplCopyWith<_$PoolItemStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
