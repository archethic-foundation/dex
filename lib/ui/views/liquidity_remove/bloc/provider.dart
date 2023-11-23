import 'dart:developer';

import 'package:aedex/application/balance.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/remove_liquidity.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/state.dart';
import 'package:aedex/ui/views/util/delayed_task.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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

  CancelableTask<Map<String, dynamic>>? _calculateRemoveAmountsTask;

  void setPoolGenesisAddress(String poolGenesisAddress) {
    state = state.copyWith(poolGenesisAddress: poolGenesisAddress);
  }

  Future<({double removeAmountToken1, double removeAmountToken2})>
      _calculateRemoveAmounts(
    double lpTokenAmount, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    final apiService = sl.get<ApiService>();
    late final Map<String, dynamic> removeAmounts;
    try {
      removeAmounts = await Future<Map<String, dynamic>>(
        () async {
          if (lpTokenAmount <= 0) {
            return {};
          }

          _calculateRemoveAmountsTask?.cancel();
          _calculateRemoveAmountsTask = CancelableTask<Map<String, dynamic>>(
            task: () async {
              var _removeAmounts = <String, dynamic>{};
              final removeAmountsResult =
                  await PoolFactory(state.poolGenesisAddress, apiService)
                      .getRemoveAmounts(lpTokenAmount);

              removeAmountsResult.map(
                success: (success) {
                  if (success != null) {
                    _removeAmounts = success;
                  }
                },
                failure: (failure) {
                  setFailure(
                    Failure.other(cause: 'getRemoveAmountss error $failure'),
                  );
                },
              );
              return _removeAmounts;
            },
          );

          final _removeAmounts =
              await _calculateRemoveAmountsTask?.schedule(delay);

          return _removeAmounts ?? {};
        },
      );
    } on CanceledTask {
      return (removeAmountToken1: 0.0, removeAmountToken2: 0.0);
    }

    log("removeAmounts token1 ${removeAmounts['token1']})");
    log("removeAmounts token2 ${removeAmounts['token2']})");

    return (
      removeAmountToken1: removeAmounts['token1'] as double,
      removeAmountToken2: removeAmounts['token2'] as double,
    );
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
      failure: null,
      lpTokenAmount: amount,
    );

    final calculateRemoveAmountsResult = await _calculateRemoveAmounts(amount);
    state = state.copyWith(
      token1AmountGetBack: calculateRemoveAmountsResult.removeAmountToken1,
      token2AmountGetBack: calculateRemoveAmountsResult.removeAmountToken2,
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
    setLPTokenAmount(state.lpTokenBalance);
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setLiquidityRemoveProcessStep(
    LiquidityRemoveProcessStep liquidityRemoveProcessStep,
  ) {
    state = state.copyWith(
      liquidityRemoveProcessStep: liquidityRemoveProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setLiquidityRemoveProcessStep(
      LiquidityRemoveProcessStep.confirmation,
    );
  }

  bool control(BuildContext context) {
    setFailure(null);

    if (state.lpTokenAmount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .liquidityRemoveControlLPTokenAmountEmpty,
        ),
      );
      return false;
    }

    if (state.lpTokenAmount > state.lpTokenBalance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .liquidityRemoveControlToken1AmountExceedBalance,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> remove(BuildContext context, WidgetRef ref) async {
    setLiquidityRemoveOk(false);

    if (control(context) == false) {
      return;
    }
    setProcessInProgress(true);

    await RemoveLiquidityCase().run(
      state.poolGenesisAddress,
      ref,
      state.lpToken!.address!,
      state.lpTokenAmount,
      recoveryStep: state.currentStep,
    );
    setResumeProcess(false);
    setProcessInProgress(false);
    setLiquidityRemoveOk(true);
  }
}

abstract class LiquidityRemoveFormProvider {
  static final liquidityRemoveForm = _liquidityRemoveFormProvider;
}
