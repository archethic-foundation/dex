import 'dart:developer';

import 'package:aedex/application/balance.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/add_liquidity.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/state.dart';
import 'package:aedex/ui/views/util/delayed_task.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
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

  CancelableTask<double?>? _calculateEquivalentAmountTask;

  void setPoolGenesisAddress(String poolGenesisAddress) {
    state = state.copyWith(poolGenesisAddress: poolGenesisAddress);
  }

  Future<void> initBalances() async {
    final session = ref.read(SessionProviders.session);

    final token1Balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.token1!.address!,
      ).future,
    );
    state = state.copyWith(token1Balance: token1Balance);

    final token2Balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.token2!.address!,
      ).future,
    );
    state = state.copyWith(token2Balance: token2Balance);
  }

  Future<void> initRatio() async {
    final apiService = sl.get<ApiService>();
    final equivalentAmounResult =
        await PoolFactory(state.poolGenesisAddress, apiService)
            .getEquivalentAmount(state.token1!.address!, 1);
    var ratio = 0.0;
    equivalentAmounResult.map(
      success: (success) {
        if (success != null) {
          ratio = success;
        }
      },
      failure: (failure) {
        setFailure(Failure.other(cause: 'getEquivalentAmount error $failure'));
      },
    );
    state = state.copyWith(ratio: ratio);
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

  void setToken1AmountMax() {
    setToken1Amount(state.token1Balance);
  }

  void setToken2AmountMax() {
    setToken2Amount(state.token2Balance);
  }

  Future<double> _calculateEquivalentAmount(
    String tokenAddress,
    double amount, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    final apiService = sl.get<ApiService>();
    late final double equivalentAmount;
    try {
      equivalentAmount = await Future<double>(
        () async {
          if (amount <= 0) {
            return 0;
          }

          _calculateEquivalentAmountTask?.cancel();
          _calculateEquivalentAmountTask = CancelableTask<double?>(
            task: () async {
              var _equivalentAmount = 0.0;
              final equivalentAmountResult =
                  await PoolFactory(state.poolGenesisAddress, apiService)
                      .getEquivalentAmount(tokenAddress, amount);

              equivalentAmountResult.map(
                success: (success) {
                  if (success != null) {
                    _equivalentAmount = success;
                    log('equivalentAmounResult: address $tokenAddress $amount -> equivalentAmount $_equivalentAmount');
                  }
                },
                failure: (failure) {
                  setFailure(
                    Failure.other(cause: 'getEquivalentAmount error $failure'),
                  );
                },
              );
              return _equivalentAmount;
            },
          );

          final __equivalentAmount =
              await _calculateEquivalentAmountTask?.schedule(delay);

          return __equivalentAmount ?? 0;
        },
      );
    } on CanceledTask {
      return 0;
    }
    return equivalentAmount;
  }

  Future<void> setToken1Amount(
    double amount,
  ) async {
    state = state.copyWith(
      token1Amount: amount,
    );

    final equivalentAmount =
        await _calculateEquivalentAmount(state.token1!.address!, amount);
    state = state.copyWith(
      token2Amount: equivalentAmount,
    );
  }

  Future<void> setToken2Amount(
    double amount,
  ) async {
    state = state.copyWith(
      token2Amount: amount,
    );
    final equivalentAmount =
        await _calculateEquivalentAmount(state.token2!.address!, amount);
    state = state.copyWith(
      token1Amount: equivalentAmount,
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

    await AddLiquidityCase().run(
      ref,
      state.poolGenesisAddress,
      state.token1!,
      state.token1Amount,
      state.token2!,
      state.token2Amount,
      state.slippage,
    );

    setProcessInProgress(false);
  }
}

abstract class LiquidityAddFormProvider {
  static final liquidityAddForm = _liquidityAddFormProvider;
}
