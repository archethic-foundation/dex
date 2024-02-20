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
mixin _$FarmClaimFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexFarmUserInfos? get dexFarmUserInfo => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmClaimOk => throw _privateConstructorUsedError;
  bool get walletConfirmation => throw _privateConstructorUsedError;
  Transaction? get transactionClaimFarm => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  double? get finalAmount => throw _privateConstructorUsedError;
  String? get farmAddress => throw _privateConstructorUsedError;
  DexToken? get rewardToken => throw _privateConstructorUsedError;
  String? get lpTokenAddress => throw _privateConstructorUsedError;

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
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexFarmUserInfos? dexFarmUserInfo,
      bool isProcessInProgress,
      bool farmClaimOk,
      bool walletConfirmation,
      Transaction? transactionClaimFarm,
      Failure? failure,
      double? finalAmount,
      String? farmAddress,
      DexToken? rewardToken,
      String? lpTokenAddress});

  $DexFarmUserInfosCopyWith<$Res>? get dexFarmUserInfo;
  $TransactionCopyWith<$Res>? get transactionClaimFarm;
  $FailureCopyWith<$Res>? get failure;
  $DexTokenCopyWith<$Res>? get rewardToken;
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
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmUserInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmClaimOk = null,
    Object? walletConfirmation = null,
    Object? transactionClaimFarm = freezed,
    Object? failure = freezed,
    Object? finalAmount = freezed,
    Object? farmAddress = freezed,
    Object? rewardToken = freezed,
    Object? lpTokenAddress = freezed,
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
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
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
    ) as $Val);
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
abstract class _$$FarmClaimFormStateImplCopyWith<$Res>
    implements $FarmClaimFormStateCopyWith<$Res> {
  factory _$$FarmClaimFormStateImplCopyWith(_$FarmClaimFormStateImpl value,
          $Res Function(_$FarmClaimFormStateImpl) then) =
      __$$FarmClaimFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexFarmUserInfos? dexFarmUserInfo,
      bool isProcessInProgress,
      bool farmClaimOk,
      bool walletConfirmation,
      Transaction? transactionClaimFarm,
      Failure? failure,
      double? finalAmount,
      String? farmAddress,
      DexToken? rewardToken,
      String? lpTokenAddress});

  @override
  $DexFarmUserInfosCopyWith<$Res>? get dexFarmUserInfo;
  @override
  $TransactionCopyWith<$Res>? get transactionClaimFarm;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
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
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? dexFarmUserInfo = freezed,
    Object? isProcessInProgress = null,
    Object? farmClaimOk = null,
    Object? walletConfirmation = null,
    Object? transactionClaimFarm = freezed,
    Object? failure = freezed,
    Object? finalAmount = freezed,
    Object? farmAddress = freezed,
    Object? rewardToken = freezed,
    Object? lpTokenAddress = freezed,
  }) {
    return _then(_$FarmClaimFormStateImpl(
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
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
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
    ));
  }
}

/// @nodoc

class _$FarmClaimFormStateImpl extends _FarmClaimFormState {
  const _$FarmClaimFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.dexFarmUserInfo,
      this.isProcessInProgress = false,
      this.farmClaimOk = false,
      this.walletConfirmation = false,
      this.transactionClaimFarm,
      this.failure,
      this.finalAmount,
      this.farmAddress,
      this.rewardToken,
      this.lpTokenAddress})
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
  final double? finalAmount;
  @override
  final String? farmAddress;
  @override
  final DexToken? rewardToken;
  @override
  final String? lpTokenAddress;

  @override
  String toString() {
    return 'FarmClaimFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, dexFarmUserInfo: $dexFarmUserInfo, isProcessInProgress: $isProcessInProgress, farmClaimOk: $farmClaimOk, walletConfirmation: $walletConfirmation, transactionClaimFarm: $transactionClaimFarm, failure: $failure, finalAmount: $finalAmount, farmAddress: $farmAddress, rewardToken: $rewardToken, lpTokenAddress: $lpTokenAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmClaimFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
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
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      processStep,
      resumeProcess,
      currentStep,
      dexFarmUserInfo,
      isProcessInProgress,
      farmClaimOk,
      walletConfirmation,
      transactionClaimFarm,
      failure,
      finalAmount,
      farmAddress,
      rewardToken,
      lpTokenAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmClaimFormStateImplCopyWith<_$FarmClaimFormStateImpl> get copyWith =>
      __$$FarmClaimFormStateImplCopyWithImpl<_$FarmClaimFormStateImpl>(
          this, _$identity);
}

abstract class _FarmClaimFormState extends FarmClaimFormState {
  const factory _FarmClaimFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final DexFarmUserInfos? dexFarmUserInfo,
      final bool isProcessInProgress,
      final bool farmClaimOk,
      final bool walletConfirmation,
      final Transaction? transactionClaimFarm,
      final Failure? failure,
      final double? finalAmount,
      final String? farmAddress,
      final DexToken? rewardToken,
      final String? lpTokenAddress}) = _$FarmClaimFormStateImpl;
  const _FarmClaimFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
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
  double? get finalAmount;
  @override
  String? get farmAddress;
  @override
  DexToken? get rewardToken;
  @override
  String? get lpTokenAddress;
  @override
  @JsonKey(ignore: true)
  _$$FarmClaimFormStateImplCopyWith<_$FarmClaimFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
