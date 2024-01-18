// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DexFarm {
  String get farmAddress => throw _privateConstructorUsedError;
  DexToken? get lpToken => throw _privateConstructorUsedError;
  int get startDate => throw _privateConstructorUsedError;
  int get endDate => throw _privateConstructorUsedError;
  DexToken? get rewardToken => throw _privateConstructorUsedError;
  double get remainingReward => throw _privateConstructorUsedError;
  double get lpTokenDeposited => throw _privateConstructorUsedError;
  int get nbDeposit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexFarmCopyWith<DexFarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmCopyWith<$Res> {
  factory $DexFarmCopyWith(DexFarm value, $Res Function(DexFarm) then) =
      _$DexFarmCopyWithImpl<$Res, DexFarm>;
  @useResult
  $Res call(
      {String farmAddress,
      DexToken? lpToken,
      int startDate,
      int endDate,
      DexToken? rewardToken,
      double remainingReward,
      double lpTokenDeposited,
      int nbDeposit});

  $DexTokenCopyWith<$Res>? get lpToken;
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class _$DexFarmCopyWithImpl<$Res, $Val extends DexFarm>
    implements $DexFarmCopyWith<$Res> {
  _$DexFarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmAddress = null,
    Object? lpToken = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? rewardToken = freezed,
    Object? remainingReward = null,
    Object? lpTokenDeposited = null,
    Object? nbDeposit = null,
  }) {
    return _then(_value.copyWith(
      farmAddress: null == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      remainingReward: null == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenDeposited: null == lpTokenDeposited
          ? _value.lpTokenDeposited
          : lpTokenDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      nbDeposit: null == nbDeposit
          ? _value.nbDeposit
          : nbDeposit // ignore: cast_nullable_to_non_nullable
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
  $DexTokenCopyWith<$Res>? get rewardToken {
    if (_value.rewardToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.rewardToken!, (value) {
      return _then(_value.copyWith(rewardToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DexFarmImplCopyWith<$Res> implements $DexFarmCopyWith<$Res> {
  factory _$$DexFarmImplCopyWith(
          _$DexFarmImpl value, $Res Function(_$DexFarmImpl) then) =
      __$$DexFarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String farmAddress,
      DexToken? lpToken,
      int startDate,
      int endDate,
      DexToken? rewardToken,
      double remainingReward,
      double lpTokenDeposited,
      int nbDeposit});

  @override
  $DexTokenCopyWith<$Res>? get lpToken;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$DexFarmImplCopyWithImpl<$Res>
    extends _$DexFarmCopyWithImpl<$Res, _$DexFarmImpl>
    implements _$$DexFarmImplCopyWith<$Res> {
  __$$DexFarmImplCopyWithImpl(
      _$DexFarmImpl _value, $Res Function(_$DexFarmImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmAddress = null,
    Object? lpToken = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? rewardToken = freezed,
    Object? remainingReward = null,
    Object? lpTokenDeposited = null,
    Object? nbDeposit = null,
  }) {
    return _then(_$DexFarmImpl(
      farmAddress: null == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      remainingReward: null == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenDeposited: null == lpTokenDeposited
          ? _value.lpTokenDeposited
          : lpTokenDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      nbDeposit: null == nbDeposit
          ? _value.nbDeposit
          : nbDeposit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DexFarmImpl extends _DexFarm {
  const _$DexFarmImpl(
      {this.farmAddress = '',
      this.lpToken,
      this.startDate = 0,
      this.endDate = 0,
      this.rewardToken,
      this.remainingReward = 0,
      this.lpTokenDeposited = 0,
      this.nbDeposit = 0})
      : super._();

  @override
  @JsonKey()
  final String farmAddress;
  @override
  final DexToken? lpToken;
  @override
  @JsonKey()
  final int startDate;
  @override
  @JsonKey()
  final int endDate;
  @override
  final DexToken? rewardToken;
  @override
  @JsonKey()
  final double remainingReward;
  @override
  @JsonKey()
  final double lpTokenDeposited;
  @override
  @JsonKey()
  final int nbDeposit;

  @override
  String toString() {
    return 'DexFarm(farmAddress: $farmAddress, lpToken: $lpToken, startDate: $startDate, endDate: $endDate, rewardToken: $rewardToken, remainingReward: $remainingReward, lpTokenDeposited: $lpTokenDeposited, nbDeposit: $nbDeposit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmImpl &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.remainingReward, remainingReward) ||
                other.remainingReward == remainingReward) &&
            (identical(other.lpTokenDeposited, lpTokenDeposited) ||
                other.lpTokenDeposited == lpTokenDeposited) &&
            (identical(other.nbDeposit, nbDeposit) ||
                other.nbDeposit == nbDeposit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, farmAddress, lpToken, startDate,
      endDate, rewardToken, remainingReward, lpTokenDeposited, nbDeposit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmImplCopyWith<_$DexFarmImpl> get copyWith =>
      __$$DexFarmImplCopyWithImpl<_$DexFarmImpl>(this, _$identity);
}

abstract class _DexFarm extends DexFarm {
  const factory _DexFarm(
      {final String farmAddress,
      final DexToken? lpToken,
      final int startDate,
      final int endDate,
      final DexToken? rewardToken,
      final double remainingReward,
      final double lpTokenDeposited,
      final int nbDeposit}) = _$DexFarmImpl;
  const _DexFarm._() : super._();

  @override
  String get farmAddress;
  @override
  DexToken? get lpToken;
  @override
  int get startDate;
  @override
  int get endDate;
  @override
  DexToken? get rewardToken;
  @override
  double get remainingReward;
  @override
  double get lpTokenDeposited;
  @override
  int get nbDeposit;
  @override
  @JsonKey(ignore: true)
  _$$DexFarmImplCopyWith<_$DexFarmImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
