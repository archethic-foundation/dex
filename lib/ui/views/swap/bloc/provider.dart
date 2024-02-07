import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/oracle/provider.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/swap.usecase.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/ui/views/util/delayed_task.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
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

  CancelableTask<
      ({
        double outputAmount,
        double fees,
        double priceImpact,
        double protocolFees,
      })>? _calculateSwapInfosTask;

  Future<void> getPool() async {
    final pool = await ref
        .read(DexPoolProviders.getPool(state.poolGenesisAddress).future);
    if (pool != null) {
      setPool(pool);
    }
  }

  void setPool(DexPool pool) {
    state = state.copyWith(pool: pool);
  }

  Future<void> setTokenToSwap(
    DexToken tokenToSwap,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
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
              await getRatio();
              await getPool();
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
    final apiService = sl.get<ApiService>();
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
          _calculateSwapInfosTask = CancelableTask<
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
    } on CanceledTask {
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

    var swapInfos =
        (fees: 0.0, outputAmount: 0.0, priceImpact: 0.0, protocolFees: 0.0);

    if (tokenToSwapAmount > 0) {
      state = state.copyWith(
        calculateAmountSwapped: true,
      );
      swapInfos = await calculateSwapInfos(
        state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
        tokenToSwapAmount,
      );
      state = state.copyWith(
        tokenSwappedAmount: swapInfos.outputAmount,
      );
    } else {
      if (state.tokenSwapped != null && state.tokenSwappedAmount > 0) {
        state = state.copyWith(
          calculateAmountToSwap: true,
        );
        swapInfos = await calculateSwapInfos(
          state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
          state.tokenSwappedAmount,
        );
        state = state.copyWith(
          tokenToSwapAmount: swapInfos.outputAmount,
        );
      }
    }

    final minToReceive = (Decimal.parse(swapInfos.outputAmount.toString()) *
            (((Decimal.parse('100') -
                        Decimal.parse(
                          state.slippageTolerance.toString(),
                        )) /
                    Decimal.parse('100'))
                .toDecimal()))
        .toDouble();

    state = state.copyWith(
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      swapProtocolFees: swapInfos.protocolFees,
      minToReceive: minToReceive,
      calculateAmountSwapped: false,
      calculateAmountToSwap: false,
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

    var swapInfos =
        (fees: 0.0, outputAmount: 0.0, priceImpact: 0.0, protocolFees: 0.0);
    if (tokenSwappedAmount > 0) {
      state = state.copyWith(
        calculateAmountToSwap: true,
      );
      swapInfos = await calculateSwapInfos(
        state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
        tokenSwappedAmount,
      );
      state = state.copyWith(
        tokenToSwapAmount: swapInfos.outputAmount,
      );
    } else {
      if (state.tokenToSwap != null && state.tokenToSwapAmount > 0) {
        state = state.copyWith(
          calculateAmountSwapped: true,
        );
        swapInfos = await calculateSwapInfos(
          state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
          state.tokenToSwapAmount,
        );
        state = state.copyWith(
          tokenSwappedAmount: swapInfos.outputAmount,
        );
      }
    }

    final minToReceive = (Decimal.parse(swapInfos.outputAmount.toString()) *
            (((Decimal.parse('100') -
                        Decimal.parse(
                          state.slippageTolerance.toString(),
                        )) /
                    Decimal.parse('100'))
                .toDecimal()))
        .toDouble();

    state = state.copyWith(
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      swapProtocolFees: swapInfos.protocolFees,
      minToReceive: minToReceive,
      calculateAmountSwapped: false,
      calculateAmountToSwap: false,
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

    if (state.tokenToSwap != null) {
      final dexConfig =
          await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
      final apiService = sl.get<ApiService>();
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
    if (state.tokenToSwap == null) {
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
      SwapProcessStep.confirmation,
    );
  }

  Future<bool> control(BuildContext context) async {
    setMessageMaxHalfUCO(false);
    setFailure(null);
    if (kIsWeb &&
        (BrowserUtil().isEdgeBrowser() ||
            BrowserUtil().isInternetExplorerBrowser())) {
      setFailure(
        const Failure.incompatibleBrowser(),
      );
      return false;
    }

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

    var estimateFees = 0.0;
    if (state.tokenToSwap != null && state.tokenToSwap!.isUCO) {
      final archethicOracleUCO =
          ref.read(ArchethicOracleUCOProviders.archethicOracleUCO);
      if (archethicOracleUCO.usd > 0) {
        estimateFees = 0.5 / archethicOracleUCO.usd;
      }
      if (estimateFees > 0) {
        if (estimateFees > state.tokenToSwapAmount) {
          state = state.copyWith(messageMaxHalfUCO: true);
          setFailure(const Failure.insufficientFunds());
          return false;
        }
        if (state.tokenToSwapAmount + estimateFees > state.tokenToSwapBalance) {
          final adjustedAmount = state.tokenToSwapBalance - estimateFees;
          if (adjustedAmount < 0) {
            state = state.copyWith(messageMaxHalfUCO: true);
            setFailure(const Failure.insufficientFunds());
            return false;
          } else {
            await setTokenToSwapAmount(adjustedAmount);
            state = state.copyWith(messageMaxHalfUCO: true);
          }
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

    await SwapCase().run(
      ref,
      state.poolGenesisAddress,
      state.tokenToSwap!,
      state.tokenToSwapAmount,
      state.slippageTolerance,
    );
    ref.read(DexPoolProviders.updatePoolInCache(state.pool!));
  }
}

abstract class SwapFormProvider {
  static final swapForm = _swapFormProvider;
}
