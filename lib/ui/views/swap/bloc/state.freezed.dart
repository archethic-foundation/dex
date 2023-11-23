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
mixin _$SwapFormState {
  SwapProcessStep get swapProcessStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  int get tokenFormSelected => throw _privateConstructorUsedError;
  String get poolGenesisAddress => throw _privateConstructorUsedError;
  DexToken? get tokenToSwap => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get swapOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  double get tokenToSwapBalance => throw _privateConstructorUsedError;
  double get tokenToSwapAmount => throw _privateConstructorUsedError;
  DexToken? get tokenSwapped => throw _privateConstructorUsedError;
  double get tokenSwappedBalance => throw _privateConstructorUsedError;
  double get tokenSwappedAmount => throw _privateConstructorUsedError;
  double get ratio => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  double get swapFees => throw _privateConstructorUsedError;
  double get slippageTolerance => throw _privateConstructorUsedError;
  double get minimumReceived => throw _privateConstructorUsedError;
  double get priceImpact => throw _privateConstructorUsedError;
  double get estimatedReceived => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  Transaction? get recoveryTransactionSwap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SwapFormStateCopyWith<SwapFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapFormStateCopyWith<$Res> {
  factory $SwapFormStateCopyWith(
          SwapFormState value, $Res Function(SwapFormState) then) =
      _$SwapFormStateCopyWithImpl<$Res, SwapFormState>;
  @useResult
  $Res call(
      {SwapProcessStep swapProcessStep,
      bool resumeProcess,
      int currentStep,
      int tokenFormSelected,
      String poolGenesisAddress,
      DexToken? tokenToSwap,
      bool isProcessInProgress,
      bool swapOk,
      bool walletConfirmation,
      double tokenToSwapBalance,
      double tokenToSwapAmount,
      DexToken? tokenSwapped,
      double tokenSwappedBalance,
      double tokenSwappedAmount,
      double ratio,
      double networkFees,
      double swapFees,
      double slippageTolerance,
      double minimumReceived,
      double priceImpact,
      double estimatedReceived,
      Failure? failure,
      Transaction? recoveryTransactionSwap});

  $DexTokenCopyWith<$Res>? get tokenToSwap;
  $DexTokenCopyWith<$Res>? get tokenSwapped;
  $FailureCopyWith<$Res>? get failure;
  $TransactionCopyWith<$Res>? get recoveryTransactionSwap;
}

/// @nodoc
class _$SwapFormStateCopyWithImpl<$Res, $Val extends SwapFormState>
    implements $SwapFormStateCopyWith<$Res> {
  _$SwapFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? tokenFormSelected = null,
    Object? poolGenesisAddress = null,
    Object? tokenToSwap = freezed,
    Object? isProcessInProgress = null,
    Object? swapOk = null,
    Object? walletConfirmation = null,
    Object? tokenToSwapBalance = null,
    Object? tokenToSwapAmount = null,
    Object? tokenSwapped = freezed,
    Object? tokenSwappedBalance = null,
    Object? tokenSwappedAmount = null,
    Object? ratio = null,
    Object? networkFees = null,
    Object? swapFees = null,
    Object? slippageTolerance = null,
    Object? minimumReceived = null,
    Object? priceImpact = null,
    Object? estimatedReceived = null,
    Object? failure = freezed,
    Object? recoveryTransactionSwap = freezed,
  }) {
    return _then(_value.copyWith(
      swapProcessStep: null == swapProcessStep
          ? _value.swapProcessStep
          : swapProcessStep // ignore: cast_nullable_to_non_nullable
              as SwapProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      tokenFormSelected: null == tokenFormSelected
          ? _value.tokenFormSelected
          : tokenFormSelected // ignore: cast_nullable_to_non_nullable
              as int,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenToSwap: freezed == tokenToSwap
          ? _value.tokenToSwap
          : tokenToSwap // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      swapOk: null == swapOk
          ? _value.swapOk
          : swapOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenToSwapBalance: null == tokenToSwapBalance
          ? _value.tokenToSwapBalance
          : tokenToSwapBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenToSwapAmount: null == tokenToSwapAmount
          ? _value.tokenToSwapAmount
          : tokenToSwapAmount // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwapped: freezed == tokenSwapped
          ? _value.tokenSwapped
          : tokenSwapped // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      tokenSwappedBalance: null == tokenSwappedBalance
          ? _value.tokenSwappedBalance
          : tokenSwappedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwappedAmount: null == tokenSwappedAmount
          ? _value.tokenSwappedAmount
          : tokenSwappedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      swapFees: null == swapFees
          ? _value.swapFees
          : swapFees // ignore: cast_nullable_to_non_nullable
              as double,
      slippageTolerance: null == slippageTolerance
          ? _value.slippageTolerance
          : slippageTolerance // ignore: cast_nullable_to_non_nullable
              as double,
      minimumReceived: null == minimumReceived
          ? _value.minimumReceived
          : minimumReceived // ignore: cast_nullable_to_non_nullable
              as double,
      priceImpact: null == priceImpact
          ? _value.priceImpact
          : priceImpact // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedReceived: null == estimatedReceived
          ? _value.estimatedReceived
          : estimatedReceived // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      recoveryTransactionSwap: freezed == recoveryTransactionSwap
          ? _value.recoveryTransactionSwap
          : recoveryTransactionSwap // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get tokenToSwap {
    if (_value.tokenToSwap == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.tokenToSwap!, (value) {
      return _then(_value.copyWith(tokenToSwap: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get tokenSwapped {
    if (_value.tokenSwapped == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.tokenSwapped!, (value) {
      return _then(_value.copyWith(tokenSwapped: value) as $Val);
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

  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get recoveryTransactionSwap {
    if (_value.recoveryTransactionSwap == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.recoveryTransactionSwap!, (value) {
      return _then(_value.copyWith(recoveryTransactionSwap: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SwapFormStateImplCopyWith<$Res>
    implements $SwapFormStateCopyWith<$Res> {
  factory _$$SwapFormStateImplCopyWith(
          _$SwapFormStateImpl value, $Res Function(_$SwapFormStateImpl) then) =
      __$$SwapFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SwapProcessStep swapProcessStep,
      bool resumeProcess,
      int currentStep,
      int tokenFormSelected,
      String poolGenesisAddress,
      DexToken? tokenToSwap,
      bool isProcessInProgress,
      bool swapOk,
      bool walletConfirmation,
      double tokenToSwapBalance,
      double tokenToSwapAmount,
      DexToken? tokenSwapped,
      double tokenSwappedBalance,
      double tokenSwappedAmount,
      double ratio,
      double networkFees,
      double swapFees,
      double slippageTolerance,
      double minimumReceived,
      double priceImpact,
      double estimatedReceived,
      Failure? failure,
      Transaction? recoveryTransactionSwap});

  @override
  $DexTokenCopyWith<$Res>? get tokenToSwap;
  @override
  $DexTokenCopyWith<$Res>? get tokenSwapped;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $TransactionCopyWith<$Res>? get recoveryTransactionSwap;
}

/// @nodoc
class __$$SwapFormStateImplCopyWithImpl<$Res>
    extends _$SwapFormStateCopyWithImpl<$Res, _$SwapFormStateImpl>
    implements _$$SwapFormStateImplCopyWith<$Res> {
  __$$SwapFormStateImplCopyWithImpl(
      _$SwapFormStateImpl _value, $Res Function(_$SwapFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? tokenFormSelected = null,
    Object? poolGenesisAddress = null,
    Object? tokenToSwap = freezed,
    Object? isProcessInProgress = null,
    Object? swapOk = null,
    Object? walletConfirmation = null,
    Object? tokenToSwapBalance = null,
    Object? tokenToSwapAmount = null,
    Object? tokenSwapped = freezed,
    Object? tokenSwappedBalance = null,
    Object? tokenSwappedAmount = null,
    Object? ratio = null,
    Object? networkFees = null,
    Object? swapFees = null,
    Object? slippageTolerance = null,
    Object? minimumReceived = null,
    Object? priceImpact = null,
    Object? estimatedReceived = null,
    Object? failure = freezed,
    Object? recoveryTransactionSwap = freezed,
  }) {
    return _then(_$SwapFormStateImpl(
      swapProcessStep: null == swapProcessStep
          ? _value.swapProcessStep
          : swapProcessStep // ignore: cast_nullable_to_non_nullable
              as SwapProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      tokenFormSelected: null == tokenFormSelected
          ? _value.tokenFormSelected
          : tokenFormSelected // ignore: cast_nullable_to_non_nullable
              as int,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenToSwap: freezed == tokenToSwap
          ? _value.tokenToSwap
          : tokenToSwap // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      swapOk: null == swapOk
          ? _value.swapOk
          : swapOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenToSwapBalance: null == tokenToSwapBalance
          ? _value.tokenToSwapBalance
          : tokenToSwapBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenToSwapAmount: null == tokenToSwapAmount
          ? _value.tokenToSwapAmount
          : tokenToSwapAmount // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwapped: freezed == tokenSwapped
          ? _value.tokenSwapped
          : tokenSwapped // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      tokenSwappedBalance: null == tokenSwappedBalance
          ? _value.tokenSwappedBalance
          : tokenSwappedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwappedAmount: null == tokenSwappedAmount
          ? _value.tokenSwappedAmount
          : tokenSwappedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      swapFees: null == swapFees
          ? _value.swapFees
          : swapFees // ignore: cast_nullable_to_non_nullable
              as double,
      slippageTolerance: null == slippageTolerance
          ? _value.slippageTolerance
          : slippageTolerance // ignore: cast_nullable_to_non_nullable
              as double,
      minimumReceived: null == minimumReceived
          ? _value.minimumReceived
          : minimumReceived // ignore: cast_nullable_to_non_nullable
              as double,
      priceImpact: null == priceImpact
          ? _value.priceImpact
          : priceImpact // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedReceived: null == estimatedReceived
          ? _value.estimatedReceived
          : estimatedReceived // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      recoveryTransactionSwap: freezed == recoveryTransactionSwap
          ? _value.recoveryTransactionSwap
          : recoveryTransactionSwap // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ));
  }
}

/// @nodoc

class _$SwapFormStateImpl extends _SwapFormState {
  const _$SwapFormStateImpl(
      {this.swapProcessStep = SwapProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.tokenFormSelected = 1,
      this.poolGenesisAddress = '',
      this.tokenToSwap,
      this.isProcessInProgress = false,
      this.swapOk = false,
      this.walletConfirmation = false,
      this.tokenToSwapBalance = 0,
      this.tokenToSwapAmount = 0,
      this.tokenSwapped,
      this.tokenSwappedBalance = 0,
      this.tokenSwappedAmount = 0,
      this.ratio = 0.0,
      this.networkFees = 0.0,
      this.swapFees = 0.0,
      this.slippageTolerance = 0.5,
      this.minimumReceived = 0.0,
      this.priceImpact = 0.0,
      this.estimatedReceived = 0.0,
      this.failure,
      this.recoveryTransactionSwap})
      : super._();

  @override
  @JsonKey()
  final SwapProcessStep swapProcessStep;
  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final int tokenFormSelected;
  @override
  @JsonKey()
  final String poolGenesisAddress;
  @override
  final DexToken? tokenToSwap;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool swapOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  @JsonKey()
  final double tokenToSwapBalance;
  @override
  @JsonKey()
  final double tokenToSwapAmount;
  @override
  final DexToken? tokenSwapped;
  @override
  @JsonKey()
  final double tokenSwappedBalance;
  @override
  @JsonKey()
  final double tokenSwappedAmount;
  @override
  @JsonKey()
  final double ratio;
  @override
  @JsonKey()
  final double networkFees;
  @override
  @JsonKey()
  final double swapFees;
  @override
  @JsonKey()
  final double slippageTolerance;
  @override
  @JsonKey()
  final double minimumReceived;
  @override
  @JsonKey()
  final double priceImpact;
  @override
  @JsonKey()
  final double estimatedReceived;
  @override
  final Failure? failure;
  @override
  final Transaction? recoveryTransactionSwap;

  @override
  String toString() {
    return 'SwapFormState(swapProcessStep: $swapProcessStep, resumeProcess: $resumeProcess, currentStep: $currentStep, tokenFormSelected: $tokenFormSelected, poolGenesisAddress: $poolGenesisAddress, tokenToSwap: $tokenToSwap, isProcessInProgress: $isProcessInProgress, swapOk: $swapOk, walletConfirmation: $walletConfirmation, tokenToSwapBalance: $tokenToSwapBalance, tokenToSwapAmount: $tokenToSwapAmount, tokenSwapped: $tokenSwapped, tokenSwappedBalance: $tokenSwappedBalance, tokenSwappedAmount: $tokenSwappedAmount, ratio: $ratio, networkFees: $networkFees, swapFees: $swapFees, slippageTolerance: $slippageTolerance, minimumReceived: $minimumReceived, priceImpact: $priceImpact, estimatedReceived: $estimatedReceived, failure: $failure, recoveryTransactionSwap: $recoveryTransactionSwap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapFormStateImpl &&
            (identical(other.swapProcessStep, swapProcessStep) ||
                other.swapProcessStep == swapProcessStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.tokenFormSelected, tokenFormSelected) ||
                other.tokenFormSelected == tokenFormSelected) &&
            (identical(other.poolGenesisAddress, poolGenesisAddress) ||
                other.poolGenesisAddress == poolGenesisAddress) &&
            (identical(other.tokenToSwap, tokenToSwap) ||
                other.tokenToSwap == tokenToSwap) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.swapOk, swapOk) || other.swapOk == swapOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.tokenToSwapBalance, tokenToSwapBalance) ||
                other.tokenToSwapBalance == tokenToSwapBalance) &&
            (identical(other.tokenToSwapAmount, tokenToSwapAmount) ||
                other.tokenToSwapAmount == tokenToSwapAmount) &&
            (identical(other.tokenSwapped, tokenSwapped) ||
                other.tokenSwapped == tokenSwapped) &&
            (identical(other.tokenSwappedBalance, tokenSwappedBalance) ||
                other.tokenSwappedBalance == tokenSwappedBalance) &&
            (identical(other.tokenSwappedAmount, tokenSwappedAmount) ||
                other.tokenSwappedAmount == tokenSwappedAmount) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.networkFees, networkFees) ||
                other.networkFees == networkFees) &&
            (identical(other.swapFees, swapFees) ||
                other.swapFees == swapFees) &&
            (identical(other.slippageTolerance, slippageTolerance) ||
                other.slippageTolerance == slippageTolerance) &&
            (identical(other.minimumReceived, minimumReceived) ||
                other.minimumReceived == minimumReceived) &&
            (identical(other.priceImpact, priceImpact) ||
                other.priceImpact == priceImpact) &&
            (identical(other.estimatedReceived, estimatedReceived) ||
                other.estimatedReceived == estimatedReceived) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(
                    other.recoveryTransactionSwap, recoveryTransactionSwap) ||
                other.recoveryTransactionSwap == recoveryTransactionSwap));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        swapProcessStep,
        resumeProcess,
        currentStep,
        tokenFormSelected,
        poolGenesisAddress,
        tokenToSwap,
        isProcessInProgress,
        swapOk,
        walletConfirmation,
        tokenToSwapBalance,
        tokenToSwapAmount,
        tokenSwapped,
        tokenSwappedBalance,
        tokenSwappedAmount,
        ratio,
        networkFees,
        swapFees,
        slippageTolerance,
        minimumReceived,
        priceImpact,
        estimatedReceived,
        failure,
        recoveryTransactionSwap
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapFormStateImplCopyWith<_$SwapFormStateImpl> get copyWith =>
      __$$SwapFormStateImplCopyWithImpl<_$SwapFormStateImpl>(this, _$identity);
}

abstract class _SwapFormState extends SwapFormState {
  const factory _SwapFormState(
      {final SwapProcessStep swapProcessStep,
      final bool resumeProcess,
      final int currentStep,
      final int tokenFormSelected,
      final String poolGenesisAddress,
      final DexToken? tokenToSwap,
      final bool isProcessInProgress,
      final bool swapOk,
      final bool walletConfirmation,
      final double tokenToSwapBalance,
      final double tokenToSwapAmount,
      final DexToken? tokenSwapped,
      final double tokenSwappedBalance,
      final double tokenSwappedAmount,
      final double ratio,
      final double networkFees,
      final double swapFees,
      final double slippageTolerance,
      final double minimumReceived,
      final double priceImpact,
      final double estimatedReceived,
      final Failure? failure,
      final Transaction? recoveryTransactionSwap}) = _$SwapFormStateImpl;
  const _SwapFormState._() : super._();

  @override
  SwapProcessStep get swapProcessStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  int get tokenFormSelected;
  @override
  String get poolGenesisAddress;
  @override
  DexToken? get tokenToSwap;
  @override
  bool get isProcessInProgress;
  @override
  bool get swapOk;
  @override
  bool get walletConfirmation;
  @override
  double get tokenToSwapBalance;
  @override
  double get tokenToSwapAmount;
  @override
  DexToken? get tokenSwapped;
  @override
  double get tokenSwappedBalance;
  @override
  double get tokenSwappedAmount;
  @override
  double get ratio;
  @override
  double get networkFees;
  @override
  double get swapFees;
  @override
  double get slippageTolerance;
  @override
  double get minimumReceived;
  @override
  double get priceImpact;
  @override
  double get estimatedReceived;
  @override
  Failure? get failure;
  @override
  Transaction? get recoveryTransactionSwap;
  @override
  @JsonKey(ignore: true)
  _$$SwapFormStateImplCopyWith<_$SwapFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
