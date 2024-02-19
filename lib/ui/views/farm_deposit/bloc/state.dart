/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmDepositFormState with _$FarmDepositFormState {
  const factory FarmDepositFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    DexFarm? dexFarmInfo,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmDepositOk,
    @Default(false) bool walletConfirmation,
    @Default(0.0) double amount,
    Transaction? transactionDepositFarm,
    @Default(0.0) double lpTokenBalance,
    Failure? failure,
    double? finalAmount,
  }) = _FarmDepositFormState;
  const FarmDepositFormState._();

  bool get isControlsOk => failure == null && amount > 0;
}
