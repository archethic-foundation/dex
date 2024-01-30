import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/add_pool.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _poolAddFormProvider =
    NotifierProvider.autoDispose<PoolAddFormNotifier, PoolAddFormState>(
  () {
    return PoolAddFormNotifier();
  },
);

class PoolAddFormNotifier extends AutoDisposeNotifier<PoolAddFormState> {
  PoolAddFormNotifier();

  @override
  PoolAddFormState build() => const PoolAddFormState();

  Future<void> setToken1(
    DexToken token,
  ) async {
    state = state.copyWith(
      failure: null,
      token1: token,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        token.isUCO ? 'UCO' : token.address!,
      ).future,
    );
    state = state.copyWith(token1Balance: balance);
  }

  Future<void> setToken2(
    DexToken token,
  ) async {
    state = state.copyWith(
      failure: null,
      token2: token,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        token.isUCO ? 'UCO' : token.address!,
      ).future,
    );
    state = state.copyWith(token2Balance: balance);
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

  void setToken1Amount(
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      token1Amount: amount,
    );
  }

  void setToken2Amount(
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      token2Amount: amount,
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

  void setPoolAddOk(bool poolAddOk) {
    state = state.copyWith(
      failure: null,
      poolAddOk: poolAddOk,
    );
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setPoolAddProcessStep(
    PoolAddProcessStep poolAddProcessStep,
  ) {
    state = state.copyWith(
      poolAddProcessStep: poolAddProcessStep,
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

  void setRecoveryTransactionAddPool(Transaction? recoveryTransactionAddPool) {
    state =
        state.copyWith(recoveryTransactionAddPool: recoveryTransactionAddPool);
  }

  void setRecoveryTransactionAddPoolTransfer(
    Transaction? recoveryTransactionAddPoolTransfer,
  ) {
    state = state.copyWith(
      recoveryTransactionAddPoolTransfer: recoveryTransactionAddPoolTransfer,
    );
  }

  void setRecoveryTransactionAddPoolLiquidity(
    Transaction? recoveryTransactionAddPoolLiquidity,
  ) {
    state = state.copyWith(
      recoveryTransactionAddPoolLiquidity: recoveryTransactionAddPoolLiquidity,
    );
  }

  void setRecoveryPoolGenesisAddress(String? recoveryPoolGenesisAddress) {
    state = state.copyWith(
      recoveryPoolGenesisAddress: recoveryPoolGenesisAddress,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    final _control = await control(context);
    if (_control == false) {
      return;
    }

    setPoolAddProcessStep(
      PoolAddProcessStep.confirmation,
    );
  }

  Future<bool> control(BuildContext context) async {
    setFailure(null);

    if (kIsWeb &&
        (BrowserUtil().isEdgeBrowser() ||
            BrowserUtil().isInternetExplorerBrowser())) {
      setFailure(
        const Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.token1 == null) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken1Empty,
        ),
      );
      return false;
    }

    if (state.token2 == null) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken2Empty,
        ),
      );
      return false;
    }

    if (state.token1Amount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken1Empty,
        ),
      );
      return false;
    }

    if (state.token2Amount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken2Empty,
        ),
      );
      return false;
    }

    if (state.token1Amount > state.token1Balance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .poolAddControlToken1AmountExceedBalance,
        ),
      );
      return false;
    }

    if (state.token2Amount > state.token2Balance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .poolAddControlToken2AmountExceedBalance,
        ),
      );
      return false;
    }

    final dexConfig =
        await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();

    final apiService = sl.get<ApiService>();
    final routerFactory =
        RouterFactory(dexConfig.routerGenesisAddress, apiService);
    final poolInfosResult = await routerFactory.getPoolAddresses(
      state.token1!.isUCO ? 'UCO' : state.token1!.address!,
      state.token2!.isUCO ? 'UCO' : state.token2!.address!,
    );
    poolInfosResult.map(
      success: (success) {
        if (success != null && success['address'] != null) {
          setFailure(const PoolAlreadyExists());
        }
      },
      failure: (failure) {},
    );

    if (state.failure != null) {
      return false;
    }

    return true;
  }

  Future<void> add(BuildContext context, WidgetRef ref) async {
    setPoolAddOk(false);
    final _control = await control(context);
    if (_control == false) {
      return;
    }
    setProcessInProgress(true);

    final dexConfig =
        await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();

    await AddPoolCase().run(
      ref,
      state.token1!,
      state.token1Amount,
      state.token2!,
      state.token2Amount,
      dexConfig.routerGenesisAddress,
      dexConfig.factoryGenesisAddress,
      state.slippage,
      recoveryStep: state.currentStep,
      recoveryTransactionAddPool: state.recoveryTransactionAddPool,
      recoveryTransactionAddPoolTransfer:
          state.recoveryTransactionAddPoolTransfer,
      recoveryTransactionAddPoolLiquidity:
          state.recoveryTransactionAddPoolLiquidity,
    );
    setResumeProcess(false);
    setProcessInProgress(false);
    setPoolAddOk(true);
    ref.read(
      DexPoolProviders.putPoolToCache(state.recoveryPoolGenesisAddress!),
    );
  }
}

abstract class PoolAddFormProvider {
  static final poolAddForm = _poolAddFormProvider;
}
