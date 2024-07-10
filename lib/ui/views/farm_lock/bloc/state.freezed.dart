// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FarmLockFormState {
  DexPool? get pool => throw _privateConstructorUsedError;
  DexFarm? get farm => throw _privateConstructorUsedError;
  DexFarmLock? get farmLock => throw _privateConstructorUsedError;
  double get token1Balance => throw _privateConstructorUsedError;
  double get token2Balance => throw _privateConstructorUsedError;
  double get lpTokenBalance => throw _privateConstructorUsedError;
  double get farmedTokensCapital => throw _privateConstructorUsedError;
  double get farmedTokensCapitalInFiat => throw _privateConstructorUsedError;
  double get farmedTokensRewards => throw _privateConstructorUsedError;
  double get farmedTokensRewardsInFiat => throw _privateConstructorUsedError;
  bool get mainInfoloadingInProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmLockFormStateCopyWith<FarmLockFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockFormStateCopyWith<$Res> {
  factory $FarmLockFormStateCopyWith(
          FarmLockFormState value, $Res Function(FarmLockFormState) then) =
      _$FarmLockFormStateCopyWithImpl<$Res, FarmLockFormState>;
  @useResult
  $Res call(
      {DexPool? pool,
      DexFarm? farm,
      DexFarmLock? farmLock,
      double token1Balance,
      double token2Balance,
      double lpTokenBalance,
      double farmedTokensCapital,
      double farmedTokensCapitalInFiat,
      double farmedTokensRewards,
      double farmedTokensRewardsInFiat,
      bool mainInfoloadingInProgress});

  $DexPoolCopyWith<$Res>? get pool;
  $DexFarmCopyWith<$Res>? get farm;
  $DexFarmLockCopyWith<$Res>? get farmLock;
}

