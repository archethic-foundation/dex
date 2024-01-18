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
mixin _$FarmDepositFormState {
  FarmDepositProcessStep get farmDepositProcessStep =>
      throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexFarm? get dexFarmInfos => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmDepositOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Transaction? get transactionDepositFarm => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmDepositFormStateCopyWith<FarmDepositFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmDepositFormStateCopyWith<$Res> {
  factory $FarmDepositFormStateCopyWith(FarmDepositFormState value,
          $Res Function(FarmDepositFormState) then) =
      _$FarmDepositFormStateCopyWithImpl<$Res, FarmDepositFormState>;
  @useResult
  $Res call(
      {FarmDepositProcessStep farmDepositProcessStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarmInfos,
      bool isProcessInProgress,
      bool farmDepositOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionDepositFarm,
      Failure? failure});

  $DexFarmCopyWith<$Res>? get dexFarmInfos;
  $TransactionCopyWith<$Res>? get transactionDepositFarm;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$FarmDepositFormStateCopyWithImpl<$Res,
        $Val extends FarmDepositFormState>
    implements $FarmDepositFormStateCopyWith<$Res> {
  _$FarmDepositFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmDepositProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmInfos = freezed,
    Object? isProcessInProgress = null,
    Object? farmDepositOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionDepositFarm = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      farmDepositProcessStep: null == farmDepositProcessStep
          ? _value.farmDepositProcessStep
          : farmDepositProcessStep // ignore: cast_nullable_to_non_nullable
              as FarmDepositProcessStep,
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
      farmDepositOk: null == farmDepositOk
          ? _value.farmDepositOk
          : farmDepositOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDepositFarm: freezed == transactionDepositFarm
          ? _value.transactionDepositFarm
          : transactionDepositFarm // ignore: cast_nullable_to_non_nullable
              as Transaction?,
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
  $TransactionCopyWith<$Res>? get transactionDepositFarm {
    if (_value.transactionDepositFarm == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionDepositFarm!, (value) {
      return _then(_value.copyWith(transactionDepositFarm: value) as $Val);
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
abstract class _$$FarmDepositFormStateImplCopyWith<$Res>
    implements $FarmDepositFormStateCopyWith<$Res> {
  factory _$$FarmDepositFormStateImplCopyWith(_$FarmDepositFormStateImpl value,
          $Res Function(_$FarmDepositFormStateImpl) then) =
      __$$FarmDepositFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FarmDepositProcessStep farmDepositProcessStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarmInfos,
      bool isProcessInProgress,
      bool farmDepositOk,
      bool walletConfirmation,
      double amount,
      Transaction? transactionDepositFarm,
      Failure? failure});

  @override
  $DexFarmCopyWith<$Res>? get dexFarmInfos;
  @override
  $TransactionCopyWith<$Res>? get transactionDepositFarm;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$FarmDepositFormStateImplCopyWithImpl<$Res>
    extends _$FarmDepositFormStateCopyWithImpl<$Res, _$FarmDepositFormStateImpl>
    implements _$$FarmDepositFormStateImplCopyWith<$Res> {
  __$$FarmDepositFormStateImplCopyWithImpl(_$FarmDepositFormStateImpl _value,
      $Res Function(_$FarmDepositFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmDepositProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmInfos = freezed,
    Object? isProcessInProgress = null,
    Object? farmDepositOk = null,
    Object? walletConfirmation = null,
    Object? amount = null,
    Object? transactionDepositFarm = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$FarmDepositFormStateImpl(
      farmDepositProcessStep: null == farmDepositProcessStep
          ? _value.farmDepositProcessStep
          : farmDepositProcessStep // ignore: cast_nullable_to_non_nullable
              as FarmDepositProcessStep,
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
      farmDepositOk: null == farmDepositOk
          ? _value.farmDepositOk
          : farmDepositOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDepositFarm: freezed == transactionDepositFarm
          ? _value.transactionDepositFarm
          : transactionDepositFarm // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$FarmDepositFormStateImpl extends _FarmDepositFormState {
  const _$FarmDepositFormStateImpl(
      {this.farmDepositProcessStep = FarmDepositProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.dexFarmInfos,
      this.isProcessInProgress = false,
      this.farmDepositOk = false,
      this.walletConfirmation = false,
      this.amount = 0.0,
      this.transactionDepositFarm,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final FarmDepositProcessStep farmDepositProcessStep;
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
  final bool farmDepositOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  @JsonKey()
  final double amount;
  @override
  final Transaction? transactionDepositFarm;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'FarmDepositFormState(farmDepositProcessStep: $farmDepositProcessStep, resumeProcess: $resumeProcess, currentStep: $currentStep, dexFarmInfos: $dexFarmInfos, isProcessInProgress: $isProcessInProgress, farmDepositOk: $farmDepositOk, walletConfirmation: $walletConfirmation, amount: $amount, transactionDepositFarm: $transactionDepositFarm, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmDepositFormStateImpl &&
            (identical(other.farmDepositProcessStep, farmDepositProcessStep) ||
                other.farmDepositProcessStep == farmDepositProcessStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.dexFarmInfos, dexFarmInfos) ||
                other.dexFarmInfos == dexFarmInfos) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.farmDepositOk, farmDepositOk) ||
                other.farmDepositOk == farmDepositOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.transactionDepositFarm, transactionDepositFarm) ||
                other.transactionDepositFarm == transactionDepositFarm) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      farmDepositProcessStep,
      resumeProcess,
      currentStep,
      dexFarmInfos,
      isProcessInProgress,
      farmDepositOk,
      walletConfirmation,
      amount,
      transactionDepositFarm,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmDepositFormStateImplCopyWith<_$FarmDepositFormStateImpl>
      get copyWith =>
          __$$FarmDepositFormStateImplCopyWithImpl<_$FarmDepositFormStateImpl>(
              this, _$identity);
}

abstract class _FarmDepositFormState extends FarmDepositFormState {
  const factory _FarmDepositFormState(
      {final FarmDepositProcessStep farmDepositProcessStep,
      final bool resumeProcess,
      final int currentStep,
      final DexFarm? dexFarmInfos,
      final bool isProcessInProgress,
      final bool farmDepositOk,
      final bool walletConfirmation,
      final double amount,
      final Transaction? transactionDepositFarm,
      final Failure? failure}) = _$FarmDepositFormStateImpl;
  const _FarmDepositFormState._() : super._();

  @override
  FarmDepositProcessStep get farmDepositProcessStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  DexFarm? get dexFarmInfos;
  @override
  bool get isProcessInProgress;
  @override
  bool get farmDepositOk;
  @override
  bool get walletConfirmation;
  @override
  double get amount;
  @override
  Transaction? get transactionDepositFarm;
  @override
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$FarmDepositFormStateImplCopyWith<_$FarmDepositFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
