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
mixin _$LiquidityRemoveFormState {
  LiquidityRemoveProcessStep get liquidityRemoveProcessStep =>
      throw _privateConstructorUsedError;
  String get poolGenesisAddress => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get liquidityRemoveOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  DexToken? get lpToken => throw _privateConstructorUsedError;
  double get lpTokenBalance => throw _privateConstructorUsedError;
  double get lpTokenAmount => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LiquidityRemoveFormStateCopyWith<LiquidityRemoveFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidityRemoveFormStateCopyWith<$Res> {
  factory $LiquidityRemoveFormStateCopyWith(LiquidityRemoveFormState value,
          $Res Function(LiquidityRemoveFormState) then) =
      _$LiquidityRemoveFormStateCopyWithImpl<$Res, LiquidityRemoveFormState>;
  @useResult
  $Res call(
      {LiquidityRemoveProcessStep liquidityRemoveProcessStep,
      String poolGenesisAddress,
      bool isProcessInProgress,
      bool liquidityRemoveOk,
      bool walletConfirmation,
      DexToken? lpToken,
      double lpTokenBalance,
      double lpTokenAmount,
      double networkFees,
      Failure? failure});

  $DexTokenCopyWith<$Res>? get lpToken;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$LiquidityRemoveFormStateCopyWithImpl<$Res,
        $Val extends LiquidityRemoveFormState>
    implements $LiquidityRemoveFormStateCopyWith<$Res> {
  _$LiquidityRemoveFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? liquidityRemoveProcessStep = null,
    Object? poolGenesisAddress = null,
    Object? isProcessInProgress = null,
    Object? liquidityRemoveOk = null,
    Object? walletConfirmation = null,
    Object? lpToken = freezed,
    Object? lpTokenBalance = null,
    Object? lpTokenAmount = null,
    Object? networkFees = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      liquidityRemoveProcessStep: null == liquidityRemoveProcessStep
          ? _value.liquidityRemoveProcessStep
          : liquidityRemoveProcessStep // ignore: cast_nullable_to_non_nullable
              as LiquidityRemoveProcessStep,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityRemoveOk: null == liquidityRemoveOk
          ? _value.liquidityRemoveOk
          : liquidityRemoveOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenAmount: null == lpTokenAmount
          ? _value.lpTokenAmount
          : lpTokenAmount // ignore: cast_nullable_to_non_nullable
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
abstract class _$$LiquidityRemoveFormStateImplCopyWith<$Res>
    implements $LiquidityRemoveFormStateCopyWith<$Res> {
  factory _$$LiquidityRemoveFormStateImplCopyWith(
          _$LiquidityRemoveFormStateImpl value,
          $Res Function(_$LiquidityRemoveFormStateImpl) then) =
      __$$LiquidityRemoveFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LiquidityRemoveProcessStep liquidityRemoveProcessStep,
      String poolGenesisAddress,
      bool isProcessInProgress,
      bool liquidityRemoveOk,
      bool walletConfirmation,
      DexToken? lpToken,
      double lpTokenBalance,
      double lpTokenAmount,
      double networkFees,
      Failure? failure});

  @override
  $DexTokenCopyWith<$Res>? get lpToken;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$LiquidityRemoveFormStateImplCopyWithImpl<$Res>
    extends _$LiquidityRemoveFormStateCopyWithImpl<$Res,
        _$LiquidityRemoveFormStateImpl>
    implements _$$LiquidityRemoveFormStateImplCopyWith<$Res> {
  __$$LiquidityRemoveFormStateImplCopyWithImpl(
      _$LiquidityRemoveFormStateImpl _value,
      $Res Function(_$LiquidityRemoveFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? liquidityRemoveProcessStep = null,
    Object? poolGenesisAddress = null,
    Object? isProcessInProgress = null,
    Object? liquidityRemoveOk = null,
    Object? walletConfirmation = null,
    Object? lpToken = freezed,
    Object? lpTokenBalance = null,
    Object? lpTokenAmount = null,
    Object? networkFees = null,
    Object? failure = freezed,
  }) {
    return _then(_$LiquidityRemoveFormStateImpl(
      liquidityRemoveProcessStep: null == liquidityRemoveProcessStep
          ? _value.liquidityRemoveProcessStep
          : liquidityRemoveProcessStep // ignore: cast_nullable_to_non_nullable
              as LiquidityRemoveProcessStep,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityRemoveOk: null == liquidityRemoveOk
          ? _value.liquidityRemoveOk
          : liquidityRemoveOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenAmount: null == lpTokenAmount
          ? _value.lpTokenAmount
          : lpTokenAmount // ignore: cast_nullable_to_non_nullable
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

class _$LiquidityRemoveFormStateImpl extends _LiquidityRemoveFormState {
  const _$LiquidityRemoveFormStateImpl(
      {this.liquidityRemoveProcessStep = LiquidityRemoveProcessStep.form,
      this.poolGenesisAddress = '',
      this.isProcessInProgress = false,
      this.liquidityRemoveOk = false,
      this.walletConfirmation = false,
      this.lpToken,
      this.lpTokenBalance = 0.0,
      this.lpTokenAmount = 0.0,
      this.networkFees = 0.0,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final LiquidityRemoveProcessStep liquidityRemoveProcessStep;
  @override
  @JsonKey()
  final String poolGenesisAddress;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool liquidityRemoveOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  final DexToken? lpToken;
  @override
  @JsonKey()
  final double lpTokenBalance;
  @override
  @JsonKey()
  final double lpTokenAmount;
  @override
  @JsonKey()
  final double networkFees;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'LiquidityRemoveFormState(liquidityRemoveProcessStep: $liquidityRemoveProcessStep, poolGenesisAddress: $poolGenesisAddress, isProcessInProgress: $isProcessInProgress, liquidityRemoveOk: $liquidityRemoveOk, walletConfirmation: $walletConfirmation, lpToken: $lpToken, lpTokenBalance: $lpTokenBalance, lpTokenAmount: $lpTokenAmount, networkFees: $networkFees, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidityRemoveFormStateImpl &&
            (identical(other.liquidityRemoveProcessStep,
                    liquidityRemoveProcessStep) ||
                other.liquidityRemoveProcessStep ==
                    liquidityRemoveProcessStep) &&
            (identical(other.poolGenesisAddress, poolGenesisAddress) ||
                other.poolGenesisAddress == poolGenesisAddress) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.liquidityRemoveOk, liquidityRemoveOk) ||
                other.liquidityRemoveOk == liquidityRemoveOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.lpTokenBalance, lpTokenBalance) ||
                other.lpTokenBalance == lpTokenBalance) &&
            (identical(other.lpTokenAmount, lpTokenAmount) ||
                other.lpTokenAmount == lpTokenAmount) &&
            (identical(other.networkFees, networkFees) ||
                other.networkFees == networkFees) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      liquidityRemoveProcessStep,
      poolGenesisAddress,
      isProcessInProgress,
      liquidityRemoveOk,
      walletConfirmation,
      lpToken,
      lpTokenBalance,
      lpTokenAmount,
      networkFees,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidityRemoveFormStateImplCopyWith<_$LiquidityRemoveFormStateImpl>
      get copyWith => __$$LiquidityRemoveFormStateImplCopyWithImpl<
          _$LiquidityRemoveFormStateImpl>(this, _$identity);
}

abstract class _LiquidityRemoveFormState extends LiquidityRemoveFormState {
  const factory _LiquidityRemoveFormState(
      {final LiquidityRemoveProcessStep liquidityRemoveProcessStep,
      final String poolGenesisAddress,
      final bool isProcessInProgress,
      final bool liquidityRemoveOk,
      final bool walletConfirmation,
      final DexToken? lpToken,
      final double lpTokenBalance,
      final double lpTokenAmount,
      final double networkFees,
      final Failure? failure}) = _$LiquidityRemoveFormStateImpl;
  const _LiquidityRemoveFormState._() : super._();

  @override
  LiquidityRemoveProcessStep get liquidityRemoveProcessStep;
  @override
  String get poolGenesisAddress;
  @override
  bool get isProcessInProgress;
  @override
  bool get liquidityRemoveOk;
  @override
  bool get walletConfirmation;
  @override
  DexToken? get lpToken;
  @override
  double get lpTokenBalance;
  @override
  double get lpTokenAmount;
  @override
  double get networkFees;
  @override
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$LiquidityRemoveFormStateImplCopyWith<_$LiquidityRemoveFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
