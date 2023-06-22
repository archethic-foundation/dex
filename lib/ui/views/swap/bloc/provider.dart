import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _swapFormProvider =
    NotifierProvider.autoDispose<SwapFormNotifier, SwapFormState>(
  () {
    return SwapFormNotifier();
  },
);

class SwapFormNotifier extends AutoDisposeNotifier<SwapFormState> {
  SwapFormNotifier();

  @override
  SwapFormState build() => const SwapFormState();

  void setTokenToSwap(
    String tokenToSwap,
  ) {
    state = state.copyWith(
      tokenToSwap: tokenToSwap,
    );
    return;
  }

  Future<void> setTokenToSwapAmount(
    double tokenToSwapAmount,
  ) async {
    final oracleUcoPrice = await sl.get<OracleService>().getOracleData();

    state = state.copyWith(
      tokenToSwapAmount: tokenToSwapAmount,
      tokenToSwapAmountFiat: tokenToSwapAmount * (oracleUcoPrice.uco?.usd ?? 0),
    );
    return;
  }

  Future<void> setTokenSwappedAmount(
    double tokenSwappedAmount,
  ) async {
    final oracleUcoPrice = await sl.get<OracleService>().getOracleData();

    state = state.copyWith(
      tokenSwappedAmount: tokenSwappedAmount,
      tokenSwappedAmountFiat:
          tokenSwappedAmount * (oracleUcoPrice.uco?.usd ?? 0),
    );
    return;
  }

  void setTokenSwapped(
    String tokenSwapped,
  ) {
    state = state.copyWith(
      tokenSwapped: tokenSwapped,
    );
  }

  void setPoolAddress(
    String poolAddress,
  ) {
    state = state.copyWith(
      poolAddress: poolAddress,
    );
  }

  void setError(
    String errorText,
  ) {
    state = state.copyWith(
      errorText: errorText,
    );
  }

  void setStep(int step) {
    state = state.copyWith(
      step: step,
    );
  }

  void setStepError(String stepError) {
    state = state.copyWith(
      stepError: stepError,
    );
  }

  void setControlInProgress(bool controlInProgress) {
    state = state.copyWith(
      controlInProgress: controlInProgress,
    );
  }

  Future<void> setNetworkFees(double networkFees) async {
    final oracleUcoPrice = await sl.get<OracleService>().getOracleData();
    state = state.copyWith(
      networkFees: networkFees,
      networkFeesFiat: networkFees * (oracleUcoPrice.uco?.usd ?? 0),
    );
  }

  Future<void> setSwapFees(double swapFees) async {
    final oracleUcoPrice = await sl.get<OracleService>().getOracleData();
    state = state.copyWith(
      swapFees: swapFees,
      swapFeesFiat: swapFees * (oracleUcoPrice.uco?.usd ?? 0),
    );
  }

  void setSlippageTolerance(
    double slippageTolerance,
  ) {
    state = state.copyWith(
      slippageTolerance: slippageTolerance,
    );
  }

  void setExpertMode(
    bool expertMode,
  ) {
    state = state.copyWith(
      expertMode: expertMode,
    );
  }

  Future<void> swap(BuildContext context, WidgetRef ref) async {
    //
  }
}

abstract class SwapFormProvider {
  static final swapForm = _swapFormProvider;
}
