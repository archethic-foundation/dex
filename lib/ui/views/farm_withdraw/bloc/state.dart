/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum FarmWithdrawProcessStep { form, confirmation }

@freezed
class FarmWithdrawFormState with _$FarmWithdrawFormState {
  const factory FarmWithdrawFormState({
    @Default(FarmWithdrawProcessStep.form)
    FarmWithdrawProcessStep farmWithdrawProcessStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    DexFarm? dexFarmInfos,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmWithdrawOk,
    @Default(false) bool walletConfirmation,
    @Default(0.0) double amount,
    Transaction? transactionWithdrawFarm,
    @Default(0.0) double lpTokenDepositedBalance,
    Failure? failure,
  }) = _FarmWithdrawFormState;
  const FarmWithdrawFormState._();

  bool get isControlsOk => failure == null && amount > 0;
}
