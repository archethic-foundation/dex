/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum SwapProcessStep { form, confirmation }

@freezed
class SwapFormState with _$SwapFormState {
  const factory SwapFormState({
    @Default(SwapProcessStep.form) SwapProcessStep swapProcessStep,
    @Default(false) bool resumeProcess,
    @Default(false) bool calculateAmountToSwap,
    @Default(false) bool calculateAmountSwapped,
    @Default(0) int currentStep,
    @Default(1) int tokenFormSelected,
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
    @Default(0.0) double swapFees,
    @Default(0.0) double swapProtocolFees,
    @Default(0.5) double slippageTolerance,
    @Default(0.0) double minToReceive,
    @Default(0.0) double priceImpact,
    @Default(0.0) double estimatedReceived,
    double? finalAmount,
    Failure? failure,
    Transaction? recoveryTransactionSwap,
    DexPool? pool,
  }) = _SwapFormState;
  const SwapFormState._();

  double get swapTotalFees => swapFees + swapProtocolFees;

  bool get isControlsOk =>
      tokenToSwap != null &&
      tokenSwapped != null &&
      tokenToSwapBalance > 0 &&
      tokenToSwapAmount > 0 &&
      tokenSwappedAmount > 0 &&
      tokenToSwap!.address != tokenSwapped!.address;

  @override
  double get tokenToSwapBalance => tokenToSwap!.balance;
}
