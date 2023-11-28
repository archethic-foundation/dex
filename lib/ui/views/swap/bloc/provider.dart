import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/swap.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/ui/views/util/delayed_task.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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

  CancelableTask<
      ({
        double outputAmount,
        double fees,
        double priceImpact,
        double minToReceive
      })>? _calculateSwapInfosTask;

  Future<void> setTokenToSwap(
    DexToken tokenToSwap,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenToSwap: tokenToSwap,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
      ).future,
    );
    state = state.copyWith(tokenToSwapBalance: balance);

    if (state.tokenSwapped != null) {
      final dexConfig =
          await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
      final apiService = sl.get<ApiService>();
      if (state.tokenToSwap != null) {
        final routerFactory =
            RouterFactory(dexConfig.routerGenesisAddress, apiService);
        final poolInfosResult = await routerFactory.getPoolAddresses(
          state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
          state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
        );
        await poolInfosResult.map(
          success: (success) async {
            if (success != null && success['address'] != null) {
              setPoolAddress(success['address']);
              await setTokenToSwapAmount(state.tokenToSwapAmount);
              setTokenFormSelected(1);
              await getRatio();
            } else {
              setPoolAddress('');
              setFailure(const PoolNotExists());
            }
          },
          failure: (failure) {
            setPoolAddress('');
            setFailure(const PoolNotExists());
          },
        );
      }
    }
    return;
  }

  Future<
      ({
        double outputAmount,
        double fees,
        double priceImpact,
        double minToReceive
      })> _calculateSwapInfos(
    String tokenAddress,
    double amount, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    if (state.poolGenesisAddress.isEmpty) {
      return (
        outputAmount: 0.0,
        fees: 0.0,
        priceImpact: 0.0,
        minToReceive: 0.0,
      );
    }
    final apiService = sl.get<ApiService>();
    final ({
      double fees,
      double outputAmount,
      double priceImpact,
      double minToReceive,
    }) result;
    try {
      result = await Future<
          ({
            double outputAmount,
            double fees,
            double priceImpact,
            double minToReceive,
          })>(
        () async {
          if (amount <= 0) {
            return (
              outputAmount: 0.0,
              fees: 0.0,
              priceImpact: 0.0,
              minToReceive: 0.0,
            );
          }

          _calculateSwapInfosTask?.cancel();
          _calculateSwapInfosTask = CancelableTask<
              ({
                double outputAmount,
                double fees,
                double priceImpact,
                double minToReceive,
              })>(
            task: () async {
              var _outputAmount = 0.0;
              var _fees = 0.0;
              var _priceImpact = 0.0;
              var _minToReceive = 0.0;
              final getSwapInfosResult = await PoolFactory(
                state.poolGenesisAddress,
                apiService,
              ).getSwapInfos(tokenAddress, amount);

              getSwapInfosResult.map(
                success: (success) {
                  if (success != null) {
                    _outputAmount = success['output_amount'] ?? 0;
                    _fees = success['fee'] ?? 0;
                    _priceImpact = success['price_impact'] ?? 0;
                    _minToReceive = (Decimal.parse(_outputAmount.toString()) *
                            (((Decimal.parse('100') -
                                        Decimal.parse(
                                          state.slippageTolerance.toString(),
                                        )) /
                                    Decimal.parse('100'))
                                .toDecimal()))
                        .toDouble();
                  }
                },
                failure: (failure) {
                  setFailure(
                    Failure.other(
                      cause: 'calculateOutputAmount error $failure',
                    ),
                  );
                },
              );
              return (
                outputAmount: _outputAmount,
                fees: _fees,
                priceImpact: _priceImpact,
                minToReceive: _minToReceive,
              );
            },
          );

          final __result = await _calculateSwapInfosTask?.schedule(delay);

          return (
            outputAmount: __result == null ? 0.0 : __result.outputAmount,
            fees: __result == null ? 0.0 : __result.fees,
            priceImpact: __result == null ? 0.0 : __result.priceImpact,
            minToReceive: __result == null ? 0.0 : __result.minToReceive,
          );
        },
      );
    } on CanceledTask {
      return (
        outputAmount: 0.0,
        fees: 0.0,
        priceImpact: 0.0,
        minToReceive: 0.0,
      );
    }
    return (
      outputAmount: result.outputAmount,
      fees: result.fees,
      priceImpact: result.priceImpact,
      minToReceive: result.minToReceive,
    );
  }

  Future<void> setTokenToSwapAmount(
    double tokenToSwapAmount,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenToSwapAmount: tokenToSwapAmount,
    );

    if (state.tokenToSwap == null) {
      return;
    }
    final swapInfos = await _calculateSwapInfos(
      state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
      tokenToSwapAmount,
    );
    state = state.copyWith(
      tokenSwappedAmount: swapInfos.outputAmount,
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      minToReceive: swapInfos.minToReceive,
    );
  }

  Future<void> setTokenSwappedAmount(
    double tokenSwappedAmount,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenSwappedAmount: tokenSwappedAmount,
    );

    if (state.tokenSwapped == null) {
      return;
    }
    final swapInfos = await _calculateSwapInfos(
      state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
      tokenSwappedAmount,
    );
    state = state.copyWith(
      tokenToSwapAmount: swapInfos.outputAmount,
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      minToReceive: swapInfos.minToReceive,
    );
  }

  void setWalletConfirmation(bool walletConfirmation) {
    state = state.copyWith(
      walletConfirmation: walletConfirmation,
    );
  }

  void setSwapOk(bool swapOk) {
    state = state.copyWith(
      swapOk: swapOk,
    );
  }

  Future<void> setTokenSwapped(
    DexToken tokenSwapped,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenSwapped: tokenSwapped,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
      ).future,
    );
    state = state.copyWith(tokenSwappedBalance: balance);

    final dexConfig =
        await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
    final apiService = sl.get<ApiService>();
    if (state.tokenToSwap != null) {
      final routerFactory =
          RouterFactory(dexConfig.routerGenesisAddress, apiService);
      final poolInfosResult = await routerFactory.getPoolAddresses(
        state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
        state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
      );
      await poolInfosResult.map(
        success: (success) async {
          if (success != null && success['address'] != null) {
            setPoolAddress(success['address']);
            await setTokenSwappedAmount(state.tokenSwappedAmount);
            setTokenFormSelected(2);
            await getRatio();
          } else {
            setFailure(const PoolNotExists());
          }
        },
        failure: (failure) {
          setFailure(const PoolNotExists());
        },
      );
    }
  }

  Future<void> getRatio() async {
    if (state.tokenToSwap == null) {
      state = state.copyWith(ratio: 0);
      return;
    }

    final apiService = sl.get<ApiService>();
    final poolRatioResult = await PoolFactory(
      state.poolGenesisAddress,
      apiService,
    ).getPoolRatio(
      state.tokenToSwap!.address == null ? 'UCO' : state.tokenToSwap!.address!,
    );
    var ratio = 0.0;
    poolRatioResult.map(
      success: (success) {
        if (success != null) {
          ratio = success;
        }
      },
      failure: (failure) {
        setFailure(Failure.other(cause: 'poolRatioResult error $failure'));
      },
    );
    state = state.copyWith(ratio: ratio);
  }

  void setPoolAddress(
    String poolAddress,
  ) {
    state = state.copyWith(
      poolGenesisAddress: poolAddress,
    );
  }

  void setSwapFees(double swapFees) {
    state = state.copyWith(
      swapFees: swapFees,
    );
  }

  void setSlippageTolerance(
    double slippageTolerance,
  ) {
    state = state.copyWith(
      slippageTolerance: slippageTolerance,
    );
  }

  void setMinimumReceived(
    double minToReceive,
  ) {
    state = state.copyWith(
      minToReceive: minToReceive,
    );
  }

  void setPriceImpact(
    double priceImpact,
  ) {
    state = state.copyWith(
      priceImpact: priceImpact,
    );
  }

  void setTokenToSwapAmountMax() {
    setTokenToSwapAmount(state.tokenToSwapBalance);
  }

  void setTokenSwappedAmountMax() {
    setTokenSwappedAmount(state.tokenSwappedBalance);
  }

  void setTokenToSwapAmountHalf() {
    setTokenToSwapAmount(
      (Decimal.parse(state.tokenToSwapBalance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setTokenSwappedAmountHalf() {
    setTokenSwappedAmount(
      (Decimal.parse(state.tokenSwappedBalance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setRecoveryTransactionSwap(Transaction? recoveryTransactionSwap) {
    state = state.copyWith(recoveryTransactionSwap: recoveryTransactionSwap);
  }

  void setEstimatedReceived(
    double estimatedReceived,
  ) {
    state = state.copyWith(
      estimatedReceived: estimatedReceived,
    );
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setTokenFormSelected(int tokenFormSelected) {
    state = state.copyWith(failure: null, tokenFormSelected: tokenFormSelected);
  }

  void setFailure(Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setSwapProcessStep(
    SwapProcessStep swapProcessStep,
  ) {
    state = state.copyWith(
      swapProcessStep: swapProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setSwapProcessStep(
      SwapProcessStep.confirmation,
    );
  }

  bool control(BuildContext context) {
    setFailure(null);

    if (state.tokenToSwap == null) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenToSwapEmpty,
        ),
      );
      return false;
    }

    if (state.tokenSwapped == null) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenSwappedEmpty,
        ),
      );
      return false;
    }

    if (state.tokenToSwapAmount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenToSwapEmpty,
        ),
      );
      return false;
    }

    if (state.tokenSwappedAmount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenSwappedEmpty,
        ),
      );
      return false;
    }

    if (state.tokenToSwapAmount > state.tokenToSwapBalance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .swapControlTokenToSwapAmountExceedBalance,
        ),
      );
      return false;
    }

    if (state.tokenSwappedAmount > state.tokenSwappedBalance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .swapControlTokenSwappedAmountExceedBalance,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> swap(BuildContext context, WidgetRef ref) async {
    setSwapOk(false);
    if (control(context) == false) {
      return;
    }
    setProcessInProgress(true);

    await SwapCase().run(
      ref,
      state.poolGenesisAddress,
      state.tokenToSwap!,
      state.tokenToSwapAmount,
      state.slippageTolerance,
    );

    setResumeProcess(false);
    setProcessInProgress(false);
    setSwapOk(true);
  }
}

abstract class SwapFormProvider {
  static final swapForm = _swapFormProvider;
}
