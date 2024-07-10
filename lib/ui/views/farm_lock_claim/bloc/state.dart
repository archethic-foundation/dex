/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmLockClaimFormState with _$FarmLockClaimFormState {
  const factory FarmLockClaimFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmLockClaimOk,
    @Default(false) bool walletConfirmation,
    Transaction? transactionClaimFarmLock,
    Failure? failure,
    double? finalAmount,
    String? farmAddress,
    DexToken? rewardToken,
    int? depositIndex,
    String? lpTokenAddress,
    DateTime? consentDateTime,
    double? rewardAmount,
  }) = _FarmLockClaimFormState;
  const FarmLockClaimFormState._();

  bool get isControlsOk =>
      failure == null && rewardAmount != null && rewardAmount! > 0;
}
