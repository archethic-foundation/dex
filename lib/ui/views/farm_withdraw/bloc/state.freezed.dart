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
mixin _$FarmWithdrawFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexFarm? get dexFarmInfo => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmWithdrawOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Transaction? get transactionWithdrawFarm =>
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
  $FarmWithdrawFormStateCopyWith<FarmWithdrawFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmWithdrawFormStateCopyWith<$Res> {
  factory $FarmWithdrawFormStateCopyWith(FarmWithdrawFormState value,
          $Res Function(FarmWithdrawFormState) then) =
      _$FarmWithdrawFormStateCopyWithImpl<$Res, FarmWithdrawFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarmInfo,
      bool isProcessInProgress,
      bool farmWithdrawOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionWithdrawFarm,
      Failure? failure,
      String? farmAddress,
      DexToken? rewardToken,
      String? lpTokenAddress,
      double? finalAmountReward,
      double? finalAmountWithdraw,
      DateTime? consentDateTime,
      double? depositedAmount,
      double? rewardAmount});

  $DexFarmCopyWith<$Res>? get dexFarmInfo;
  $TransactionCopyWith<$Res>? get transactionWithdrawFarm;
  $FailureCopyWith<$Res>? get failure;
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class _$FarmWithdrawFormStateCopyWithImpl<$Res,
        $Val extends FarmWithdrawFormState>
    implements $FarmWithdrawFormStateCopyWith<$Res> {
  _$FarmWithdrawFormStateCopyWithImpl(this._value, this._then);

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
    Object? dexFarmInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionWithdrawFarm = freezed,
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
      dexFarmInfo: freezed == dexFarmInfo
          ? _value.dexFarmInfo
          : dexFarmInfo // ignore: cast_nullable_to_non_nullable
              as DexFarm?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmWithdrawOk: null == farmWithdrawOk
          ? _value.farmWithdrawOk
          : farmWithdrawOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionWithdrawFarm: freezed == transactionWithdrawFarm
          ? _value.transactionWithdrawFarm
          : transactionWithdrawFarm // ignore: cast_nullable_to_non_nullable
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
  $DexFarmCopyWith<$Res>? get dexFarmInfo {
    if (_value.dexFarmInfo == null) {
      return null;
    }

    return $DexFarmCopyWith<$Res>(_value.dexFarmInfo!, (value) {
      return _then(_value.copyWith(dexFarmInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transactionWithdrawFarm {
    if (_value.transactionWithdrawFarm == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionWithdrawFarm!, (value) {
      return _then(_value.copyWith(transactionWithdrawFarm: value) as $Val);
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
abstract class _$$FarmWithdrawFormStateImplCopyWith<$Res>
    implements $FarmWithdrawFormStateCopyWith<$Res> {
  factory _$$FarmWithdrawFormStateImplCopyWith(
          _$FarmWithdrawFormStateImpl value,
          $Res Function(_$FarmWithdrawFormStateImpl) then) =
      __$$FarmWithdrawFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarmInfo,
      bool isProcessInProgress,
      bool farmWithdrawOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionWithdrawFarm,
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
  $DexFarmCopyWith<$Res>? get dexFarmInfo;
  @override
  $TransactionCopyWith<$Res>? get transactionWithdrawFarm;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$FarmWithdrawFormStateImplCopyWithImpl<$Res>
    extends _$FarmWithdrawFormStateCopyWithImpl<$Res,
        _$FarmWithdrawFormStateImpl>
    implements _$$FarmWithdrawFormStateImplCopyWith<$Res> {
  __$$FarmWithdrawFormStateImplCopyWithImpl(_$FarmWithdrawFormStateImpl _value,
      $Res Function(_$FarmWithdrawFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionWithdrawFarm = freezed,
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
    return _then(_$FarmWithdrawFormStateImpl(
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
      dexFarmInfo: freezed == dexFarmInfo
          ? _value.dexFarmInfo
          : dexFarmInfo // ignore: cast_nullable_to_non_nullable
              as DexFarm?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmWithdrawOk: null == farmWithdrawOk
          ? _value.farmWithdrawOk
          : farmWithdrawOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionWithdrawFarm: freezed == transactionWithdrawFarm
          ? _value.transactionWithdrawFarm
          : transactionWithdrawFarm // ignore: cast_nullable_to_non_nullable
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

class _$FarmWithdrawFormStateImpl extends _FarmWithdrawFormState {
  const _$FarmWithdrawFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.dexFarmInfo,
      this.isProcessInProgress = false,
      this.farmWithdrawOk = false,
      this.walletConfirmation = false,
      this.amount = 0.0,
      this.transactionWithdrawFarm,
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
  final DexFarm? dexFarmInfo;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool farmWithdrawOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  @JsonKey()
  final double amount;
  @override
  final Transaction? transactionWithdrawFarm;
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
    return 'FarmWithdrawFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, dexFarmInfo: $dexFarmInfo, isProcessInProgress: $isProcessInProgress, farmWithdrawOk: $farmWithdrawOk, walletConfirmation: $walletConfirmation, amount: $amount, transactionWithdrawFarm: $transactionWithdrawFarm, failure: $failure, farmAddress: $farmAddress, rewardToken: $rewardToken, lpTokenAddress: $lpTokenAddress, finalAmountReward: $finalAmountReward, finalAmountWithdraw: $finalAmountWithdraw, consentDateTime: $consentDateTime, depositedAmount: $depositedAmount, rewardAmount: $rewardAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmWithdrawFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.dexFarmInfo, dexFarmInfo) ||
                other.dexFarmInfo == dexFarmInfo) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.farmWithdrawOk, farmWithdrawOk) ||
                other.farmWithdrawOk == farmWithdrawOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(
                    other.transactionWithdrawFarm, transactionWithdrawFarm) ||
                other.transactionWithdrawFarm == transactionWithdrawFarm) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      processStep,
      resumeProcess,
      currentStep,
      dexFarmInfo,
      isProcessInProgress,
      farmWithdrawOk,
      walletConfirmation,
      amount,
      transactionWithdrawFarm,
      failure,
      farmAddress,
      rewardToken,
      lpTokenAddress,
      finalAmountReward,
      finalAmountWithdraw,
      consentDateTime,
      depositedAmount,
      rewardAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmWithdrawFormStateImplCopyWith<_$FarmWithdrawFormStateImpl>
      get copyWith => __$$FarmWithdrawFormStateImplCopyWithImpl<
          _$FarmWithdrawFormStateImpl>(this, _$identity);
}

abstract class _FarmWithdrawFormState extends FarmWithdrawFormState {
  const factory _FarmWithdrawFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final DexFarm? dexFarmInfo,
      final bool isProcessInProgress,
      final bool farmWithdrawOk,
      final bool walletConfirmation,
      final double amount,
      final Transaction? transactionWithdrawFarm,
      final Failure? failure,
      final String? farmAddress,
      final DexToken? rewardToken,
      final String? lpTokenAddress,
      final double? finalAmountReward,
      final double? finalAmountWithdraw,
      final DateTime? consentDateTime,
      final double? depositedAmount,
      final double? rewardAmount}) = _$FarmWithdrawFormStateImpl;
  const _FarmWithdrawFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  DexFarm? get dexFarmInfo;
  @override
  bool get isProcessInProgress;
  @override
  bool get farmWithdrawOk;
  @override
  bool get walletConfirmation;
  @override
  double get amount;
  @override
  Transaction? get transactionWithdrawFarm;
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
  _$$FarmWithdrawFormStateImplCopyWith<_$FarmWithdrawFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