/// @nodoc
class _$FarmLockFormStateCopyWithImpl<$Res, $Val extends FarmLockFormState>
    implements $FarmLockFormStateCopyWith<$Res> {
  _$FarmLockFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pool = freezed,
    Object? farm = freezed,
    Object? farmLock = freezed,
    Object? token1Balance = null,
    Object? token2Balance = null,
    Object? lpTokenBalance = null,
    Object? farmedTokensCapital = null,
    Object? farmedTokensCapitalInFiat = null,
    Object? farmedTokensRewards = null,
    Object? farmedTokensRewardsInFiat = null,
    Object? mainInfoloadingInProgress = null,
  }) {
    return _then(_value.copyWith(
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      farm: freezed == farm
          ? _value.farm
          : farm // ignore: cast_nullable_to_non_nullable
              as DexFarm?,
      farmLock: freezed == farmLock
          ? _value.farmLock
          : farmLock // ignore: cast_nullable_to_non_nullable
              as DexFarmLock?,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensCapital: null == farmedTokensCapital
          ? _value.farmedTokensCapital
          : farmedTokensCapital // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensCapitalInFiat: null == farmedTokensCapitalInFiat
          ? _value.farmedTokensCapitalInFiat
          : farmedTokensCapitalInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewards: null == farmedTokensRewards
          ? _value.farmedTokensRewards
          : farmedTokensRewards // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewardsInFiat: null == farmedTokensRewardsInFiat
          ? _value.farmedTokensRewardsInFiat
          : farmedTokensRewardsInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      mainInfoloadingInProgress: null == mainInfoloadingInProgress
          ? _value.mainInfoloadingInProgress
          : mainInfoloadingInProgress // ignore: cast_nullable_to_non_nullable
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

  @override
  @pragma('vm:prefer-inline')
  $DexFarmCopyWith<$Res>? get farm {
    if (_value.farm == null) {
      return null;
    }

    return $DexFarmCopyWith<$Res>(_value.farm!, (value) {
      return _then(_value.copyWith(farm: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexFarmLockCopyWith<$Res>? get farmLock {
    if (_value.farmLock == null) {
      return null;
    }

    return $DexFarmLockCopyWith<$Res>(_value.farmLock!, (value) {
      return _then(_value.copyWith(farmLock: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FarmLockFormStateImplCopyWith<$Res>
    implements $FarmLockFormStateCopyWith<$Res> {
  factory _$$FarmLockFormStateImplCopyWith(_$FarmLockFormStateImpl value,
          $Res Function(_$FarmLockFormStateImpl) then) =
      __$$FarmLockFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexPool? pool,
      DexFarm? farm,
      DexFarmLock? farmLock,
      double token1Balance,
      double token2Balance,
      double lpTokenBalance,
      double farmedTokensCapital,
      double farmedTokensCapitalInFiat,
      double farmedTokensRewards,
      double farmedTokensRewardsInFiat,
      bool mainInfoloadingInProgress});

  @override
  $DexPoolCopyWith<$Res>? get pool;
  @override
  $DexFarmCopyWith<$Res>? get farm;
  @override
  $DexFarmLockCopyWith<$Res>? get farmLock;
}

/// @nodoc
class __$$FarmLockFormStateImplCopyWithImpl<$Res>
    extends _$FarmLockFormStateCopyWithImpl<$Res, _$FarmLockFormStateImpl>
    implements _$$FarmLockFormStateImplCopyWith<$Res> {
  __$$FarmLockFormStateImplCopyWithImpl(_$FarmLockFormStateImpl _value,
      $Res Function(_$FarmLockFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pool = freezed,
    Object? farm = freezed,
    Object? farmLock = freezed,
    Object? token1Balance = null,
    Object? token2Balance = null,
    Object? lpTokenBalance = null,
    Object? farmedTokensCapital = null,
    Object? farmedTokensCapitalInFiat = null,
    Object? farmedTokensRewards = null,
    Object? farmedTokensRewardsInFiat = null,
    Object? mainInfoloadingInProgress = null,
  }) {
    return _then(_$FarmLockFormStateImpl(
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      farm: freezed == farm
          ? _value.farm
          : farm // ignore: cast_nullable_to_non_nullable
              as DexFarm?,
      farmLock: freezed == farmLock
          ? _value.farmLock
          : farmLock // ignore: cast_nullable_to_non_nullable
              as DexFarmLock?,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensCapital: null == farmedTokensCapital
          ? _value.farmedTokensCapital
          : farmedTokensCapital // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensCapitalInFiat: null == farmedTokensCapitalInFiat
          ? _value.farmedTokensCapitalInFiat
          : farmedTokensCapitalInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewards: null == farmedTokensRewards
          ? _value.farmedTokensRewards
          : farmedTokensRewards // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewardsInFiat: null == farmedTokensRewardsInFiat
          ? _value.farmedTokensRewardsInFiat
          : farmedTokensRewardsInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      mainInfoloadingInProgress: null == mainInfoloadingInProgress
          ? _value.mainInfoloadingInProgress
          : mainInfoloadingInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FarmLockFormStateImpl extends _FarmLockFormState {
  const _$FarmLockFormStateImpl(
      {this.pool,
      this.farm,
      this.farmLock,
      this.token1Balance = 0.0,
      this.token2Balance = 0.0,
      this.lpTokenBalance = 0.0,
      this.farmedTokensCapital = 0.0,
      this.farmedTokensCapitalInFiat = 0.0,
      this.farmedTokensRewards = 0.0,
      this.farmedTokensRewardsInFiat = 0.0,
      this.mainInfoloadingInProgress = false})
      : super._();

  @override
  final DexPool? pool;
  @override
  final DexFarm? farm;
  @override
  final DexFarmLock? farmLock;
  @override
  @JsonKey()
  final double token1Balance;
  @override
  @JsonKey()
  final double token2Balance;
  @override
  @JsonKey()
  final double lpTokenBalance;
  @override
  @JsonKey()
  final double farmedTokensCapital;
  @override
  @JsonKey()
  final double farmedTokensCapitalInFiat;
  @override
  @JsonKey()
  final double farmedTokensRewards;
  @override
  @JsonKey()
  final double farmedTokensRewardsInFiat;
  @override
  @JsonKey()
  final bool mainInfoloadingInProgress;

  @override
  String toString() {
    return 'FarmLockFormState(pool: $pool, farm: $farm, farmLock: $farmLock, token1Balance: $token1Balance, token2Balance: $token2Balance, lpTokenBalance: $lpTokenBalance, farmedTokensCapital: $farmedTokensCapital, farmedTokensCapitalInFiat: $farmedTokensCapitalInFiat, farmedTokensRewards: $farmedTokensRewards, farmedTokensRewardsInFiat: $farmedTokensRewardsInFiat, mainInfoloadingInProgress: $mainInfoloadingInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockFormStateImpl &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.farm, farm) || other.farm == farm) &&
            (identical(other.farmLock, farmLock) ||
                other.farmLock == farmLock) &&
            (identical(other.token1Balance, token1Balance) ||
                other.token1Balance == token1Balance) &&
            (identical(other.token2Balance, token2Balance) ||
                other.token2Balance == token2Balance) &&
            (identical(other.lpTokenBalance, lpTokenBalance) ||
                other.lpTokenBalance == lpTokenBalance) &&
            (identical(other.farmedTokensCapital, farmedTokensCapital) ||
                other.farmedTokensCapital == farmedTokensCapital) &&
            (identical(other.farmedTokensCapitalInFiat,
                    farmedTokensCapitalInFiat) ||
                other.farmedTokensCapitalInFiat == farmedTokensCapitalInFiat) &&
            (identical(other.farmedTokensRewards, farmedTokensRewards) ||
                other.farmedTokensRewards == farmedTokensRewards) &&
            (identical(other.farmedTokensRewardsInFiat,
                    farmedTokensRewardsInFiat) ||
                other.farmedTokensRewardsInFiat == farmedTokensRewardsInFiat) &&
            (identical(other.mainInfoloadingInProgress,
                    mainInfoloadingInProgress) ||
                other.mainInfoloadingInProgress == mainInfoloadingInProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pool,
      farm,
      farmLock,
      token1Balance,
      token2Balance,
      lpTokenBalance,
      farmedTokensCapital,
      farmedTokensCapitalInFiat,
      farmedTokensRewards,
      farmedTokensRewardsInFiat,
      mainInfoloadingInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockFormStateImplCopyWith<_$FarmLockFormStateImpl> get copyWith =>
      __$$FarmLockFormStateImplCopyWithImpl<_$FarmLockFormStateImpl>(
          this, _$identity);
}

abstract class _FarmLockFormState extends FarmLockFormState {
  const factory _FarmLockFormState(
      {final DexPool? pool,
      final DexFarm? farm,
      final DexFarmLock? farmLock,
      final double token1Balance,
      final double token2Balance,
      final double lpTokenBalance,
      final double farmedTokensCapital,
      final double farmedTokensCapitalInFiat,
      final double farmedTokensRewards,
      final double farmedTokensRewardsInFiat,
      final bool mainInfoloadingInProgress}) = _$FarmLockFormStateImpl;
  const _FarmLockFormState._() : super._();

  @override
  DexPool? get pool;
  @override
  DexFarm? get farm;
  @override
  DexFarmLock? get farmLock;
  @override
  double get token1Balance;
  @override
  double get token2Balance;
  @override
  double get lpTokenBalance;
  @override
  double get farmedTokensCapital;
  @override
  double get farmedTokensCapitalInFiat;
  @override
  double get farmedTokensRewards;
  @override
  double get farmedTokensRewardsInFiat;
  @override
  bool get mainInfoloadingInProgress;
  @override
  @JsonKey(ignore: true)
  _$$FarmLockFormStateImplCopyWith<_$FarmLockFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
