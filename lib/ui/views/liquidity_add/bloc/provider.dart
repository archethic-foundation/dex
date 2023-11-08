import 'package:aedex/application/dex_config.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/add_liquidity.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _liquidityAddFormProvider = NotifierProvider.autoDispose<
    LiquidityAddFormNotifier, LiquidityAddFormState>(
  () {
    return LiquidityAddFormNotifier();
  },
);

class LiquidityAddFormNotifier
    extends AutoDisposeNotifier<LiquidityAddFormState> {
  LiquidityAddFormNotifier();

  @override
  LiquidityAddFormState build() => const LiquidityAddFormState();

  void setToken1(
    DexToken token,
  ) {
    state = state.copyWith(
      token1: token,
    );
  }

  void setToken2(
    DexToken token,
  ) {
    state = state.copyWith(
      token2: token,
    );
  }

  void setToken1Balance(
    double balance,
  ) {
    state = state.copyWith(
      token1Balance: balance,
    );
  }

  void setToken2Balance(
    double balance,
  ) {
    state = state.copyWith(
      token2Balance: balance,
    );
  }

  void setToken1Amount(
    double amount,
  ) {
    state = state.copyWith(
      token1Amount: amount,
    );
  }

  void setToken2Amount(
    double amount,
  ) {
    state = state.copyWith(
      token2Amount: amount,
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

  void setLiquidityAddOk(bool liquidityAddOk) {
    state = state.copyWith(
      liquidityAddOk: liquidityAddOk,
    );
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setLiquidityAddProcessStep(
    LiquidityAddProcessStep liquidityAddProcessStep,
  ) {
    state = state.copyWith(
      liquidityAddProcessStep: liquidityAddProcessStep,
    );
  }

  Future<void> validateForm() async {
    if (control() == false) {
      return;
    }

    setLiquidityAddProcessStep(
      LiquidityAddProcessStep.confirmation,
    );
  }

  bool control() {
    setFailure(null);

    if (state.token1 == null) {
      setFailure(
        const Failure.other(cause: 'Please enter the token 1'),
      );
      return false;
    }

    if (state.token2 == null) {
      setFailure(
        const Failure.other(cause: 'Please enter the token 2'),
      );
      return false;
    }

    if (state.token1Amount <= 0) {
      setFailure(
        const Failure.other(cause: 'Please enter the amount of token 1'),
      );
      return false;
    }

    if (state.token2Amount <= 0) {
      setFailure(
        const Failure.other(cause: 'Please enter the amount of token 1'),
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

    final dexConfig = await ref
        .read(DexConfigProviders.dexConfigRepository)
        .getDexConfig('local');

    await AddLiquidityCase().run(
      ref,
      state.token1!,
      state.token1Amount,
      state.token2!,
      state.token2Amount,
      dexConfig.routerGenesisAddress,
      state.slippage,
    );

    setProcessInProgress(false);
  }
}

abstract class LiquidityAddFormProvider {
  static final liquidityAddForm = _liquidityAddFormProvider;
}
