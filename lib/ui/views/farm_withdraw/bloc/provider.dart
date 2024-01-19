import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/withdraw_farm.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _farmWithdrawFormProvider = NotifierProvider.autoDispose<
    FarmWithdrawFormNotifier, FarmWithdrawFormState>(
  () {
    return FarmWithdrawFormNotifier();
  },
);

class FarmWithdrawFormNotifier
    extends AutoDisposeNotifier<FarmWithdrawFormState> {
  FarmWithdrawFormNotifier();

  @override
  FarmWithdrawFormState build() => const FarmWithdrawFormState();

  void setTransactionWithdrawFarm(Transaction transactionWithdrawFarm) {
    state = state.copyWith(transactionWithdrawFarm: transactionWithdrawFarm);
  }

  Future<void> initBalances() async {
    final session = ref.read(SessionProviders.session);

    final userInfos = await ref.read(
      DexFarmProviders.getUserInfos(
        state.dexFarmInfos!.farmAddress,
        session.genesisAddress,
      ).future,
    );
    state = state.copyWith(lpTokenDepositedBalance: userInfos!.depositedAmount);

    final apiService = sl.get<ApiService>();
    final dexConfig =
        await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();

    // TODO(reddwarf): Cache management
    final poolListResult =
        await RouterFactory(dexConfig.routerGenesisAddress, apiService)
            .getPoolList();
    await poolListResult.map(
      success: (poolList) async {
        final dexpool = poolList.singleWhere(
          (pool) =>
              pool.lpToken!.address!.toUpperCase() ==
              state.dexFarmInfos!.lpToken!.address!.toUpperCase(),
        );

        final removeAmountsResult =
            await PoolFactory(dexpool.poolAddress, apiService)
                .getRemoveAmounts(userInfos.depositedAmount);

        removeAmountsResult.map(
          success: (removeAmounts) {
            final token1 = removeAmounts!['token1'] as double;
            final token2 = removeAmounts['token2'] as double;
          },
          failure: (failure) {},
        );
      },
      failure: (failure) {},
    );
  }

  void setAmount(
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      amount: amount,
    );
  }

  void setAmountMax() {
    setAmount(state.lpTokenDepositedBalance);
  }

  void setAmountHalf() {
    setAmount(
      (Decimal.parse(state.lpTokenDepositedBalance.toString()) /
              Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setDexFarmInfos(DexFarm dexFarmInfos) {
    state = state.copyWith(
      dexFarmInfos: dexFarmInfos,
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

  void setFarmWithdrawOk(bool farmWithdrawOk) {
    state = state.copyWith(
      farmWithdrawOk: farmWithdrawOk,
    );
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setFarmWithdrawProcessStep(
    FarmWithdrawProcessStep farmWithdrawProcessStep,
  ) {
    state = state.copyWith(
      farmWithdrawProcessStep: farmWithdrawProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setFarmWithdrawProcessStep(
      FarmWithdrawProcessStep.confirmation,
    );
  }

  bool control(BuildContext context) {
    setFailure(null);

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      setFailure(
        const Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.amount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.farmWithdrawControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.lpTokenDepositedBalance) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!
              .farmWithdrawControlLPTokenAmountExceedDeposited,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> withdraw(BuildContext context, WidgetRef ref) async {
    setFarmWithdrawOk(false);

    if (control(context) == false) {
      return;
    }
    setProcessInProgress(true);

    await WithdrawFarmCase().run(
      ref,
      state.dexFarmInfos!.farmAddress,
      state.dexFarmInfos!.lpToken!.address!,
      state.amount,
    );

    setResumeProcess(false);
    setProcessInProgress(false);
    setFarmWithdrawOk(true);
  }
}

abstract class FarmWithdrawFormProvider {
  static final farmWithdrawForm = _farmWithdrawFormProvider;
}
