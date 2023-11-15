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

  CancelableTask<double?>? _calculateOutputAmountTask;

  Future<void> setTokenToSwap(
    DexToken tokenToSwap,
  ) async {
    state = state.copyWith(
      tokenToSwap: tokenToSwap,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.tokenToSwap!.address!,
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
          state.tokenToSwap!.address!,
          state.tokenSwapped!.address!,
        );
        poolInfosResult.map(
          success: (success) {
            if (success != null && success['address'] != null) {
              state = state.copyWith(poolGenesisAddress: success['address']);
            }
          },
          failure: (failure) {},
        );
      }
      await getRatio();
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
      tokenToSwapAmount: tokenToSwapAmount,
    );

    final equivalentAmount = await _calculateOutputAmount(
      state.tokenToSwap!.address!,
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
      tokenSwappedAmount: tokenSwappedAmount,
    );

    final equivalentAmount = await _calculateOutputAmount(
      state.tokenSwapped!.address!,
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
      tokenSwapped: tokenSwapped,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.tokenSwapped!.address!,
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
        state.tokenToSwap!.address!,
        state.tokenSwapped!.address!,
      );
      poolInfosResult.map(
        success: (success) {
          if (success != null && success['address'] != null) {
            state = state.copyWith(poolGenesisAddress: success['address']);
          }
        },
        failure: (failure) {},
      );

      await getRatio();
    }
  }

  Future<void> getRatio() async {
    final apiService = sl.get<ApiService>();
    final equivalentAmounResult =
        await PoolFactory(state.poolGenesisAddress, apiService)
            .getEquivalentAmount(state.tokenToSwap!.address!, 1);
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

  void setControlInProgress(bool controlInProgress) {
    state = state.copyWith(
      controlInProgress: controlInProgress,
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

  void setEstimatedReceived(
    double estimatedReceived,
  ) {
    state = state.copyWith(
      estimatedReceived: estimatedReceived,
    );
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

  Future<void> validateForm() async {
    if (control() == false) {
      return;
    }

    setSwapProcessStep(
      SwapProcessStep.confirmation,
    );
  }

  bool control() {
    setFailure(null);

    return true;
  }

  Future<void> swap(BuildContext context, WidgetRef ref) async {
    if (control() == false) {
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

    setProcessInProgress(false);
  }
}

abstract class SwapFormProvider {
  static final swapForm = _swapFormProvider;
}
