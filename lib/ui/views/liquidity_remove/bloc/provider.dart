import 'package:aedex/application/balance.dart';
import 'package:aedex/application/notification.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/usecases/remove_liquidity.usecase.dart';
import 'package:aedex/infrastructure/pool_factory.repository.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/state.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_list_item.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
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

  aedappfm.CancelableTask<Map<String, dynamic>>? _calculateRemoveAmountsTask;

  Future<void> setPool(DexPool pool) async {
    state = state.copyWith(pool: pool);

    final poolPopulated =
        await ref.read(DexPoolProviders.loadPoolCard(pool).future);
    state = state.copyWith(pool: poolPopulated);
  }

  void setPoolsListTab(PoolsListTab poolsListTab) {
    state = state.copyWith(poolsListTab: poolsListTab);
  }

  Future<({double removeAmountToken1, double removeAmountToken2, bool cancel})>
      _calculateRemoveAmounts(
    double lpTokenAmount, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    final apiService = aedappfm.sl.get<ApiService>();
    late final Map<String, dynamic> removeAmounts;
    try {
      removeAmounts = await Future<Map<String, dynamic>>(
        () async {
          if (lpTokenAmount <= 0) {
            return {};
          }

          _calculateRemoveAmountsTask?.cancel();
          _calculateRemoveAmountsTask =
              aedappfm.CancelableTask<Map<String, dynamic>>(
            task: () async {
              var _removeAmounts = <String, dynamic>{};
              final amounts = await PoolFactoryRepositoryImpl(
                state.pool!.poolAddress,
                apiService,
              ).getRemoveAmounts(lpTokenAmount);

              if (amounts != null) {
                _removeAmounts = amounts;
              } else {
                setFailure(
                  const aedappfm.Failure.other(
                    cause: 'getRemoveAmounts null value',
                  ),
                );
              }

              return _removeAmounts;
            },
          );

          final _removeAmounts =
              await _calculateRemoveAmountsTask?.schedule(delay);

          return _removeAmounts ?? {};
        },
      );
    } on aedappfm.CanceledTask {
      return (removeAmountToken1: 0.0, removeAmountToken2: 0.0, cancel: true);
    }

    return (
      removeAmountToken1: removeAmounts['token1'] == null
          ? 0.0
          : removeAmounts['token1'] as double,
      removeAmountToken2: removeAmounts['token2'] == null
          ? 0.0
          : removeAmounts['token2'] as double,
      cancel: false,
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

  void setTransactionRemoveLiquidity(Transaction transactionRemoveLiquidity) {
    state =
        state.copyWith(transactionRemoveLiquidity: transactionRemoveLiquidity);
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

    if (amount == 0) return;

    if (amount > state.lpTokenBalance) {
      setFailure(
        const aedappfm.Failure.lpTokenAmountExceedBalance(),
      );
      state = state.copyWith(
        token1AmountGetBack: 0,
        token2AmountGetBack: 0,
      );
      return;
    }

    state = state.copyWith(
      calculationInProgress: true,
    );

    final calculateRemoveAmountsResult = await _calculateRemoveAmounts(amount);
    final isCalculateCancel = calculateRemoveAmountsResult.cancel;
    if (isCalculateCancel) return;

    state = state.copyWith(
      token1AmountGetBack: calculateRemoveAmountsResult.removeAmountToken1,
      token2AmountGetBack: calculateRemoveAmountsResult.removeAmountToken2,
    );
    final session = ref.read(SessionProviders.session);
    final balanceToken1 = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.token1!.isUCO ? 'UCO' : state.token1!.address!,
      ).future,
    );
    state = state.copyWith(token1Balance: balanceToken1);
    final balanceToken2 = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        state.token2!.isUCO ? 'UCO' : state.token2!.address!,
      ).future,
    );
    state = state.copyWith(
      token2Balance: balanceToken2,
      calculationInProgress: false,
    );

    if (amount > 0 &&
        (state.token1AmountGetBack == 0 || state.token2AmountGetBack == 0)) {
      setFailure(
        const aedappfm.Failure.other(
          cause:
              'The amount provided is too low to claim amounts on the pair of tokens',
        ),
      );
    }
  }

  void estimateNetworkFees() {
    state = state.copyWith(
      networkFees: 0,
    );
  }

  void setFailure(aedappfm.Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setFinalAmountToken1(double? finalAmountToken1) {
    state = state.copyWith(finalAmountToken1: finalAmountToken1);
  }

  void setFinalAmountToken2(double? finalAmountToken2) {
    state = state.copyWith(finalAmountToken2: finalAmountToken2);
  }

  void setFinalAmountLPToken(double? finalAmountLPToken) {
    state = state.copyWith(finalAmountLPToken: finalAmountLPToken);
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

  Future<void> setLpTokenAmountMax() async {
    await setLPTokenAmount(state.lpTokenBalance);
  }

  Future<void> setLpTokenAmountHalf() async {
    await setLPTokenAmount(
      (Decimal.parse(state.lpTokenBalance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
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
    aedappfm.ProcessStep liquidityRemoveProcessStep,
  ) {
    state = state.copyWith(
      processStep: liquidityRemoveProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    final session = ref.read(SessionProviders.session);
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setLiquidityRemoveProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  bool control(BuildContext context) {
    setFailure(null);

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      setFailure(
        const aedappfm.Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.lpTokenAmount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .liquidityRemoveControlLPTokenAmountEmpty,
        ),
      );
      return false;
    }

    if (state.lpTokenAmount > state.lpTokenBalance) {
      setFailure(
        const aedappfm.Failure.lpTokenAmountExceedBalance(),
      );
      return false;
    }

    return true;
  }

  Future<void> remove(BuildContext context, WidgetRef ref) async {
    setLiquidityRemoveOk(false);
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(SessionProviders.session);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);
    if (context.mounted) {
      final finalAmounts = await RemoveLiquidityCase().run(
        state.pool!.poolAddress,
        ref,
        context,
        ref.watch(NotificationProviders.notificationService),
        state.lpToken!.address!,
        state.lpTokenAmount,
        state.token1!,
        state.token2!,
        state.lpToken!,
        recoveryStep: state.currentStep,
      );
      state = state.copyWith(
        finalAmountToken1: finalAmounts.amountToken1,
        finalAmountToken2: finalAmounts.amountToken2,
        finalAmountLPToken: finalAmounts.amountLPToken,
      );

      await ref.read(SessionProviders.session.notifier).refreshUserBalance();
      if (context.mounted) {
        final poolListItemState =
            context.findAncestorStateOfType<PoolListItemState>();
        await poolListItemState?.reload();
      }
    }
  }
}

abstract class LiquidityRemoveFormProvider {
  static final liquidityRemoveForm = _liquidityRemoveFormProvider;
}
