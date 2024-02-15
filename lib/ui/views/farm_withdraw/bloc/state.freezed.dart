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
  DexFarmUserInfos? get dexFarmUserInfo => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmWithdrawOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Transaction? get transactionWithdrawFarm =>
      throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  double? get finalAmount => throw _privateConstructorUsedError;

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
      DexFarmUserInfos? dexFarmUserInfo,
      bool isProcessInProgress,
      bool farmWithdrawOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionWithdrawFarm,
      Failure? failure,
      double? finalAmount});

  $DexFarmCopyWith<$Res>? get dexFarmInfo;
  $DexFarmUserInfosCopyWith<$Res>? get dexFarmUserInfo;
  $TransactionCopyWith<$Res>? get transactionWithdrawFarm;
  $FailureCopyWith<$Res>? get failure;
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
    Object? dexFarmUserInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionWithdrawFarm = freezed,
    Object? failure = freezed,
    Object? finalAmount = freezed,
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
      dexFarmUserInfo: freezed == dexFarmUserInfo
          ? _value.dexFarmUserInfo
          : dexFarmUserInfo // ignore: cast_nullable_to_non_nullable
              as DexFarmUserInfos?,
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
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
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
  $DexFarmUserInfosCopyWith<$Res>? get dexFarmUserInfo {
    if (_value.dexFarmUserInfo == null) {
      return null;
    }

    return $DexFarmUserInfosCopyWith<$Res>(_value.dexFarmUserInfo!, (value) {
      return _then(_value.copyWith(dexFarmUserInfo: value) as $Val);
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
      DexFarmUserInfos? dexFarmUserInfo,
      bool isProcessInProgress,
      bool farmWithdrawOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionWithdrawFarm,
      Failure? failure,
      double? finalAmount});

  @override
  $DexFarmCopyWith<$Res>? get dexFarmInfo;
  @override
  $DexFarmUserInfosCopyWith<$Res>? get dexFarmUserInfo;
  @override
  $TransactionCopyWith<$Res>? get transactionWithdrawFarm;
  @override
  $FailureCopyWith<$Res>? get failure;
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
    Object? dexFarmUserInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionWithdrawFarm = freezed,
    Object? failure = freezed,
    Object? finalAmount = freezed,
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
      dexFarmUserInfo: freezed == dexFarmUserInfo
          ? _value.dexFarmUserInfo
          : dexFarmUserInfo // ignore: cast_nullable_to_non_nullable
              as DexFarmUserInfos?,
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
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
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
      this.dexFarmUserInfo,
      this.isProcessInProgress = false,
      this.farmWithdrawOk = false,
      this.walletConfirmation = false,
      this.amount = 0.0,
      this.transactionWithdrawFarm,
      this.failure,
      this.finalAmount})
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
  final DexFarmUserInfos? dexFarmUserInfo;
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
  final double? finalAmount;

  @override
  String toString() {
    return 'FarmWithdrawFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, dexFarmInfo: $dexFarmInfo, dexFarmUserInfo: $dexFarmUserInfo, isProcessInProgress: $isProcessInProgress, farmWithdrawOk: $farmWithdrawOk, walletConfirmation: $walletConfirmation, amount: $amount, transactionWithdrawFarm: $transactionWithdrawFarm, failure: $failure, finalAmount: $finalAmount)';
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
            (identical(other.dexFarmUserInfo, dexFarmUserInfo) ||
                other.dexFarmUserInfo == dexFarmUserInfo) &&
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
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      processStep,
      resumeProcess,
      currentStep,
      dexFarmInfo,
      dexFarmUserInfo,
      isProcessInProgress,
      farmWithdrawOk,
      walletConfirmation,
      amount,
      transactionWithdrawFarm,
      failure,
      finalAmount);

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
      final DexFarmUserInfos? dexFarmUserInfo,
      final bool isProcessInProgress,
      final bool farmWithdrawOk,
      final bool walletConfirmation,
      final double amount,
      final Transaction? transactionWithdrawFarm,
      final Failure? failure,
      final double? finalAmount}) = _$FarmWithdrawFormStateImpl;
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
  DexFarmUserInfos? get dexFarmUserInfo;
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
  double? get finalAmount;
  @override
  @JsonKey(ignore: true)
  _$$FarmWithdrawFormStateImplCopyWith<_$FarmWithdrawFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
