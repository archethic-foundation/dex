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
mixin _$FarmWithdrawFormState {
  FarmWithdrawProcessStep get farmWithdrawProcessStep =>
      throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexFarm? get dexFarmInfos => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmWithdrawOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Transaction? get transactionWithdrawFarm =>
      throw _privateConstructorUsedError;
  double get lpTokenDepositedBalance => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

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
      {FarmWithdrawProcessStep farmWithdrawProcessStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarmInfos,
      bool isProcessInProgress,
      bool farmWithdrawOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionWithdrawFarm,
      double lpTokenDepositedBalance,
      Failure? failure});

  $DexFarmCopyWith<$Res>? get dexFarmInfos;
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
    Object? farmWithdrawProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmInfos = freezed,
    Object? isProcessInProgress = null,
    Object? farmWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionWithdrawFarm = freezed,
    Object? lpTokenDepositedBalance = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      farmWithdrawProcessStep: null == farmWithdrawProcessStep
          ? _value.farmWithdrawProcessStep
          : farmWithdrawProcessStep // ignore: cast_nullable_to_non_nullable
              as FarmWithdrawProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      dexFarmInfos: freezed == dexFarmInfos
          ? _value.dexFarmInfos
          : dexFarmInfos // ignore: cast_nullable_to_non_nullable
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
      lpTokenDepositedBalance: null == lpTokenDepositedBalance
          ? _value.lpTokenDepositedBalance
          : lpTokenDepositedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexFarmCopyWith<$Res>? get dexFarmInfos {
    if (_value.dexFarmInfos == null) {
      return null;
    }

    return $DexFarmCopyWith<$Res>(_value.dexFarmInfos!, (value) {
      return _then(_value.copyWith(dexFarmInfos: value) as $Val);
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
      {FarmWithdrawProcessStep farmWithdrawProcessStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarmInfos,
      bool isProcessInProgress,
      bool farmWithdrawOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionWithdrawFarm,
      double lpTokenDepositedBalance,
      Failure? failure});

  @override
  $DexFarmCopyWith<$Res>? get dexFarmInfos;
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
    Object? farmWithdrawProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmInfos = freezed,
    Object? isProcessInProgress = null,
    Object? farmWithdrawOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionWithdrawFarm = freezed,
    Object? lpTokenDepositedBalance = null,
    Object? failure = freezed,
  }) {
    return _then(_$FarmWithdrawFormStateImpl(
      farmWithdrawProcessStep: null == farmWithdrawProcessStep
          ? _value.farmWithdrawProcessStep
          : farmWithdrawProcessStep // ignore: cast_nullable_to_non_nullable
              as FarmWithdrawProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      dexFarmInfos: freezed == dexFarmInfos
          ? _value.dexFarmInfos
          : dexFarmInfos // ignore: cast_nullable_to_non_nullable
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
      lpTokenDepositedBalance: null == lpTokenDepositedBalance
          ? _value.lpTokenDepositedBalance
          : lpTokenDepositedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$FarmWithdrawFormStateImpl extends _FarmWithdrawFormState {
  const _$FarmWithdrawFormStateImpl(
      {this.farmWithdrawProcessStep = FarmWithdrawProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.dexFarmInfos,
      this.isProcessInProgress = false,
      this.farmWithdrawOk = false,
      this.walletConfirmation = false,
      this.amount = 0.0,
      this.transactionWithdrawFarm,
      this.lpTokenDepositedBalance = 0.0,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final FarmWithdrawProcessStep farmWithdrawProcessStep;
  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final int currentStep;
  @override
  final DexFarm? dexFarmInfos;
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
  @JsonKey()
  final double lpTokenDepositedBalance;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'FarmWithdrawFormState(farmWithdrawProcessStep: $farmWithdrawProcessStep, resumeProcess: $resumeProcess, currentStep: $currentStep, dexFarmInfos: $dexFarmInfos, isProcessInProgress: $isProcessInProgress, farmWithdrawOk: $farmWithdrawOk, walletConfirmation: $walletConfirmation, amount: $amount, transactionWithdrawFarm: $transactionWithdrawFarm, lpTokenDepositedBalance: $lpTokenDepositedBalance, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmWithdrawFormStateImpl &&
            (identical(
                    other.farmWithdrawProcessStep, farmWithdrawProcessStep) ||
                other.farmWithdrawProcessStep == farmWithdrawProcessStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.dexFarmInfos, dexFarmInfos) ||
                other.dexFarmInfos == dexFarmInfos) &&
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
            (identical(
                    other.lpTokenDepositedBalance, lpTokenDepositedBalance) ||
                other.lpTokenDepositedBalance == lpTokenDepositedBalance) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      farmWithdrawProcessStep,
      resumeProcess,
      currentStep,
      dexFarmInfos,
      isProcessInProgress,
      farmWithdrawOk,
      walletConfirmation,
      amount,
      transactionWithdrawFarm,
      lpTokenDepositedBalance,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmWithdrawFormStateImplCopyWith<_$FarmWithdrawFormStateImpl>
      get copyWith => __$$FarmWithdrawFormStateImplCopyWithImpl<
          _$FarmWithdrawFormStateImpl>(this, _$identity);
}

abstract class _FarmWithdrawFormState extends FarmWithdrawFormState {
  const factory _FarmWithdrawFormState(
      {final FarmWithdrawProcessStep farmWithdrawProcessStep,
      final bool resumeProcess,
      final int currentStep,
      final DexFarm? dexFarmInfos,
      final bool isProcessInProgress,
      final bool farmWithdrawOk,
      final bool walletConfirmation,
      final double amount,
      final Transaction? transactionWithdrawFarm,
      final double lpTokenDepositedBalance,
      final Failure? failure}) = _$FarmWithdrawFormStateImpl;
  const _FarmWithdrawFormState._() : super._();

  @override
  FarmWithdrawProcessStep get farmWithdrawProcessStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  DexFarm? get dexFarmInfos;
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
  double get lpTokenDepositedBalance;
  @override
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$FarmWithdrawFormStateImplCopyWith<_$FarmWithdrawFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}