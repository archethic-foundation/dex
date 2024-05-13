import 'package:aedex/application/balance.dart';
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/usecases/add_pool.usecase.dart';
import 'package:aedex/ui/views/pool_add/bloc/state.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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

  void setPoolsListTab(PoolsListTab poolsListTab) {
    state = state.copyWith(poolsListTab: poolsListTab);
  }

  Future<void> setToken1(
    DexToken token,
    BuildContext context,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
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
    if (state.token1 != null &&
        state.token2 != null &&
        state.token1!.address == state.token2!.address) {
      setFailure(
        aedappfm.Failure.other(
          cause: context.mounted
              ? AppLocalizations.of(context)!.poolAddControlSameTokens
              : '',
        ),
      );
      return;
    }

    if (state.token1 != null && state.token1Amount > state.token1Balance) {
      if (context.mounted) {
        setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!
                .poolAddControlToken1AmountExceedBalance,
          ),
        );
      }
    }

    if (context.mounted) {
      _controlBalances(context);
    }
  }

  Future<void> setToken2(
    DexToken token,
    BuildContext context,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
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

    if (state.token1 != null &&
        state.token2 != null &&
        state.token1!.address == state.token2!.address) {
      setFailure(
        aedappfm.Failure.other(
          cause: context.mounted
              ? AppLocalizations.of(context)!.poolAddControlSameTokens
              : '',
        ),
      );
      return;
    }

    if (context.mounted) {
      _controlBalances(context);
    }
  }

  void _controlBalances(BuildContext context) {
    if (state.token1 != null &&
        state.token1Amount > state.token1Balance &&
        state.token2 != null &&
        state.token2Amount > state.token2Balance &&
        context.mounted) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .poolAddControl2TokensAmountExceedBalance,
        ),
      );
      return;
    }

    if (state.token1 != null && state.token1Amount > state.token1Balance) {
      if (context.mounted) {
        setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!
                .poolAddControlToken1AmountExceedBalance,
          ),
        );
      }
      return;
    }

    if (state.token2 != null &&
        state.token2Amount > state.token2Balance &&
        context.mounted) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .poolAddControlToken2AmountExceedBalance,
        ),
      );
      return;
    }
  }

  void setToken1AmountMax(BuildContext context) {
    setToken1Amount(context, state.token1Balance);
  }

  void setToken2AmountMax(BuildContext context) {
    setToken2Amount(context, state.token2Balance);
  }

  void setToken1AmountHalf(BuildContext context) {
    setToken1Amount(
      context,
      (Decimal.parse(state.token1Balance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setToken2AmountHalf(BuildContext context) {
    setToken2Amount(
      context,
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
    BuildContext context,
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
          cause: AppLocalizations.of(context)!
              .poolAddControlToken1AmountExceedBalance,
        ),
      );
    }

    if (context.mounted) {
      _controlBalances(context);
    }
  }

  void setToken2Amount(
    BuildContext context,
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      token2Amount: amount,
    );

    if (context.mounted) {
      _controlBalances(context);
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

  void setMessageMaxHalfUCO(
    bool messageMaxHalfUCO,
  ) {
    state = state.copyWith(
      messageMaxHalfUCO: messageMaxHalfUCO,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    final _control = await control(context);
    if (_control == false) {
      return;
    }

    final session = ref.read(SessionProviders.session);
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setPoolAddProcessStep(
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

    if (state.token1 == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken1Empty,
        ),
      );
      return false;
    }

    if (state.token2 == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken2Empty,
        ),
      );
      return false;
    }

    if (state.token1!.address == state.token2!.address) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlSameTokens,
        ),
      );
      return false;
    }

    if (state.token1Amount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken1Empty,
        ),
      );
      return false;
    }

    if (state.token2Amount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.poolAddControlToken2Empty,
        ),
      );
      return false;
    }

    if (state.token1Amount > state.token1Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .poolAddControlToken1AmountExceedBalance,
        ),
      );
      return false;
    }

    if (state.token2Amount > state.token2Balance) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .poolAddControlToken2AmountExceedBalance,
        ),
      );
      return false;
    }

    final dexConfig =
        await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();

    final apiService = aedappfm.sl.get<ApiService>();
    final routerFactory =
        RouterFactory(dexConfig.routerGenesisAddress, apiService);
    final poolInfosResult = await routerFactory.getPoolAddresses(
      state.token1!.isUCO ? 'UCO' : state.token1!.address!,
      state.token2!.isUCO ? 'UCO' : state.token2!.address!,
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
            if (context.mounted) {
              setToken1Amount(context, adjustedAmount);
            }
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
            if (context.mounted) {
              setToken2Amount(context, adjustedAmount);
            }
            state = state.copyWith(messageMaxHalfUCO: true);
          }
        }
      }
    }

    return true;
  }

  Future<void> add(BuildContext context, WidgetRef ref) async {
    setProcessInProgress(true);
    setPoolAddOk(false);
    final _control = await control(context);
    if (_control == false) {
      setProcessInProgress(false);
      return;
    }

    final dexConfig =
        await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();

    final session = ref.read(SessionProviders.session);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);

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

    await ref.read(SessionProviders.session.notifier).refreshUserBalance();
  }
}

abstract class PoolAddFormProvider {
  static final poolAddForm = _poolAddFormProvider;
}
