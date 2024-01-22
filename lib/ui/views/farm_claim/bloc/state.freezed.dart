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
mixin _$FarmClaimFormState {
  FarmClaimProcessStep get farmClaimProcessStep =>
      throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexFarm? get dexFarm => throw _privateConstructorUsedError;
  DexFarmUserInfos? get dexFarmUserInfo => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmClaimOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  Transaction? get transactionClaimFarm => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmClaimFormStateCopyWith<FarmClaimFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmClaimFormStateCopyWith<$Res> {
  factory $FarmClaimFormStateCopyWith(
          FarmClaimFormState value, $Res Function(FarmClaimFormState) then) =
      _$FarmClaimFormStateCopyWithImpl<$Res, FarmClaimFormState>;
  @useResult
  $Res call(
      {FarmClaimProcessStep farmClaimProcessStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarm,
      DexFarmUserInfos? dexFarmUserInfo,
      bool isProcessInProgress,
      bool farmClaimOk,
      bool walletConfirmation,
      Transaction? transactionClaimFarm,
      Failure? failure});

  $DexFarmCopyWith<$Res>? get dexFarm;
  $DexFarmUserInfosCopyWith<$Res>? get dexFarmUserInfo;
  $TransactionCopyWith<$Res>? get transactionClaimFarm;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$FarmClaimFormStateCopyWithImpl<$Res, $Val extends FarmClaimFormState>
    implements $FarmClaimFormStateCopyWith<$Res> {
  _$FarmClaimFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmClaimProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarm = freezed,
    Object? dexFarmUserInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmClaimOk = null,
    Object? walletConfirmation = null,
    Object? transactionClaimFarm = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      farmClaimProcessStep: null == farmClaimProcessStep
          ? _value.farmClaimProcessStep
          : farmClaimProcessStep // ignore: cast_nullable_to_non_nullable
              as FarmClaimProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      dexFarm: freezed == dexFarm
          ? _value.dexFarm
          : dexFarm // ignore: cast_nullable_to_non_nullable
              as DexFarm?,
      dexFarmUserInfo: freezed == dexFarmUserInfo
          ? _value.dexFarmUserInfo
          : dexFarmUserInfo // ignore: cast_nullable_to_non_nullable
              as DexFarmUserInfos?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmClaimOk: null == farmClaimOk
          ? _value.farmClaimOk
          : farmClaimOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionClaimFarm: freezed == transactionClaimFarm
          ? _value.transactionClaimFarm
          : transactionClaimFarm // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexFarmCopyWith<$Res>? get dexFarm {
    if (_value.dexFarm == null) {
      return null;
    }

    return $DexFarmCopyWith<$Res>(_value.dexFarm!, (value) {
      return _then(_value.copyWith(dexFarm: value) as $Val);
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
  $TransactionCopyWith<$Res>? get transactionClaimFarm {
    if (_value.transactionClaimFarm == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionClaimFarm!, (value) {
      return _then(_value.copyWith(transactionClaimFarm: value) as $Val);
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
abstract class _$$FarmClaimFormStateImplCopyWith<$Res>
    implements $FarmClaimFormStateCopyWith<$Res> {
  factory _$$FarmClaimFormStateImplCopyWith(_$FarmClaimFormStateImpl value,
          $Res Function(_$FarmClaimFormStateImpl) then) =
      __$$FarmClaimFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FarmClaimProcessStep farmClaimProcessStep,
      bool resumeProcess,
      int currentStep,
      DexFarm? dexFarm,
      DexFarmUserInfos? dexFarmUserInfo,
      bool isProcessInProgress,
      bool farmClaimOk,
      bool walletConfirmation,
      Transaction? transactionClaimFarm,
      Failure? failure});

  @override
  $DexFarmCopyWith<$Res>? get dexFarm;
  @override
  $DexFarmUserInfosCopyWith<$Res>? get dexFarmUserInfo;
  @override
  $TransactionCopyWith<$Res>? get transactionClaimFarm;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$FarmClaimFormStateImplCopyWithImpl<$Res>
    extends _$FarmClaimFormStateCopyWithImpl<$Res, _$FarmClaimFormStateImpl>
    implements _$$FarmClaimFormStateImplCopyWith<$Res> {
  __$$FarmClaimFormStateImplCopyWithImpl(_$FarmClaimFormStateImpl _value,
      $Res Function(_$FarmClaimFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmClaimProcessStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarm = freezed,
    Object? dexFarmUserInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmClaimOk = null,
    Object? walletConfirmation = null,
    Object? transactionClaimFarm = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$FarmClaimFormStateImpl(
      farmClaimProcessStep: null == farmClaimProcessStep
          ? _value.farmClaimProcessStep
          : farmClaimProcessStep // ignore: cast_nullable_to_non_nullable
              as FarmClaimProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      dexFarm: freezed == dexFarm
          ? _value.dexFarm
          : dexFarm // ignore: cast_nullable_to_non_nullable
              as DexFarm?,
      dexFarmUserInfo: freezed == dexFarmUserInfo
          ? _value.dexFarmUserInfo
          : dexFarmUserInfo // ignore: cast_nullable_to_non_nullable
              as DexFarmUserInfos?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmClaimOk: null == farmClaimOk
          ? _value.farmClaimOk
          : farmClaimOk // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: null == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionClaimFarm: freezed == transactionClaimFarm
          ? _value.transactionClaimFarm
          : transactionClaimFarm // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$FarmClaimFormStateImpl extends _FarmClaimFormState {
  const _$FarmClaimFormStateImpl(
      {this.farmClaimProcessStep = FarmClaimProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.dexFarm,
      this.dexFarmUserInfo,
      this.isProcessInProgress = false,
      this.farmClaimOk = false,
      this.walletConfirmation = false,
      this.transactionClaimFarm,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final FarmClaimProcessStep farmClaimProcessStep;
  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final int currentStep;
  @override
  final DexFarm? dexFarm;
  @override
  final DexFarmUserInfos? dexFarmUserInfo;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool farmClaimOk;
  @override
  @JsonKey()
  final bool walletConfirmation;
  @override
  final Transaction? transactionClaimFarm;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'FarmClaimFormState(farmClaimProcessStep: $farmClaimProcessStep, resumeProcess: $resumeProcess, currentStep: $currentStep, dexFarm: $dexFarm, dexFarmUserInfo: $dexFarmUserInfo, isProcessInProgress: $isProcessInProgress, farmClaimOk: $farmClaimOk, walletConfirmation: $walletConfirmation, transactionClaimFarm: $transactionClaimFarm, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmClaimFormStateImpl &&
            (identical(other.farmClaimProcessStep, farmClaimProcessStep) ||
                other.farmClaimProcessStep == farmClaimProcessStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.dexFarm, dexFarm) || other.dexFarm == dexFarm) &&
            (identical(other.dexFarmUserInfo, dexFarmUserInfo) ||
                other.dexFarmUserInfo == dexFarmUserInfo) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.farmClaimOk, farmClaimOk) ||
                other.farmClaimOk == farmClaimOk) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.transactionClaimFarm, transactionClaimFarm) ||
                other.transactionClaimFarm == transactionClaimFarm) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      farmClaimProcessStep,
      resumeProcess,
      currentStep,
      dexFarm,
      dexFarmUserInfo,
      isProcessInProgress,
      farmClaimOk,
      walletConfirmation,
      transactionClaimFarm,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmClaimFormStateImplCopyWith<_$FarmClaimFormStateImpl> get copyWith =>
      __$$FarmClaimFormStateImplCopyWithImpl<_$FarmClaimFormStateImpl>(
          this, _$identity);
}

abstract class _FarmClaimFormState extends FarmClaimFormState {
  const factory _FarmClaimFormState(
      {final FarmClaimProcessStep farmClaimProcessStep,
      final bool resumeProcess,
      final int currentStep,
      final DexFarm? dexFarm,
      final DexFarmUserInfos? dexFarmUserInfo,
      final bool isProcessInProgress,
      final bool farmClaimOk,
      final bool walletConfirmation,
      final Transaction? transactionClaimFarm,
      final Failure? failure}) = _$FarmClaimFormStateImpl;
  const _FarmClaimFormState._() : super._();

  @override
  FarmClaimProcessStep get farmClaimProcessStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  DexFarm? get dexFarm;
  @override
  DexFarmUserInfos? get dexFarmUserInfo;
  @override
  bool get isProcessInProgress;
  @override
  bool get farmClaimOk;
  @override
  bool get walletConfirmation;
  @override
  Transaction? get transactionClaimFarm;
  @override
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$FarmClaimFormStateImplCopyWith<_$FarmClaimFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
