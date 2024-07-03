/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmLockDepositFormState with _$FarmLockDepositFormState {
  const factory FarmLockDepositFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    DexPool? pool,
    DexFarmLock? farmLock,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmLockDepositOk,
    @Default(false) bool walletConfirmation,
    @Default(0.0) double amount,
    double? aprEstimation,
    @Default(FarmLockDepositDurationType.threeYears)
    FarmLockDepositDurationType farmLockDepositDuration,
    @Default(0.0) double lpTokenBalance,
    Transaction? transactionFarmLockDeposit,
    Failure? failure,
    double? finalAmount,
    DateTime? consentDateTime,
    @Default(PoolsListTab.verified) PoolsListTab poolsListTab,
  }) = _FarmLockDepositFormState;
  const FarmLockDepositFormState._();

  bool get isControlsOk => failure == null && amount > 0;
}
