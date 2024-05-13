/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmClaimFormState with _$FarmClaimFormState {
  const factory FarmClaimFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmClaimOk,
    @Default(false) bool walletConfirmation,
    Transaction? transactionClaimFarm,
    Failure? failure,
    double? finalAmount,
    String? farmAddress,
    DexToken? rewardToken,
    String? lpTokenAddress,
    DateTime? consentDateTime,
    double? rewardAmount,
  }) = _FarmClaimFormState;
  const FarmClaimFormState._();

  bool get isControlsOk =>
      failure == null && rewardAmount != null && rewardAmount! > 0;
}
