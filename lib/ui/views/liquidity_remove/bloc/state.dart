/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum LiquidityRemoveProcessStep { form, confirmation }

@freezed
class LiquidityRemoveFormState with _$LiquidityRemoveFormState {
  const factory LiquidityRemoveFormState({
    @Default(LiquidityRemoveProcessStep.form)
    LiquidityRemoveProcessStep liquidityRemoveProcessStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    @Default('') String poolGenesisAddress,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool liquidityRemoveOk,
    @Default(false) bool walletConfirmation,
    DexToken? token1,
    DexToken? token2,
    DexToken? lpToken,
    @Default(0.0) double lpTokenBalance,
    @Default(0.0) double lpTokenAmount,
    @Default(0.0) double token1AmountGetBack,
    @Default(0.0) double token2AmountGetBack,
    @Default(0.0) double networkFees,
    Failure? failure,
  }) = _LiquidityRemoveFormState;
  const LiquidityRemoveFormState._();

  bool get isControlsOk =>
      failure == null && lpTokenBalance > 0 && lpTokenAmount > 0;
}
