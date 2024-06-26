/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PoolAddFormState with _$PoolAddFormState {
  const factory PoolAddFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    @Default(1) int tokenFormSelected,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool poolAddOk,
    @Default(false) bool walletConfirmation,
    @Default(false) bool messageMaxHalfUCO,
    DexToken? token1,
    DexToken? token2,
    @Default(2.0) double slippage,
    @Default(0.0) double token1Balance,
    @Default(0.0) double token1Amount,
    @Default(0.0) double token2Balance,
    @Default(0.0) double token2Amount,
    @Default(0.0) double networkFees,
    Transaction? recoveryTransactionAddPool,
    Transaction? recoveryTransactionAddPoolTransfer,
    Transaction? recoveryTransactionAddPoolLiquidity,
    String? recoveryPoolGenesisAddress,
    Failure? failure,
    DateTime? consentDateTime,
    @Default(PoolsListTab.verified) PoolsListTab poolsListTab,
  }) = _PoolAddFormState;
  const PoolAddFormState._();

  bool get isControlsOk =>
      token1 != null &&
      token2 != null &&
      token1Balance > 0 &&
      token2Balance > 0 &&
      token1Amount > 0 &&
      token2Amount > 0;
}
