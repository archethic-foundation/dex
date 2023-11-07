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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PoolAddFormState {
  PoolAddProcessStep get poolAddProcessStep =>
      throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get poolAddOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  DexToken? get token1 => throw _privateConstructorUsedError;
  DexToken? get token2 => throw _privateConstructorUsedError;
  double get token1Balance => throw _privateConstructorUsedError;
  double get token1Amount => throw _privateConstructorUsedError;
  double get token2Balance => throw _privateConstructorUsedError;
  double get token2Amount => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PoolAddFormStateCopyWith<PoolAddFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolAddFormStateCopyWith<$Res> {
  factory $PoolAddFormStateCopyWith(
          PoolAddFormState value, $Res Function(PoolAddFormState) then) =
      _$PoolAddFormStateCopyWithImpl<$Res, PoolAddFormState>;
  @useResult
  $Res call(
      {PoolAddProcessStep poolAddProcessStep,
      bool isProcessInProgress,
      bool poolAddOk,
      bool walletConfirmation,
      DexToken? token1,
      DexToken? token2,
      double token1Balance,
      double token1Amount,
      double token2Balance,
      double token2Amount,
      double networkFees,
      Failure? failure});

  $DexTokenCopyWith<$Res>? get token1;
  $DexTokenCopyWith<$Res>? get token2;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$PoolAddFormStateCopyWithImpl<$Res, $Val extends PoolAddFormState>
    implements $PoolAddFormStateCopyWith<$Res> {
  _$PoolAddFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddProcessStep = null,
    Object? isProcessInProgress = null,
    Object? poolAddOk = null,
    Object? walletConfirmation = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? token1Balance = null,
    Object? token1Amount = null,
    Object? token2Balance = null,
    Object? token2Amount = null,
    Object? networkFees = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      poolAddProcessStep: null == poolAddProcessStep
          ? _value.poolAddProcessStep
          : poolAddProcessStep // ignore: cast_nullable_to_non_nullable
              as PoolAddProcessStep,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      poolAddOk: null == poolAddOk
          ? _value.poolAddOk
          : poolAddOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      token1: freezed == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token2: freezed == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token1Amount: null == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Amount: null == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token1 {
    if (_value.token1 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token1!, (value) {
      return _then(_value.copyWith(token1: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token2 {
    if (_value.token2 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token2!, (value) {
      return _then(_value.copyWith(token2: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PoolAddFormStateImplCopyWith<$Res>
    implements $PoolAddFormStateCopyWith<$Res> {
  factory _$$PoolAddFormStateImplCopyWith(_$PoolAddFormStateImpl value,
          $Res Function(_$PoolAddFormStateImpl) then) =
      __$$PoolAddFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PoolAddProcessStep poolAddProcessStep,
      bool isProcessInProgress,
      bool poolAddOk,
      bool walletConfirmation,
      DexToken? token1,
      DexToken? token2,
      double token1Balance,
      double token1Amount,
      double token2Balance,
      double token2Amount,
      double networkFees,
      Failure? failure});

  @override
  $DexTokenCopyWith<$Res>? get token1;
  @override
  $DexTokenCopyWith<$Res>? get token2;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$PoolAddFormStateImplCopyWithImpl<$Res>
    extends _$PoolAddFormStateCopyWithImpl<$Res, _$PoolAddFormStateImpl>
    implements _$$PoolAddFormStateImplCopyWith<$Res> {
  __$$PoolAddFormStateImplCopyWithImpl(_$PoolAddFormStateImpl _value,
      $Res Function(_$PoolAddFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddProcessStep = null,
    Object? isProcessInProgress = null,
    Object? poolAddOk = null,
    Object? walletConfirmation = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? token1Balance = null,
    Object? token1Amount = null,
    Object? token2Balance = null,
    Object? token2Amount = null,
    Object? networkFees = null,
    Object? failure = freezed,
  }) {
    return _then(_$PoolAddFormStateImpl(
      poolAddProcessStep: null == poolAddProcessStep
          ? _value.poolAddProcessStep
          : poolAddProcessStep // ignore: cast_nullable_to_non_nullable
              as PoolAddProcessStep,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      poolAddOk: null == poolAddOk
          ? _value.poolAddOk
          : poolAddOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      token1: freezed == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token2: freezed == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token1Amount: null == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Amount: null == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$PoolAddFormStateImpl extends _PoolAddFormState {
  const _$PoolAddFormStateImpl(
      {this.poolAddProcessStep = PoolAddProcessStep.form,
      this.isProcessInProgress = false,
      this.poolAddOk = false,
      this.walletConfirmation = false,
      this.token1,
      this.token2,
      this.token1Balance = 0.0,
      this.token1Amount = 0.0,
      this.token2Balance = 0.0,
      this.token2Amount = 0.0,
      this.networkFees = 0.0,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final PoolAddProcessStep poolAddProcessStep;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool poolAddOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  final DexToken? token1;
  @override
  final DexToken? token2;
  @override
  @JsonKey()
  final double token1Balance;
  @override
  @JsonKey()
  final double token1Amount;
  @override
  @JsonKey()
  final double token2Balance;
  @override
  @JsonKey()
  final double token2Amount;
  @override
  @JsonKey()
  final double networkFees;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'PoolAddFormState(poolAddProcessStep: $poolAddProcessStep, isProcessInProgress: $isProcessInProgress, poolAddOk: $poolAddOk, walletConfirmation: $walletConfirmation, token1: $token1, token2: $token2, token1Balance: $token1Balance, token1Amount: $token1Amount, token2Balance: $token2Balance, token2Amount: $token2Amount, networkFees: $networkFees, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolAddFormStateImpl &&
            (identical(other.poolAddProcessStep, poolAddProcessStep) ||
                other.poolAddProcessStep == poolAddProcessStep) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.poolAddOk, poolAddOk) ||
                other.poolAddOk == poolAddOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2) &&
            (identical(other.token1Balance, token1Balance) ||
                other.token1Balance == token1Balance) &&
            (identical(other.token1Amount, token1Amount) ||
                other.token1Amount == token1Amount) &&
            (identical(other.token2Balance, token2Balance) ||
                other.token2Balance == token2Balance) &&
            (identical(other.token2Amount, token2Amount) ||
                other.token2Amount == token2Amount) &&
            (identical(other.networkFees, networkFees) ||
                other.networkFees == networkFees) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      poolAddProcessStep,
      isProcessInProgress,
      poolAddOk,
      walletConfirmation,
      token1,
      token2,
      token1Balance,
      token1Amount,
      token2Balance,
      token2Amount,
      networkFees,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolAddFormStateImplCopyWith<_$PoolAddFormStateImpl> get copyWith =>
      __$$PoolAddFormStateImplCopyWithImpl<_$PoolAddFormStateImpl>(
          this, _$identity);
}

abstract class _PoolAddFormState extends PoolAddFormState {
  const factory _PoolAddFormState(
      {final PoolAddProcessStep poolAddProcessStep,
      final bool isProcessInProgress,
      final bool poolAddOk,
      final bool walletConfirmation,
      final DexToken? token1,
      final DexToken? token2,
      final double token1Balance,
      final double token1Amount,
      final double token2Balance,
      final double token2Amount,
      final double networkFees,
      final Failure? failure}) = _$PoolAddFormStateImpl;
  const _PoolAddFormState._() : super._();

  @override
  PoolAddProcessStep get poolAddProcessStep;
  @override
  bool get isProcessInProgress;
  @override
  bool get poolAddOk;
  @override
  bool get walletConfirmation;
  @override
  DexToken? get token1;
  @override
  DexToken? get token2;
  @override
  double get token1Balance;
  @override
  double get token1Amount;
  @override
  double get token2Balance;
  @override
  double get token2Amount;
  @override
  double get networkFees;
  @override
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$PoolAddFormStateImplCopyWith<_$PoolAddFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
