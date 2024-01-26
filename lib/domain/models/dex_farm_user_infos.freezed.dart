// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm_user_infos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DexFarmUserInfos {
  double get depositedAmount => throw _privateConstructorUsedError;
  double get rewardAmount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexFarmUserInfosCopyWith<DexFarmUserInfos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmUserInfosCopyWith<$Res> {
  factory $DexFarmUserInfosCopyWith(
          DexFarmUserInfos value, $Res Function(DexFarmUserInfos) then) =
      _$DexFarmUserInfosCopyWithImpl<$Res, DexFarmUserInfos>;
  @useResult
  $Res call({double depositedAmount, double rewardAmount});
}

/// @nodoc
class _$DexFarmUserInfosCopyWithImpl<$Res, $Val extends DexFarmUserInfos>
    implements $DexFarmUserInfosCopyWith<$Res> {
  _$DexFarmUserInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depositedAmount = null,
    Object? rewardAmount = null,
  }) {
    return _then(_value.copyWith(
      depositedAmount: null == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexFarmUserInfosImplCopyWith<$Res>
    implements $DexFarmUserInfosCopyWith<$Res> {
  factory _$$DexFarmUserInfosImplCopyWith(_$DexFarmUserInfosImpl value,
          $Res Function(_$DexFarmUserInfosImpl) then) =
      __$$DexFarmUserInfosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double depositedAmount, double rewardAmount});
}

/// @nodoc
class __$$DexFarmUserInfosImplCopyWithImpl<$Res>
    extends _$DexFarmUserInfosCopyWithImpl<$Res, _$DexFarmUserInfosImpl>
    implements _$$DexFarmUserInfosImplCopyWith<$Res> {
  __$$DexFarmUserInfosImplCopyWithImpl(_$DexFarmUserInfosImpl _value,
      $Res Function(_$DexFarmUserInfosImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depositedAmount = null,
    Object? rewardAmount = null,
  }) {
    return _then(_$DexFarmUserInfosImpl(
      depositedAmount: null == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DexFarmUserInfosImpl extends _DexFarmUserInfos {
  const _$DexFarmUserInfosImpl(
      {this.depositedAmount = 0.0, this.rewardAmount = 0.0})
      : super._();

  @override
  @JsonKey()
  final double depositedAmount;
  @override
  @JsonKey()
  final double rewardAmount;

  @override
  String toString() {
    return 'DexFarmUserInfos(depositedAmount: $depositedAmount, rewardAmount: $rewardAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmUserInfosImpl &&
            (identical(other.depositedAmount, depositedAmount) ||
                other.depositedAmount == depositedAmount) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, depositedAmount, rewardAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmUserInfosImplCopyWith<_$DexFarmUserInfosImpl> get copyWith =>
      __$$DexFarmUserInfosImplCopyWithImpl<_$DexFarmUserInfosImpl>(
          this, _$identity);
}

abstract class _DexFarmUserInfos extends DexFarmUserInfos {
  const factory _DexFarmUserInfos(
      {final double depositedAmount,
      final double rewardAmount}) = _$DexFarmUserInfosImpl;
  const _DexFarmUserInfos._() : super._();

  @override
  double get depositedAmount;
  @override
  double get rewardAmount;
  @override
  @JsonKey(ignore: true)
  _$$DexFarmUserInfosImplCopyWith<_$DexFarmUserInfosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
