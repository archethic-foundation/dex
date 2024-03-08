import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/notification.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/usecases/swap.usecase.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
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

  aedappfm.CancelableTask<
      ({
        double outputAmount,
        double fees,
        double priceImpact,
        double protocolFees,
      })>? _calculateSwapInfosTask;

  Future<void> getPool() async {
    final pool = await ref
        .read(DexPoolProviders.getPool(state.poolGenesisAddress).future);
    setPool(pool);
  }

  void setPool(DexPool? pool) {
    state = state.copyWith(pool: pool);
  }

  Future<void> setTokenToSwap(
    DexToken tokenToSwap,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      calculationInProgress: true,
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
      if (state.tokenToSwap!.address == state.tokenSwapped!.address) {
        setFailure(
          const aedappfm.Failure.other(cause: "You can't swap the same tokens"),
        );
        state = state.copyWith(ratio: 0, pool: null);
        return;
      }

      final dexConfig =
          await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
      final apiService = aedappfm.sl.get<ApiService>();
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
              await getRatio();
              await getPool();
            } else {
              setPoolAddress('');
              setFailure(const aedappfm.PoolNotExists());
              state = state.copyWith(ratio: 0, pool: null);
            }
          },
          failure: (failure) {
            setPoolAddress('');
            setFailure(const aedappfm.PoolNotExists());
            state = state.copyWith(ratio: 0, pool: null);
          },
        );
      }
    }
    state = state.copyWith(
      calculationInProgress: false,
    );
    return;
  }

  Future<
      ({
        double outputAmount,
        double fees,
        double priceImpact,
        double protocolFees,
      })> calculateSwapInfos(
    String tokenAddress,
    double amount, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    if (state.poolGenesisAddress.isEmpty) {
      return (
        outputAmount: 0.0,
        fees: 0.0,
        priceImpact: 0.0,
        protocolFees: 0.0,
      );
    }
    final apiService = aedappfm.sl.get<ApiService>();
    final ({
      double fees,
      double outputAmount,
      double priceImpact,
      double protocolFees,
    }) result;
    try {
      result = await Future<
          ({
            double outputAmount,
            double fees,
            double priceImpact,
            double protocolFees,
          })>(
        () async {
          if (amount <= 0) {
            return (
              outputAmount: 0.0,
              fees: 0.0,
              priceImpact: 0.0,
              protocolFees: 0.0,
            );
          }

          _calculateSwapInfosTask?.cancel();
          _calculateSwapInfosTask = aedappfm.CancelableTask<
              ({
                double outputAmount,
                double fees,
                double priceImpact,
                double protocolFees,
              })>(
            task: () async {
              var _outputAmount = 0.0;
              var _fees = 0.0;
              var _priceImpact = 0.0;
              var _protocolFees = 0.0;

              final getSwapInfosResult = await PoolFactory(
                state.poolGenesisAddress,
                apiService,
              ).getSwapInfos(tokenAddress, amount);

              getSwapInfosResult.map(
                success: (success) {
                  if (success != null) {
                    _outputAmount = success['output_amount'] is int
                        ? double.parse(success['output_amount'].toString())
                        : success['output_amount'] ?? 0;
                    _fees = success['fee'] is int
                        ? double.parse(success['fee'].toString())
                        : success['fee'] ?? 0;
                    _priceImpact = success['price_impact'] is int
                        ? double.parse(success['price_impact'].toString())
                        : success['price_impact'] ?? 0;
                    _protocolFees = success['protocol_fee'] is int
                        ? double.parse(success['protocol_fee'].toString())
                        : success['protocol_fee'] ?? 0;
                  }
                },
                failure: (failure) {
                  setFailure(
                    aedappfm.Failure.other(
                      cause: 'calculateOutputAmount error $failure',
                    ),
                  );
                },
              );
              return (
                outputAmount: _outputAmount,
                fees: _fees,
                priceImpact: _priceImpact,
                protocolFees: _protocolFees,
              );
            },
          );

          final __result = await _calculateSwapInfosTask?.schedule(delay);

          return (
            outputAmount: __result == null ? 0.0 : __result.outputAmount,
            fees: __result == null ? 0.0 : __result.fees,
            priceImpact: __result == null ? 0.0 : __result.priceImpact,
            protocolFees: __result == null ? 0.0 : __result.protocolFees,
          );
        },
      );
    } on aedappfm.CanceledTask {
      return (
        outputAmount: 0.0,
        fees: 0.0,
        priceImpact: 0.0,
        protocolFees: 0.0,
      );
    }
    return (
      outputAmount: result.outputAmount,
      fees: result.fees,
      priceImpact: result.priceImpact,
      protocolFees: result.protocolFees,
    );
  }

  Future<void> calculateOutputAmount() async {
    var swapInfos =
        (fees: 0.0, outputAmount: 0.0, priceImpact: 0.0, protocolFees: 0.0);

    if (state.tokenFormSelected == 1) {
      if (state.tokenToSwapAmount == 0) {
        return;
      }
      state = state.copyWith(
        calculateAmountSwapped: true,
        calculationInProgress: true,
      );
      swapInfos = await calculateSwapInfos(
        state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
        state.tokenToSwapAmount,
      );
      state = state.copyWith(
        tokenSwappedAmount: swapInfos.outputAmount,
      );
    } else {
      if (state.tokenSwappedAmount == 0) {
        return;
      }
      state = state.copyWith(
        calculateAmountToSwap: true,
        calculationInProgress: true,
      );
      swapInfos = await calculateSwapInfos(
        state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
        state.tokenSwappedAmount,
      );
      state = state.copyWith(
        tokenToSwapAmount: swapInfos.outputAmount,
      );
      swapInfos = await calculateSwapInfos(
        state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
        state.tokenToSwapAmount,
      );
    }

    final minToReceive = (Decimal.parse(swapInfos.outputAmount.toString()) *
            (((Decimal.parse('100') -
                        Decimal.parse(
                          state.slippageTolerance.toString(),
                        )) /
                    Decimal.parse('100'))
                .toDecimal()))
        .toDouble();

    if (state.tokenToSwapAmount > state.tokenToSwapBalance) {
      setFailure(const aedappfm.Failure.insufficientFunds());
    }

    state = state.copyWith(
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      swapProtocolFees: swapInfos.protocolFees,
      minToReceive: minToReceive,
      calculateAmountSwapped: false,
      calculateAmountToSwap: false,
      calculationInProgress: false,
    );
  }

  Future<void> setTokenToSwapAmount(
    double tokenToSwapAmount,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      tokenToSwapAmount: tokenToSwapAmount,
    );

    if (state.tokenToSwap == null) {
      return;
    }

    await calculateOutputAmount();
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

    await calculateOutputAmount();
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
      calculationInProgress: true,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
      ).future,
    );
    state = state.copyWith(tokenSwappedBalance: balance);

    if (state.tokenToSwap != null) {
      if (state.tokenToSwap!.address == state.tokenSwapped!.address) {
        setFailure(
          const aedappfm.Failure.other(cause: "You can't swap the same tokens"),
        );
        state = state.copyWith(ratio: 0, pool: null);
        return;
      }

      final dexConfig =
          await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
      final apiService = aedappfm.sl.get<ApiService>();
      if (state.tokenSwapped != null) {
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
              await getRatio();
              await getPool();
            } else {
              setPoolAddress('');
              setFailure(const aedappfm.PoolNotExists());
              state = state.copyWith(ratio: 0, pool: null);
            }
          },
          failure: (failure) {
            setPoolAddress('');
            setFailure(const aedappfm.PoolNotExists());
            state = state.copyWith(ratio: 0, pool: null);
          },
        );
      }
    }
    state = state.copyWith(
      calculationInProgress: false,
    );
    return;
  }

  void swapDirections() {
    final oldToken1 = state.tokenToSwap;
    final oldToken2 = state.tokenSwapped;
    if (oldToken2 != null) {
      setTokenToSwap(oldToken2);
    }

    if (oldToken1 != null) {
      setTokenSwapped(oldToken1);
    }
  }

  Future<void> getRatio() async {
    if (state.tokenToSwap == null || state.tokenSwapped == null) {
      state = state.copyWith(ratio: 0);
      return;
    }

    final ratio = await ref.read(
      DexPoolProviders.getRatio(
        state.poolGenesisAddress,
        state.tokenToSwap!,
      ).future,
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

  Future<void> setSlippageTolerance(
    double slippageTolerance,
  ) async {
    state = state.copyWith(
      slippageTolerance: slippageTolerance,
    );
    final swapInfos = await calculateSwapInfos(
      state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
      state.tokenToSwapAmount,
    );

    final minToReceive = (Decimal.parse(swapInfos.outputAmount.toString()) *
            (((Decimal.parse('100') -
                        Decimal.parse(
                          state.slippageTolerance.toString(),
                        )) /
                    Decimal.parse('100'))
                .toDecimal()))
        .toDouble();

    state = state.copyWith(
      tokenSwappedAmount: swapInfos.outputAmount,
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      swapProtocolFees: swapInfos.protocolFees,
      minToReceive: minToReceive,
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

  void setSwapProtocolFees(
    double swapProtocolFees,
  ) {
    state = state.copyWith(
      swapProtocolFees: swapProtocolFees,
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

  void setFinalAmount(double? finalAmount) {
    state = state.copyWith(finalAmount: finalAmount);
  }

  void setFailure(aedappfm.Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setSwapProcessStep(
    aedappfm.ProcessStep swapProcessStep,
  ) {
    state = state.copyWith(
      processStep: swapProcessStep,
    );
  }

  void setMessageMaxHalfUCO(
    bool messageMaxHalfUCO,
  ) {
    state = state.copyWith(
      messageMaxHalfUCO: messageMaxHalfUCO,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (await control(context) == false) {
      return;
    }

    setSwapProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  Future<bool> control(BuildContext context) async {
    setMessageMaxHalfUCO(false);
    setFailure(null);
    if (kIsWeb &&
        (BrowserUtil().isEdgeBrowser() ||
            BrowserUtil().isInternetExplorerBrowser())) {
      setFailure(
        const aedappfm.Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.tokenToSwap == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenToSwapEmpty,
        ),
      );
      return false;
    }

    if (state.tokenSwapped == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenSwappedEmpty,
        ),
      );
      return false;
    }

    if (state.tokenToSwapAmount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenToSwapEmpty,
        ),
      );
      return false;
    }

    if (state.tokenSwappedAmount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenSwappedEmpty,
        ),
      );
      return false;
    }

    if (state.tokenToSwapAmount > state.tokenToSwapBalance) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .swapControlTokenToSwapAmountExceedBalance,
        ),
      );
      return false;
    }

    var feesEstimatedUCO = 0.0;
    if (state.tokenToSwap != null && state.tokenToSwap!.isUCO) {
      state = state.copyWith(calculationInProgress: true);
      feesEstimatedUCO = await SwapCase().estimateFees(
        state.poolGenesisAddress,
        state.tokenToSwap!,
        state.tokenToSwapAmount,
        state.slippageTolerance,
      );
      state = state.copyWith(calculationInProgress: false);
    }
    state = state.copyWith(
      feesEstimatedUCO: feesEstimatedUCO,
    );
    if (feesEstimatedUCO > 0) {
      if (state.tokenToSwapAmount + feesEstimatedUCO >
          state.tokenToSwapBalance) {
        final adjustedAmount = state.tokenToSwapBalance - feesEstimatedUCO;
        if (adjustedAmount < 0) {
          state = state.copyWith(messageMaxHalfUCO: true);
          setFailure(const aedappfm.Failure.insufficientFunds());
          return false;
        } else {
          await setTokenToSwapAmount(adjustedAmount);
          state = state.copyWith(messageMaxHalfUCO: true);
        }
      }
    }

    return true;
  }

  Future<void> swap(BuildContext context, WidgetRef ref) async {
    setSwapOk(false);
    setProcessInProgress(true);

    if (await control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final finalAmount = await SwapCase().run(
      ref,
      ref.watch(NotificationProviders.notificationService),
      state.poolGenesisAddress,
      state.tokenToSwap!,
      state.tokenSwapped!,
      state.tokenToSwapAmount,
      state.slippageTolerance,
    );
    state = state.copyWith(finalAmount: finalAmount);

    if (state.pool != null) {
      ref.read(DexPoolProviders.updatePoolInCache(state.pool!));
    }
  }
}

abstract class SwapFormProvider {
  static final swapForm = _swapFormProvider;
}
