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
mixin _$FarmLockWithdrawFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexFarmLock? get dexFarmLockInfo => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmLockWithdrawOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  int get depositIndex => throw _privateConstructorUsedError;
  Transaction? get transactionWithdrawFarmLock =>
      throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  String? get farmAddress => throw _privateConstructorUsedError;
  DexToken? get rewardToken => throw _privateConstructorUsedError;
  String? get lpTokenAddress => throw _privateConstructorUsedError;
  double? get finalAmountReward => throw _privateConstructorUsedError;
  double? get finalAmountWithdraw => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;
  double? get depositedAmount => throw _privateConstructorUsedError;
  double? get rewardAmount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmLockWithdrawFormStateCopyWith<FarmLockWithdrawFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockWithdrawFormStateCopyWith<$Res> {
  factory $FarmLockWithdrawFormStateCopyWith(FarmLockWithdrawFormState value,
          $Res Function(FarmLockWithdrawFormState) then) =
      _$FarmLockWithdrawFormStateCopyWithImpl<$Res, FarmLockWithdrawFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexFarmLock? dexFarmLockInfo,
      bool isProcessInProgress,
      bool farmLockWithdrawOk,
      bool walletConfirmation,
      double amount,
      int depositIndex,
      Transaction? transactionWithdrawFarmLock,
      Failure? failure,
      String? farmAddress,
      DexToken? rewardToken,
      String? lpTokenAddress,
      double? finalAmountReward,
      double? finalAmountWithdraw,
      DateTime? consentDateTime,
      double? depositedAmount,
      double? rewardAmount});

  $DexFarmLockCopyWith<$Res>? get dexFarmLockInfo;
  $TransactionCopyWith<$Res>? get transactionWithdrawFarmLock;
  $FailureCopyWith<$Res>? get failure;
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class _$FarmLockWithdrawFormStateCopyWithImpl<$Res,
        $Val extends FarmLockWithdrawFormState>
    implements $FarmLockWithdrawFormStateCopyWith<$Res> {
  _$FarmLockWithdrawFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmLockInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmLockWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? depositIndex = null,
    Object? transactionWithdrawFarmLock = freezed,
    Object? failure = freezed,
    Object? farmAddress = freezed,
    Object? rewardToken = freezed,
    Object? lpTokenAddress = freezed,
    Object? finalAmountReward = freezed,
    Object? finalAmountWithdraw = freezed,
    Object? consentDateTime = freezed,
    Object? depositedAmount = freezed,
    Object? rewardAmount = freezed,
  }) {
    return _then(_value.copyWith(
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      dexFarmLockInfo: freezed == dexFarmLockInfo
          ? _value.dexFarmLockInfo
          : dexFarmLockInfo // ignore: cast_nullable_to_non_nullable
              as DexFarmLock?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmLockWithdrawOk: null == farmLockWithdrawOk
          ? _value.farmLockWithdrawOk
          : farmLockWithdrawOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      depositIndex: null == depositIndex
          ? _value.depositIndex
          : depositIndex // ignore: cast_nullable_to_non_nullable
              as int,
      transactionWithdrawFarmLock: freezed == transactionWithdrawFarmLock
          ? _value.transactionWithdrawFarmLock
          : transactionWithdrawFarmLock // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenAddress: freezed == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      finalAmountReward: freezed == finalAmountReward
          ? _value.finalAmountReward
          : finalAmountReward // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountWithdraw: freezed == finalAmountWithdraw
          ? _value.finalAmountWithdraw
          : finalAmountWithdraw // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depositedAmount: freezed == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexFarmLockCopyWith<$Res>? get dexFarmLockInfo {
    if (_value.dexFarmLockInfo == null) {
      return null;
    }

    return $DexFarmLockCopyWith<$Res>(_value.dexFarmLockInfo!, (value) {
      return _then(_value.copyWith(dexFarmLockInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transactionWithdrawFarmLock {
    if (_value.transactionWithdrawFarmLock == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionWithdrawFarmLock!,
        (value) {
      return _then(_value.copyWith(transactionWithdrawFarmLock: value) as $Val);
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
abstract class _$$FarmLockWithdrawFormStateImplCopyWith<$Res>
    implements $FarmLockWithdrawFormStateCopyWith<$Res> {
  factory _$$FarmLockWithdrawFormStateImplCopyWith(
          _$FarmLockWithdrawFormStateImpl value,
          $Res Function(_$FarmLockWithdrawFormStateImpl) then) =
      __$$FarmLockWithdrawFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexFarmLock? dexFarmLockInfo,
      bool isProcessInProgress,
      bool farmLockWithdrawOk,
      bool walletConfirmation,
      double amount,
      int depositIndex,
      Transaction? transactionWithdrawFarmLock,
      Failure? failure,
      String? farmAddress,
      DexToken? rewardToken,
      String? lpTokenAddress,
      double? finalAmountReward,
      double? finalAmountWithdraw,
      DateTime? consentDateTime,
      double? depositedAmount,
      double? rewardAmount});

  @override
  $DexFarmLockCopyWith<$Res>? get dexFarmLockInfo;
  @override
  $TransactionCopyWith<$Res>? get transactionWithdrawFarmLock;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$FarmLockWithdrawFormStateImplCopyWithImpl<$Res>
    extends _$FarmLockWithdrawFormStateCopyWithImpl<$Res,
        _$FarmLockWithdrawFormStateImpl>
    implements _$$FarmLockWithdrawFormStateImplCopyWith<$Res> {
  __$$FarmLockWithdrawFormStateImplCopyWithImpl(
      _$FarmLockWithdrawFormStateImpl _value,
      $Res Function(_$FarmLockWithdrawFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmLockInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmLockWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? depositIndex = null,
    Object? transactionWithdrawFarmLock = freezed,
    Object? failure = freezed,
    Object? farmAddress = freezed,
    Object? rewardToken = freezed,
    Object? lpTokenAddress = freezed,
    Object? finalAmountReward = freezed,
    Object? finalAmountWithdraw = freezed,
    Object? consentDateTime = freezed,
    Object? depositedAmount = freezed,
    Object? rewardAmount = freezed,
  }) {
    return _then(_$FarmLockWithdrawFormStateImpl(
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      dexFarmLockInfo: freezed == dexFarmLockInfo
          ? _value.dexFarmLockInfo
          : dexFarmLockInfo // ignore: cast_nullable_to_non_nullable
              as DexFarmLock?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmLockWithdrawOk: null == farmLockWithdrawOk
          ? _value.farmLockWithdrawOk
          : farmLockWithdrawOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      depositIndex: null == depositIndex
          ? _value.depositIndex
          : depositIndex // ignore: cast_nullable_to_non_nullable
              as int,
      transactionWithdrawFarmLock: freezed == transactionWithdrawFarmLock
          ? _value.transactionWithdrawFarmLock
          : transactionWithdrawFarmLock // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenAddress: freezed == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      finalAmountReward: freezed == finalAmountReward
          ? _value.finalAmountReward
          : finalAmountReward // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountWithdraw: freezed == finalAmountWithdraw
          ? _value.finalAmountWithdraw
          : finalAmountWithdraw // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depositedAmount: freezed == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$FarmLockWithdrawFormStateImpl extends _FarmLockWithdrawFormState {
  const _$FarmLockWithdrawFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.dexFarmLockInfo,
      this.isProcessInProgress = false,
      this.farmLockWithdrawOk = false,
      this.walletConfirmation = false,
      this.amount = 0.0,
      this.depositIndex = 0,
      this.transactionWithdrawFarmLock,
      this.failure,
      this.farmAddress,
      this.rewardToken,
      this.lpTokenAddress,
      this.finalAmountReward,
      this.finalAmountWithdraw,
      this.consentDateTime,
      this.depositedAmount,
      this.rewardAmount})
      : super._();

  @override
  @JsonKey()
  final ProcessStep processStep;
  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final int currentStep;
  @override
  final DexFarmLock? dexFarmLockInfo;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool farmLockWithdrawOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final int depositIndex;
  @override
  final Transaction? transactionWithdrawFarmLock;
  @override
  final Failure? failure;
  @override
  final String? farmAddress;
  @override
  final DexToken? rewardToken;
  @override
  final String? lpTokenAddress;
  @override
  final double? finalAmountReward;
  @override
  final double? finalAmountWithdraw;
  @override
  final DateTime? consentDateTime;
  @override
  final double? depositedAmount;
  @override
  final double? rewardAmount;

  @override
  String toString() {
    return 'FarmLockWithdrawFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, dexFarmLockInfo: $dexFarmLockInfo, isProcessInProgress: $isProcessInProgress, farmLockWithdrawOk: $farmLockWithdrawOk, walletConfirmation: $walletConfirmation, amount: $amount, depositIndex: $depositIndex, transactionWithdrawFarmLock: $transactionWithdrawFarmLock, failure: $failure, farmAddress: $farmAddress, rewardToken: $rewardToken, lpTokenAddress: $lpTokenAddress, finalAmountReward: $finalAmountReward, finalAmountWithdraw: $finalAmountWithdraw, consentDateTime: $consentDateTime, depositedAmount: $depositedAmount, rewardAmount: $rewardAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockWithdrawFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.dexFarmLockInfo, dexFarmLockInfo) ||
                other.dexFarmLockInfo == dexFarmLockInfo) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.farmLockWithdrawOk, farmLockWithdrawOk) ||
                other.farmLockWithdrawOk == farmLockWithdrawOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.depositIndex, depositIndex) ||
                other.depositIndex == depositIndex) &&
            (identical(other.transactionWithdrawFarmLock,
                    transactionWithdrawFarmLock) ||
                other.transactionWithdrawFarmLock ==
                    transactionWithdrawFarmLock) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress) &&
            (identical(other.finalAmountReward, finalAmountReward) ||
                other.finalAmountReward == finalAmountReward) &&
            (identical(other.finalAmountWithdraw, finalAmountWithdraw) ||
                other.finalAmountWithdraw == finalAmountWithdraw) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime) &&
            (identical(other.depositedAmount, depositedAmount) ||
                other.depositedAmount == depositedAmount) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        processStep,
        resumeProcess,
        currentStep,
        dexFarmLockInfo,
        isProcessInProgress,
        farmLockWithdrawOk,
        walletConfirmation,
        amount,
        depositIndex,
        transactionWithdrawFarmLock,
        failure,
        farmAddress,
        rewardToken,
        lpTokenAddress,
        finalAmountReward,
        finalAmountWithdraw,
        consentDateTime,
        depositedAmount,
        rewardAmount
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockWithdrawFormStateImplCopyWith<_$FarmLockWithdrawFormStateImpl>
      get copyWith => __$$FarmLockWithdrawFormStateImplCopyWithImpl<
          _$FarmLockWithdrawFormStateImpl>(this, _$identity);
}

abstract class _FarmLockWithdrawFormState extends FarmLockWithdrawFormState {
  const factory _FarmLockWithdrawFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final DexFarmLock? dexFarmLockInfo,
      final bool isProcessInProgress,
      final bool farmLockWithdrawOk,
      final bool walletConfirmation,
      final double amount,
      final int depositIndex,
      final Transaction? transactionWithdrawFarmLock,
      final Failure? failure,
      final String? farmAddress,
      final DexToken? rewardToken,
      final String? lpTokenAddress,
      final double? finalAmountReward,
      final double? finalAmountWithdraw,
      final DateTime? consentDateTime,
      final double? depositedAmount,
      final double? rewardAmount}) = _$FarmLockWithdrawFormStateImpl;
  const _FarmLockWithdrawFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  DexFarmLock? get dexFarmLockInfo;
  @override
  bool get isProcessInProgress;
  @override
  bool get farmLockWithdrawOk;
  @override
  bool get walletConfirmation;
  @override
  double get amount;
  @override
  int get depositIndex;
  @override
  Transaction? get transactionWithdrawFarmLock;
  @override
  Failure? get failure;
  @override
  String? get farmAddress;
  @override
  DexToken? get rewardToken;
  @override
  String? get lpTokenAddress;
  @override
  double? get finalAmountReward;
  @override
  double? get finalAmountWithdraw;
  @override
  DateTime? get consentDateTime;
  @override
  double? get depositedAmount;
  @override
  double? get rewardAmount;
  @override
  @JsonKey(ignore: true)
  _$$FarmLockWithdrawFormStateImplCopyWith<_$FarmLockWithdrawFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
