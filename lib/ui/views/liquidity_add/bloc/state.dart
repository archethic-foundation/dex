/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum LiquidityAddProcessStep { form, confirmation }

@freezed
class LiquidityAddFormState with _$LiquidityAddFormState {
  const factory LiquidityAddFormState({
    @Default(LiquidityAddProcessStep.form)
    LiquidityAddProcessStep liquidityAddProcessStep,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool liquidityAddOk,
    @Default(false) bool walletConfirmation,
    DexToken? token1,
    DexToken? token2,
    @Default(2.0) double slippage,
    @Default(0.0) double token1Balance,
    @Default(0.0) double token1Amount,
    @Default(0.0) double token2Balance,
    @Default(0.0) double token2Amount,
    @Default(0.0) double networkFees,
    Failure? failure,
  }) = _LiquidityAddFormState;
  const LiquidityAddFormState._();

  bool get isControlsOk => failure == null;
}