import 'package:aedex/application/balance.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/add_liquidity.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/state.dart';
import 'package:aedex/ui/views/util/delayed_task.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
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

  Future<void> setPool(DexPool pool) async {
    state = state.copyWith(pool: pool);

    final poolPopulated =
        await ref.read(DexPoolProviders.getPoolInfos(pool).future);
    state = state.copyWith(pool: poolPopulated);
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

    final lpTokenBalance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.pool!.lpToken.address!,
      ).future,
    );
    state = state.copyWith(lpTokenBalance: lpTokenBalance);
  }

  Future<void> initRatio() async {
    final apiService = sl.get<ApiService>();
    final equivalentAmounResult =
        await PoolFactory(state.pool!.poolAddress, apiService)
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

  void setTransactionAddLiquidity(Transaction transactionAddLiquidity) {
    state = state.copyWith(transactionAddLiquidity: transactionAddLiquidity);
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

  Future<void> setToken1AmountMax(WidgetRef ref) async {
    await setToken1Amount(state.token1Balance);
    final feesUCO = await AddLiquidityCase().estimateFees(
      ref,
      state.pool!.poolAddress,
      state.token1!,
      state.token1Amount,
      state.token2!,
      state.token2Amount,
      state.slippageTolerance,
    );
    debugPrint('feesUCO: $feesUCO');
  }

  Future<void> setToken2AmountMax(WidgetRef ref) async {
    await setToken2Amount(state.token2Balance);
    final feesUCO = await AddLiquidityCase().estimateFees(
      ref,
      state.pool!.poolAddress,
      state.token1!,
      state.token1Amount,
      state.token2!,
      state.token2Amount,
      state.slippageTolerance,
    );
    debugPrint('feesUCO: $feesUCO');
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
      state.pool!.poolAddress,
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
                  await PoolFactory(state.pool!.poolAddress, apiService)
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
      calculationInProgress: true,
    );

    final equivalentAmount = await _calculateEquivalentAmount(
      state.token1!.isUCO ? 'UCO' : state.token1!.address!,
      amount,
    );
    state = state.copyWith(
      token2Amount: equivalentAmount,
    );

    await setExpectedTokenLP();
    estimateTokenMinAmounts();

    state = state.copyWith(
      calculationInProgress: false,
    );
  }

  Future<void> setToken2Amount(
    double amount,
  ) async {
    state = state.copyWith(
      failure: null,
      token2Amount: amount,
      calculationInProgress: true,
    );
    final equivalentAmount = await _calculateEquivalentAmount(
      state.token2!.isUCO ? 'UCO' : state.token2!.address!,
      amount,
    );
    state = state.copyWith(
      token1Amount: equivalentAmount,
    );

    await setExpectedTokenLP();
    estimateTokenMinAmounts();

    state = state.copyWith(
      calculationInProgress: false,
    );
  }

  void estimateTokenMinAmounts() {
    final slippagePourcent = (Decimal.parse('100') -
            Decimal.parse(state.slippageTolerance.toString())) /
        Decimal.parse('100');
    setToken1minAmount(
      (Decimal.parse(state.token1Amount.toString()) *
              slippagePourcent.toDecimal())
          .toDouble(),
    );
    setToken2minAmount(
      (Decimal.parse(state.token2Amount.toString()) *
              slippagePourcent.toDecimal())
          .toDouble(),
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

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setToken1minAmount(double token1minAmount) {
    state = state.copyWith(token1minAmount: token1minAmount);
  }

  void setToken2minAmount(double token2minAmount) {
    state = state.copyWith(token2minAmount: token2minAmount);
  }

  void setSlippageTolerance(double slippageTolerance) {
    state = state.copyWith(slippageTolerance: slippageTolerance);
    estimateTokenMinAmounts();
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

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      setFailure(
        const Failure.incompatibleBrowser(),
      );
      return false;
    }

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
      state.pool!.poolAddress,
      state.token1!,
      state.token1Amount,
      state.token2!,
      state.token2Amount,
      state.slippageTolerance,
      recoveryStep: state.currentStep,
    );

    setResumeProcess(false);
    setProcessInProgress(false);
    setLiquidityAddOk(true);
    ref.read(DexPoolProviders.invalidateData);
  }
}

abstract class LiquidityAddFormProvider {
  static final liquidityAddForm = _liquidityAddFormProvider;
}
