/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/model/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class SwapFormState with _$SwapFormState {
  const factory SwapFormState({
    @Default(0) int step,
    @Default('') String stepError,
    DexToken? tokenToSwap,
    @Default(0) double tokenToSwapBalance,
    @Default(0) double tokenToSwapAmount,
    @Default(0) double tokenToSwapAmountFiat,
    DexToken? tokenSwapped,
    @Default(0) double tokenSwappedBalance,
    @Default(0) double tokenSwappedAmount,
    @Default(0) double tokenSwappedAmountFiat,
    @Default(
      '0000BD123724608AFB6B52B193585A9EB8DA9680315DC2C55621AFAE8C65796CF3C8',
    )
    String poolAddress,
    @Default(0.0) double networkFees,
    @Default(0.0) double networkFeesFiat,
    @Default(0.0) double swapFees,
    @Default(0.0) double swapFeesFiat,
    @Default(0.5) double slippageTolerance,
    @Default(false) bool expertMode,
    @Default(0.0) double minimumReceived,
    @Default(0.0) double priceImpact,
    @Default(0.0) double estimatedReceived,
    @Default(false) bool? controlInProgress,
    @Default('') String errorText,
  }) = _SwapFormState;
  const SwapFormState._();

  bool get isControlsOk => errorText == '';

  bool get canSwap => isControlsOk;

  @override
  double get tokenToSwapBalance => tokenToSwap!.balance;
}
