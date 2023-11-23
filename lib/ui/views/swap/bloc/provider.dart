import 'dart:developer';

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

  CancelableTask<double?>? _calculateOutputAmountTask;

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
      final dexConfig = await ref
          .read(DexConfigProviders.dexConfigRepository)
          .getDexConfig('devnet');
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
              state = state.copyWith(poolGenesisAddress: success['address']);
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

  Future<double> _calculateOutputAmount(
    String tokenAddress,
    double amount, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    final apiService = sl.get<ApiService>();
    late final double outputAmount;
    try {
      outputAmount = await Future<double>(
        () async {
          if (amount <= 0) {
            return 0;
          }

          _calculateOutputAmountTask?.cancel();
          _calculateOutputAmountTask = CancelableTask<double?>(
            task: () async {
              var _outputAmount = 0.0;
              final getSwapInfosResult = await PoolFactory(
                state.poolGenesisAddress,
                apiService,
              ).getSwapInfos(tokenAddress, amount);

              getSwapInfosResult.map(
                success: (success) {
                  if (success != null) {
                    _outputAmount = success['output_amount'];
                    log('calculateOutputAmount: address $tokenAddress $amount -> outputAmount $_outputAmount');
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
              return _outputAmount;
            },
          );

          final __outputAmount =
              await _calculateOutputAmountTask?.schedule(delay);

          return __outputAmount ?? 0;
        },
      );
    } on CanceledTask {
      return 0;
    }
    return outputAmount;
  }

  Future<void> setTokenToSwapAmount(
    double tokenToSwapAmount,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenToSwapAmount: tokenToSwapAmount,
    );

    final equivalentAmount = await _calculateOutputAmount(
      state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
      tokenToSwapAmount,
    );
    state = state.copyWith(
      tokenSwappedAmount: equivalentAmount,
    );
  }

  Future<void> setTokenSwappedAmount(
    double tokenSwappedAmount,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenSwappedAmount: tokenSwappedAmount,
    );

    final equivalentAmount = await _calculateOutputAmount(
      state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
      tokenSwappedAmount,
    );
    state = state.copyWith(
      tokenToSwapAmount: equivalentAmount,
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

    final dexConfig = await ref
        .read(DexConfigProviders.dexConfigRepository)
        .getDexConfig('devnet');
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
            state = state.copyWith(poolGenesisAddress: success['address']);
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
    final apiService = sl.get<ApiService>();
    final equivalentAmounResult = await PoolFactory(
      state.poolGenesisAddress,
      apiService,
    ).getEquivalentAmount(
      state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
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

  void setPoolAddress(
    String poolAddress,
  ) {
    state = state.copyWith(
      poolGenesisAddress: poolAddress,
    );
  }

  void setNetworkFees(double networkFees) {
    state = state.copyWith(
      networkFees: networkFees,
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
    double minimumReceived,
  ) {
    state = state.copyWith(
      minimumReceived: minimumReceived,
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
