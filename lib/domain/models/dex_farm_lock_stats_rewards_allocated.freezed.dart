// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm_lock_stats_rewards_allocated.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexFarmLockStatsRewardsAllocated _$DexFarmLockStatsRewardsAllocatedFromJson(
    Map<String, dynamic> json) {
  return _DexFarmLockStatsRewardsAllocated.fromJson(json);
}

/// @nodoc
mixin _$DexFarmLockStatsRewardsAllocated {
  double get rewardsAllocated => throw _privateConstructorUsedError;
  int get startPeriod => throw _privateConstructorUsedError;
  int get endPeriod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DexFarmLockStatsRewardsAllocatedCopyWith<DexFarmLockStatsRewardsAllocated>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmLockStatsRewardsAllocatedCopyWith<$Res> {
  factory $DexFarmLockStatsRewardsAllocatedCopyWith(
          DexFarmLockStatsRewardsAllocated value,
          $Res Function(DexFarmLockStatsRewardsAllocated) then) =
      _$DexFarmLockStatsRewardsAllocatedCopyWithImpl<$Res,
          DexFarmLockStatsRewardsAllocated>;
  @useResult
  $Res call({double rewardsAllocated, int startPeriod, int endPeriod});
}

/// @nodoc
class _$DexFarmLockStatsRewardsAllocatedCopyWithImpl<$Res,
        $Val extends DexFarmLockStatsRewardsAllocated>
    implements $DexFarmLockStatsRewardsAllocatedCopyWith<$Res> {
  _$DexFarmLockStatsRewardsAllocatedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardsAllocated = null,
    Object? startPeriod = null,
    Object? endPeriod = null,
  }) {
    return _then(_value.copyWith(
      rewardsAllocated: null == rewardsAllocated
          ? _value.rewardsAllocated
          : rewardsAllocated // ignore: cast_nullable_to_non_nullable
              as double,
      startPeriod: null == startPeriod
          ? _value.startPeriod
          : startPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      endPeriod: null == endPeriod
          ? _value.endPeriod
          : endPeriod // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexFarmLockStatsRewardsAllocatedImplCopyWith<$Res>
    implements $DexFarmLockStatsRewardsAllocatedCopyWith<$Res> {
  factory _$$DexFarmLockStatsRewardsAllocatedImplCopyWith(
          _$DexFarmLockStatsRewardsAllocatedImpl value,
          $Res Function(_$DexFarmLockStatsRewardsAllocatedImpl) then) =
      __$$DexFarmLockStatsRewardsAllocatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double rewardsAllocated, int startPeriod, int endPeriod});
}

/// @nodoc
class __$$DexFarmLockStatsRewardsAllocatedImplCopyWithImpl<$Res>
    extends _$DexFarmLockStatsRewardsAllocatedCopyWithImpl<$Res,
        _$DexFarmLockStatsRewardsAllocatedImpl>
    implements _$$DexFarmLockStatsRewardsAllocatedImplCopyWith<$Res> {
  __$$DexFarmLockStatsRewardsAllocatedImplCopyWithImpl(
      _$DexFarmLockStatsRewardsAllocatedImpl _value,
      $Res Function(_$DexFarmLockStatsRewardsAllocatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardsAllocated = null,
    Object? startPeriod = null,
    Object? endPeriod = null,
  }) {
    return _then(_$DexFarmLockStatsRewardsAllocatedImpl(
      rewardsAllocated: null == rewardsAllocated
          ? _value.rewardsAllocated
          : rewardsAllocated // ignore: cast_nullable_to_non_nullable
              as double,
      startPeriod: null == startPeriod
          ? _value.startPeriod
          : startPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      endPeriod: null == endPeriod
          ? _value.endPeriod
          : endPeriod // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexFarmLockStatsRewardsAllocatedImpl
    extends _DexFarmLockStatsRewardsAllocated {
  const _$DexFarmLockStatsRewardsAllocatedImpl(
      {this.rewardsAllocated = 0.0, this.startPeriod = 0, this.endPeriod = 0})
      : super._();

  factory _$DexFarmLockStatsRewardsAllocatedImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DexFarmLockStatsRewardsAllocatedImplFromJson(json);

  @override
  @JsonKey()
  final double rewardsAllocated;
  @override
  @JsonKey()
  final int startPeriod;
  @override
  @JsonKey()
  final int endPeriod;

  @override
  String toString() {
    return 'DexFarmLockStatsRewardsAllocated(rewardsAllocated: $rewardsAllocated, startPeriod: $startPeriod, endPeriod: $endPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmLockStatsRewardsAllocatedImpl &&
            (identical(other.rewardsAllocated, rewardsAllocated) ||
                other.rewardsAllocated == rewardsAllocated) &&
            (identical(other.startPeriod, startPeriod) ||
                other.startPeriod == startPeriod) &&
            (identical(other.endPeriod, endPeriod) ||
                other.endPeriod == endPeriod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, rewardsAllocated, startPeriod, endPeriod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmLockStatsRewardsAllocatedImplCopyWith<
          _$DexFarmLockStatsRewardsAllocatedImpl>
      get copyWith => __$$DexFarmLockStatsRewardsAllocatedImplCopyWithImpl<
          _$DexFarmLockStatsRewardsAllocatedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexFarmLockStatsRewardsAllocatedImplToJson(
      this,
    );
  }
}

abstract class _DexFarmLockStatsRewardsAllocated
    extends DexFarmLockStatsRewardsAllocated {
  const factory _DexFarmLockStatsRewardsAllocated(
      {final double rewardsAllocated,
      final int startPeriod,
      final int endPeriod}) = _$DexFarmLockStatsRewardsAllocatedImpl;
  const _DexFarmLockStatsRewardsAllocated._() : super._();

  factory _DexFarmLockStatsRewardsAllocated.fromJson(
          Map<String, dynamic> json) =
      _$DexFarmLockStatsRewardsAllocatedImpl.fromJson;

  @override
  double get rewardsAllocated;
  @override
  int get startPeriod;
  @override
  int get endPeriod;
  @override
  @JsonKey(ignore: true)
  _$$DexFarmLockStatsRewardsAllocatedImplCopyWith<
          _$DexFarmLockStatsRewardsAllocatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
