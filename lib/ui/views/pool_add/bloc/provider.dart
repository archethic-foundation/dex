import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class PoolAddFormNotifier extends _$PoolAddFormNotifier {
  PoolAddFormNotifier();

  @override
  PoolAddFormState build() => const PoolAddFormState();

  void setPoolsListTab(PoolsListTab poolsListTab) {
    state = state.copyWith(poolsListTab: poolsListTab);
  }

  Future<void> setToken1(
    DexToken token,
    AppLocalizations appLocalizations,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      token1: token,
    );

    final balance = await ref.read(
      getBalanceProvider(
        token.isUCO ? 'UCO' : token.address,
      ).future,
    );
    state = state.copyWith(token1Balance: balance);
    if (state.token1 != null &&
        state.token2 != null &&
        state.token1!.address == state.token2!.address) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlSameTokens,
        ),
      );
      return;
    }

    if (state.token1 != null && state.token1Amount > state.token1Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken1AmountExceedBalance,
        ),
      );
    }

    _controlBalances(appLocalizations);
  }

  Future<void> setToken2(
    DexToken token,
    AppLocalizations appLocalizations,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      token2: token,
    );

    final balance = await ref.read(
      getBalanceProvider(
        token.isUCO ? 'UCO' : token.address,
      ).future,
    );
    state = state.copyWith(token2Balance: balance);

    if (state.token1 != null &&
        state.token2 != null &&
        state.token1!.address == state.token2!.address) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlSameTokens,
        ),
      );
      return;
    }

    _controlBalances(appLocalizations);
  }

  void _controlBalances(AppLocalizations appLocalizations) {
    if (state.token1 != null &&
        state.token1Amount > state.token1Balance &&
        state.token2 != null &&
        state.token2Amount > state.token2Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControl2TokensAmountExceedBalance,
        ),
      );
      return;
    }

    if (state.token1 != null && state.token1Amount > state.token1Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken1AmountExceedBalance,
        ),
      );

      return;
    }

    if (state.token2 != null && state.token2Amount > state.token2Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken2AmountExceedBalance,
        ),
      );
      return;
    }
  }

  void setToken1AmountMax(AppLocalizations appLocalizations) {
    setToken1Amount(appLocalizations, state.token1Balance);
  }

  void setToken2AmountMax(AppLocalizations appLocalizations) {
    setToken2Amount(appLocalizations, state.token2Balance);
  }

  void setToken1AmountHalf(AppLocalizations appLocalizations) {
    setToken1Amount(
      appLocalizations,
      (Decimal.parse(state.token1Balance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setToken2AmountHalf(AppLocalizations appLocalizations) {
    setToken2Amount(
      appLocalizations,
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
    AppLocalizations appLocalizations,
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      token1Amount: amount,
    );

    if (state.token1 != null && state.token1Amount > state.token1Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken1AmountExceedBalance,
        ),
      );
    }

    _controlBalances(appLocalizations);
  }

  void setToken2Amount(
    AppLocalizations appLocalizations,
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      token2Amount: amount,
    );

    _controlBalances(appLocalizations);
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

  void setWalletConfirmation(bool walletConfirmation) {
    state = state.copyWith(
      walletConfirmation: walletConfirmation,
    );
  }

  void setPoolAddOk(bool poolAddOk) {
    state = state.copyWith(
      messageMaxHalfUCO: false,
      failure: null,
      poolAddOk: poolAddOk,
    );
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setPoolAddProcessStep(
    aedappfm.ProcessStep poolAddProcessStep,
  ) {
    state = state.copyWith(
      processStep: poolAddProcessStep,
    );
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setTokenFormSelected(int tokenFormSelected) {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      tokenFormSelected: tokenFormSelected,
    );
  }

  void setRecoveryTransactionAddPool(
    archethic.Transaction? recoveryTransactionAddPool,
  ) {
    state =
        state.copyWith(recoveryTransactionAddPool: recoveryTransactionAddPool);
  }

  void setRecoveryTransactionAddPoolTransfer(
    archethic.Transaction? recoveryTransactionAddPoolTransfer,
  ) {
    state = state.copyWith(
      recoveryTransactionAddPoolTransfer: recoveryTransactionAddPoolTransfer,
    );
  }

  void setRecoveryTransactionAddPoolLiquidity(
    archethic.Transaction? recoveryTransactionAddPoolLiquidity,
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

  void setMessageMaxHalfUCO(
    bool messageMaxHalfUCO,
  ) {
    state = state.copyWith(
      messageMaxHalfUCO: messageMaxHalfUCO,
    );
  }

  Future<void> validateForm(AppLocalizations appLocalizations) async {
    final _control = await control(appLocalizations);
    if (_control == false) {
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setPoolAddProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  Future<bool> control(AppLocalizations appLocalizations) async {
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

    if (state.token1 == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken1Empty,
        ),
      );
      return false;
    }

    if (state.token2 == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken2Empty,
        ),
      );
      return false;
    }

    if (state.token1!.address == state.token2!.address) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlSameTokens,
        ),
      );
      return false;
    }

    if (state.token1Amount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken1Empty,
        ),
      );
      return false;
    }

    if (state.token2Amount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken2Empty,
        ),
      );
      return false;
    }

    if (state.token1Amount > state.token1Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken1AmountExceedBalance,
        ),
      );
      return false;
    }

    if (state.token2Amount > state.token2Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.poolAddControlToken2AmountExceedBalance,
        ),
      );
      return false;
    }

    final dexConfig = await ref.read(DexConfigProviders.dexConfig.future);

    final routerFactory = ref.read(
      routerFactoryProvider(
        dexConfig.routerGenesisAddress,
      ),
    );
    final poolInfosResult = await routerFactory.getPoolAddresses(
      state.token1!.isUCO ? 'UCO' : state.token1!.address,
      state.token2!.isUCO ? 'UCO' : state.token2!.address,
    );
    poolInfosResult.map(
      success: (success) {
        if (success != null && success['address'] != null) {
          setFailure(const aedappfm.PoolAlreadyExists());
        }
      },
      failure: (failure) {},
    );

    if (state.failure != null) {
      return false;
    }

    var estimateFees = 0.0;
    if (state.token1 != null && state.token1!.isUCO) {
      final archethicOracleUCO =
          ref.read(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);
      if (archethicOracleUCO.usd > 0) {
        estimateFees = 0.5 / archethicOracleUCO.usd;
      }
      if (estimateFees > 0) {
        if (state.token1Amount + estimateFees > state.token1Balance) {
          final adjustedAmount = state.token1Balance - estimateFees;
          if (adjustedAmount < 0) {
            state = state.copyWith(messageMaxHalfUCO: true);
            setFailure(const aedappfm.Failure.insufficientFunds());
            return false;
          } else {
            setToken1Amount(appLocalizations, adjustedAmount);
            state = state.copyWith(messageMaxHalfUCO: true);
          }
        }
      }
    }
    if (state.token2 != null && state.token2!.isUCO) {
      final archethicOracleUCO =
          ref.read(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);
      if (archethicOracleUCO.usd > 0) {
        estimateFees = 0.5 / archethicOracleUCO.usd;
      }
      if (estimateFees > 0) {
        if (state.token2Amount + estimateFees > state.token2Balance) {
          final adjustedAmount = state.token2Balance - estimateFees;
          if (adjustedAmount < 0) {
            state = state.copyWith(messageMaxHalfUCO: true);
            setFailure(const aedappfm.Failure.insufficientFunds());
            return false;
          } else {
            setToken2Amount(appLocalizations, adjustedAmount);
            state = state.copyWith(messageMaxHalfUCO: true);
          }
        }
      }
    }

    return true;
  }

  Future<void> add(AppLocalizations appLocalizations) async {
    setProcessInProgress(true);
    setPoolAddOk(false);
    final _control = await control(appLocalizations);
    if (_control == false) {
      setProcessInProgress(false);
      return;
    }

    final dexConfig = await ref.read(DexConfigProviders.dexConfig.future);

    final session = ref.read(sessionNotifierProvider);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);

    await ref.read(addPoolCaseProvider).run(
          appLocalizations,
          this,
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

    ref.invalidate(userBalanceProvider);
  }
}
