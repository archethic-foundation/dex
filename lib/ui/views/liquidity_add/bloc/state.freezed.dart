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
mixin _$LiquidityAddFormState {
  LiquidityAddProcessStep get liquidityAddProcessStep =>
      throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  String get poolGenesisAddress => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get liquidityAddOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  DexToken? get token1 => throw _privateConstructorUsedError;
  DexToken? get token2 => throw _privateConstructorUsedError;
  double get ratio => throw _privateConstructorUsedError;
  double get slippage => throw _privateConstructorUsedError;
  double get token1Balance => throw _privateConstructorUsedError;
  double get token1Amount => throw _privateConstructorUsedError;
  double get token2Balance => throw _privateConstructorUsedError;
  double get token2Amount => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LiquidityAddFormStateCopyWith<LiquidityAddFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidityAddFormStateCopyWith<$Res> {
  factory $LiquidityAddFormStateCopyWith(LiquidityAddFormState value,
          $Res Function(LiquidityAddFormState) then) =
      _$LiquidityAddFormStateCopyWithImpl<$Res, LiquidityAddFormState>;
  @useResult
  $Res call(
      {LiquidityAddProcessStep liquidityAddProcessStep,
      bool resumeProcess,
      int currentStep,
      String poolGenesisAddress,
      bool isProcessInProgress,
      bool liquidityAddOk,
      bool walletConfirmation,
      DexToken? token1,
      DexToken? token2,
      double ratio,
      double slippage,
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
class _$LiquidityAddFormStateCopyWithImpl<$Res,
        $Val extends LiquidityAddFormState>
    implements $LiquidityAddFormStateCopyWith<$Res> {
  _$LiquidityAddFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? liquidityAddProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? poolGenesisAddress = null,
    Object? isProcessInProgress = null,
    Object? liquidityAddOk = null,
    Object? walletConfirmation = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? ratio = null,
    Object? slippage = null,
    Object? token1Balance = null,
    Object? token1Amount = null,
    Object? token2Balance = null,
    Object? token2Amount = null,
    Object? networkFees = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      liquidityAddProcessStep: null == liquidityAddProcessStep
          ? _value.liquidityAddProcessStep
          : liquidityAddProcessStep // ignore: cast_nullable_to_non_nullable
              as LiquidityAddProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityAddOk: null == liquidityAddOk
          ? _value.liquidityAddOk
          : liquidityAddOk // ignore: cast_nullable_to_non_nullable
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
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double,
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
abstract class _$$LiquidityAddFormStateImplCopyWith<$Res>
    implements $LiquidityAddFormStateCopyWith<$Res> {
  factory _$$LiquidityAddFormStateImplCopyWith(
          _$LiquidityAddFormStateImpl value,
          $Res Function(_$LiquidityAddFormStateImpl) then) =
      __$$LiquidityAddFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LiquidityAddProcessStep liquidityAddProcessStep,
      bool resumeProcess,
      int currentStep,
      String poolGenesisAddress,
      bool isProcessInProgress,
      bool liquidityAddOk,
      bool walletConfirmation,
      DexToken? token1,
      DexToken? token2,
      double ratio,
      double slippage,
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
class __$$LiquidityAddFormStateImplCopyWithImpl<$Res>
    extends _$LiquidityAddFormStateCopyWithImpl<$Res,
        _$LiquidityAddFormStateImpl>
    implements _$$LiquidityAddFormStateImplCopyWith<$Res> {
  __$$LiquidityAddFormStateImplCopyWithImpl(_$LiquidityAddFormStateImpl _value,
      $Res Function(_$LiquidityAddFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? liquidityAddProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? poolGenesisAddress = null,
    Object? isProcessInProgress = null,
    Object? liquidityAddOk = null,
    Object? walletConfirmation = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? ratio = null,
    Object? slippage = null,
    Object? token1Balance = null,
    Object? token1Amount = null,
    Object? token2Balance = null,
    Object? token2Amount = null,
    Object? networkFees = null,
    Object? failure = freezed,
  }) {
    return _then(_$LiquidityAddFormStateImpl(
      liquidityAddProcessStep: null == liquidityAddProcessStep
          ? _value.liquidityAddProcessStep
          : liquidityAddProcessStep // ignore: cast_nullable_to_non_nullable
              as LiquidityAddProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityAddOk: null == liquidityAddOk
          ? _value.liquidityAddOk
          : liquidityAddOk // ignore: cast_nullable_to_non_nullable
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
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double,
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

class _$LiquidityAddFormStateImpl extends _LiquidityAddFormState {
  const _$LiquidityAddFormStateImpl(
      {this.liquidityAddProcessStep = LiquidityAddProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.poolGenesisAddress = '',
      this.isProcessInProgress = false,
      this.liquidityAddOk = false,
      this.walletConfirmation = false,
      this.token1,
      this.token2,
      this.ratio = 0.0,
      this.slippage = 2.0,
      this.token1Balance = 0.0,
      this.token1Amount = 0.0,
      this.token2Balance = 0.0,
      this.token2Amount = 0.0,
      this.networkFees = 0.0,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final LiquidityAddProcessStep liquidityAddProcessStep;
  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final String poolGenesisAddress;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool liquidityAddOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  final DexToken? token1;
  @override
  final DexToken? token2;
  @override
  @JsonKey()
  final double ratio;
  @override
  @JsonKey()
  final double slippage;
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
    return 'LiquidityAddFormState(liquidityAddProcessStep: $liquidityAddProcessStep, resumeProcess: $resumeProcess, currentStep: $currentStep, poolGenesisAddress: $poolGenesisAddress, isProcessInProgress: $isProcessInProgress, liquidityAddOk: $liquidityAddOk, walletConfirmation: $walletConfirmation, token1: $token1, token2: $token2, ratio: $ratio, slippage: $slippage, token1Balance: $token1Balance, token1Amount: $token1Amount, token2Balance: $token2Balance, token2Amount: $token2Amount, networkFees: $networkFees, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidityAddFormStateImpl &&
            (identical(
                    other.liquidityAddProcessStep, liquidityAddProcessStep) ||
                other.liquidityAddProcessStep == liquidityAddProcessStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.poolGenesisAddress, poolGenesisAddress) ||
                other.poolGenesisAddress == poolGenesisAddress) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.liquidityAddOk, liquidityAddOk) ||
                other.liquidityAddOk == liquidityAddOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
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
      liquidityAddProcessStep,
      resumeProcess,
      currentStep,
      poolGenesisAddress,
      isProcessInProgress,
      liquidityAddOk,
      walletConfirmation,
      token1,
      token2,
      ratio,
      slippage,
      token1Balance,
      token1Amount,
      token2Balance,
      token2Amount,
      networkFees,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidityAddFormStateImplCopyWith<_$LiquidityAddFormStateImpl>
      get copyWith => __$$LiquidityAddFormStateImplCopyWithImpl<
          _$LiquidityAddFormStateImpl>(this, _$identity);
}

abstract class _LiquidityAddFormState extends LiquidityAddFormState {
  const factory _LiquidityAddFormState(
      {final LiquidityAddProcessStep liquidityAddProcessStep,
      final bool resumeProcess,
      final int currentStep,
      final String poolGenesisAddress,
      final bool isProcessInProgress,
      final bool liquidityAddOk,
      final bool walletConfirmation,
      final DexToken? token1,
      final DexToken? token2,
      final double ratio,
      final double slippage,
      final double token1Balance,
      final double token1Amount,
      final double token2Balance,
      final double token2Amount,
      final double networkFees,
      final Failure? failure}) = _$LiquidityAddFormStateImpl;
  const _LiquidityAddFormState._() : super._();

  @override
  LiquidityAddProcessStep get liquidityAddProcessStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  String get poolGenesisAddress;
  @override
  bool get isProcessInProgress;
  @override
  bool get liquidityAddOk;
  @override
  bool get walletConfirmation;
  @override
  DexToken? get token1;
  @override
  DexToken? get token2;
  @override
  double get ratio;
  @override
  double get slippage;
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
  _$$LiquidityAddFormStateImplCopyWith<_$LiquidityAddFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
