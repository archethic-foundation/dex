import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/remove_liquidity.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _liquidityRemoveFormProvider = NotifierProvider.autoDispose<
    LiquidityRemoveFormNotifier, LiquidityRemoveFormState>(
  () {
    return LiquidityRemoveFormNotifier();
  },
);

class LiquidityRemoveFormNotifier
    extends AutoDisposeNotifier<LiquidityRemoveFormState> {
  LiquidityRemoveFormNotifier();

  @override
  LiquidityRemoveFormState build() => const LiquidityRemoveFormState();

  void setPoolGenesisAddress(String poolGenesisAddress) {
    state = state.copyWith(poolGenesisAddress: poolGenesisAddress);
  }

  Future<void> initBalance() async {
    final session = ref.read(SessionProviders.session);

    final lpTokenBalance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.lpToken!.address!,
      ).future,
    );
    state = state.copyWith(lpTokenBalance: lpTokenBalance);
  }

  void setLpToken(
    DexToken token,
  ) {
    state = state.copyWith(
      lpToken: token,
    );
  }

  void setLPTokenBalance(
    double balance,
  ) {
    state = state.copyWith(
      lpTokenBalance: balance,
    );
  }

  Future<void> setLPTokenAmount(
    double amount,
  ) async {
    state = state.copyWith(
      lpTokenAmount: amount,
    );
  }

  void estimateNetworkFees() {
    state = state.copyWith(
      networkFees: 0,
    );
  }

  void setFailure(Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setWalletConfirmation(bool walletConfirmation) {
    state = state.copyWith(
      walletConfirmation: walletConfirmation,
    );
  }

  void setLiquidityRemoveOk(bool liquidityRemoveOk) {
    state = state.copyWith(
      liquidityRemoveOk: liquidityRemoveOk,
    );
  }

  void setLpTokenAmountMax() {
    state = state.copyWith(lpTokenAmount: state.lpTokenBalance);
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setLiquidityRemoveProcessStep(
    LiquidityRemoveProcessStep liquidityRemoveProcessStep,
  ) {
    state = state.copyWith(
      liquidityRemoveProcessStep: liquidityRemoveProcessStep,
    );
  }

  Future<void> validateForm() async {
    if (control() == false) {
      return;
    }

    setLiquidityRemoveProcessStep(
      LiquidityRemoveProcessStep.confirmation,
    );
  }

  bool control() {
    setFailure(null);

    if (state.lpTokenAmount <= 0) {
      setFailure(
        const Failure.other(cause: 'Please enter the amount of lp token'),
      );
      return false;
    }

    return true;
  }

  Future<void> add(BuildContext context, WidgetRef ref) async {
    if (control() == false) {
      return;
    }
    setProcessInProgress(true);

    await RemoveLiquidityCase().run(
      state.poolGenesisAddress,
      ref,
      state.lpToken!.address!,
      state.lpTokenAmount,
    );

    setProcessInProgress(false);
  }
}

abstract class LiquidityRemoveFormProvider {
  static final liquidityRemoveForm = _liquidityRemoveFormProvider;
}
