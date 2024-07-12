/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmLockWithdrawFormState with _$FarmLockWithdrawFormState {
  const factory FarmLockWithdrawFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmLockWithdrawOk,
    @Default(false) bool walletConfirmation,
    @Default(0.0) double amount,
    @Default(0) int depositIndex,
    Transaction? transactionWithdrawFarmLock,
    Failure? failure,
    String? farmAddress,
    DexToken? rewardToken,
    DexToken? lpToken,
    DexPair? lpTokenPair,
    double? finalAmountReward,
    double? finalAmountWithdraw,
    DateTime? consentDateTime,
    double? depositedAmount,
    double? rewardAmount,
    String? poolAddress,
    DateTime? endDate,
  }) = _FarmLockWithdrawFormState;
  const FarmLockWithdrawFormState._();

  bool get isControlsOk => failure == null && amount > 0;

  bool get isFarmClose =>
      endDate != null && endDate!.isBefore(DateTime.now().toUtc());
}
