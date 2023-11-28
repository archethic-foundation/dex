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
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
        state.token1!.isUCO ? 'UCO' : state.token1!.address!,
      ).future,
    );
    state = state.copyWith(token1Balance: token1Balance);

    final token2Balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.token2!.isUCO ? 'UCO' : state.token2!.address!,
      ).future,
    );
    state = state.copyWith(token2Balance: token2Balance);
  }

  Future<void> initRatio() async {
    final apiService = sl.get<ApiService>();
    final equivalentAmounResult =
        await PoolFactory(state.poolGenesisAddress, apiService)
            .getEquivalentAmount(
      state.token1!.isUCO ? 'UCO' : state.token1!.address!,
      1,
    );
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

  void setToken1AmountHalf() {
    setToken1Amount(
      (Decimal.parse(state.token1Balance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setToken2AmountHalf() {
    setToken2Amount(
      (Decimal.parse(state.token2Balance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  Future<void> setExpectedTokenLP() async {
    state = state.copyWith(expectedTokenLP: 0);

    if (state.token1Amount <= 0 || state.token2Amount <= 0) {
      return;
    }
    final apiService = sl.get<ApiService>();
    final expectedTokenLPResult = await PoolFactory(
      state.poolGenesisAddress,
      apiService,
    ).getLPTokenToMint(state.token1Amount, state.token2Amount);
    expectedTokenLPResult.map(
      success: (success) {
        if (success != null) {
          state = state.copyWith(expectedTokenLP: success);
        }
      },
      failure: (failure) {},
    );
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
      failure: null,
      token1Amount: amount,
    );

    final equivalentAmount = await _calculateEquivalentAmount(
      state.token1!.isUCO ? 'UCO' : state.token1!.address!,
      amount,
    );
    state = state.copyWith(
      token2Amount: equivalentAmount,
    );

    await setExpectedTokenLP();
  }

  Future<void> setToken2Amount(
    double amount,
  ) async {
    state = state.copyWith(
      failure: null,
      token2Amount: amount,
    );
    final equivalentAmount = await _calculateEquivalentAmount(
      state.token2!.isUCO ? 'UCO' : state.token2!.address!,
      amount,
    );
    state = state.copyWith(
      token1Amount: equivalentAmount,
    );

    await setExpectedTokenLP();
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

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
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

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setLiquidityAddProcessStep(
      LiquidityAddProcessStep.confirmation,
    );
  }

  bool control(BuildContext context) {
    setFailure(null);

    if (state.token1Amount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .liquidityAddControlToken1AmountEmpty,
        ),
      );
      return false;
    }

    if (state.token2Amount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .liquidityAddControlToken2AmountEmpty,
        ),
      );
      return false;
    }

    if (state.token1Amount > state.token1Balance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .liquidityAddControlToken1AmountExceedBalance,
        ),
      );
      return false;
    }

    if (state.token2Amount > state.token2Balance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .liquidityAddControlToken2AmountExceedBalance,
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> add(BuildContext context, WidgetRef ref) async {
    setLiquidityAddOk(false);

    if (control(context) == false) {
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
      recoveryStep: state.currentStep,
    );

    setResumeProcess(false);
    setProcessInProgress(false);
    setLiquidityAddOk(true);
  }
}

abstract class LiquidityAddFormProvider {
  static final liquidityAddForm = _liquidityAddFormProvider;
}
