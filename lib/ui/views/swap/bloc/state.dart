/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum SwapProcessStep { form, confirmation }

@freezed
class SwapFormState with _$SwapFormState {
  const factory SwapFormState({
    @Default(SwapProcessStep.form) SwapProcessStep swapProcessStep,
    @Default('') String poolGenesisAddress,
    DexToken? tokenToSwap,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool swapOk,
    @Default(false) bool walletConfirmation,
    @Default(0) double tokenToSwapBalance,
    @Default(0) double tokenToSwapAmount,
    DexToken? tokenSwapped,
    @Default(0) double tokenSwappedBalance,
    @Default(0) double tokenSwappedAmount,
    @Default(0.0) double ratio,
    @Default(0.0) double networkFees,
    @Default(0.0) double swapFees,
    @Default(0.5) double slippageTolerance,
    @Default(0.0) double minimumReceived,
    @Default(0.0) double priceImpact,
    @Default(0.0) double estimatedReceived,
    @Default(false) bool? controlInProgress,
    Failure? failure,
  }) = _SwapFormState;
  const SwapFormState._();

  bool get isControlsOk => failure == null;

  bool get canSwap => isControlsOk;

  @override
  double get tokenToSwapBalance => tokenToSwap!.balance;
}
