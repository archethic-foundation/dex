/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum LiquidityAddProcessStep { form, confirmation }

@freezed
class LiquidityAddFormState with _$LiquidityAddFormState {
  const factory LiquidityAddFormState({
    @Default(LiquidityAddProcessStep.form)
    LiquidityAddProcessStep liquidityAddProcessStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    @Default('') String poolGenesisAddress,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool liquidityAddOk,
    @Default(false) bool walletConfirmation,
    DexToken? token1,
    DexToken? token2,
    @Default(0.0) double ratio,
    @Default(0.5) double slippageTolerance,
    @Default(0.0) double token1Balance,
    @Default(0.0) double token1Amount,
    @Default(0.0) double token2Balance,
    @Default(0.0) double token2Amount,
    @Default(0.0) double token1minAmount,
    @Default(0.0) double token2minAmount,
    @Default(0.0) double networkFees,
    @Default(0.0) double expectedTokenLP,
    DexPool? pool,
    @Default(0.0) double lpTokenBalance,
    Transaction? transactionAddLiquidity,
    @Default(false) bool calculationInProgress,
    Failure? failure,
  }) = _LiquidityAddFormState;
  const LiquidityAddFormState._();

  bool get isControlsOk =>
      failure == null &&
      token1Balance > 0 &&
      token2Balance > 0 &&
      token1Amount > 0 &&
      token2Amount > 0;
}
