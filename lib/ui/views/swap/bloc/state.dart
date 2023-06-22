/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class SwapFormState with _$SwapFormState {
  const factory SwapFormState({
    @Default(0) int step,
    @Default('') String stepError,
    @Default('') String tokenToSwap,
    @Default(0) double tokenToSwapBalance,
    @Default(0) double tokenToSwapAmount,
    @Default(0) double tokenToSwapAmountFiat,
    @Default('') String tokenSwapped,
    @Default(0) double tokenSwappedBalance,
    @Default(0) double tokenSwappedAmount,
    @Default(0) double tokenSwappedAmountFiat,
    @Default('') String poolAddress,
    @Default(0.0) double networkFees,
    @Default(0.0) double networkFeesFiat,
    @Default(0.0) double swapFees,
    @Default(0.0) double swapFeesFiat,
    @Default(0.5) double slippageTolerance,
    @Default(false) bool expertMode,
    @Default(false) bool? controlInProgress,
    @Default('') String errorText,
  }) = _SwapFormState;
  const SwapFormState._();

  bool get isControlsOk => errorText == '';

  bool get canSwap => isControlsOk;
}
