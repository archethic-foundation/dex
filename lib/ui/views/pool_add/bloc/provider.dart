import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/add_pool.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
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
      token1: token,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        token.address!,
      ).future,
    );
    state = state.copyWith(token1Balance: balance);
  }

  Future<void> setToken2(
    DexToken token,
  ) async {
    state = state.copyWith(
      token2: token,
    );

    final session = ref.read(SessionProviders.session);
    final balance = await ref.read(
      BalanceProviders.getBalance(
        session.genesisAddress,
        token.address!,
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
      token1Amount: amount,
    );
  }

  void setToken2Amount(
    double amount,
  ) {
    state = state.copyWith(
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

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setPoolAddProcessStep(
      PoolAddProcessStep.confirmation,
    );
  }

  bool control(BuildContext context) {
    setFailure(null);

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

    return true;
  }

  Future<void> add(BuildContext context, WidgetRef ref) async {
    if (control(context) == false) {
      return;
    }
    setProcessInProgress(true);

    final dexConfig = await ref
        .read(DexConfigProviders.dexConfigRepository)
        .getDexConfig('devnet');

    await AddPoolCase().run(
      ref,
      state.token1!,
      state.token1Amount,
      state.token2!,
      state.token2Amount,
      dexConfig.routerGenesisAddress,
      state.slippage,
    );

    setProcessInProgress(false);
  }
}

abstract class PoolAddFormProvider {
  static final poolAddForm = _poolAddFormProvider;
}
