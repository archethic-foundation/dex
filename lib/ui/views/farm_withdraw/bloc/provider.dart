import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/usecases/withdraw_farm.usecase.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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

  void setDexFarmInfo(DexFarm dexFarmInfo) {
    state = state.copyWith(
      dexFarmInfo: dexFarmInfo,
    );
  }

  void setDexFarmUserInfo(DexFarmUserInfos dexFarmUserInfo) {
    state = state.copyWith(
      dexFarmUserInfo: dexFarmUserInfo,
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
    setAmount(state.dexFarmUserInfo!.depositedAmount);
  }

  void setAmountHalf() {
    setAmount(
      (Decimal.parse(state.dexFarmUserInfo!.depositedAmount.toString()) /
              Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setFarmAddress(String farmAddress) {
    state = state.copyWith(
      farmAddress: farmAddress,
    );
  }

  void setRewardToken(DexToken rewardToken) {
    state = state.copyWith(
      rewardToken: rewardToken,
    );
  }

  void setLpTokenAddress(String lpTokenAddress) {
    state = state.copyWith(
      lpTokenAddress: lpTokenAddress,
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
    aedappfm.ProcessStep farmWithdrawProcessStep,
  ) {
    state = state.copyWith(
      processStep: farmWithdrawProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setFarmWithdrawProcessStep(
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

    if (state.amount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.farmWithdrawControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.dexFarmUserInfo!.depositedAmount) {
      setFailure(
        aedappfm.Failure.other(
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
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    await WithdrawFarmCase().run(
      ref,
      state.farmAddress!,
      state.lpTokenAddress!,
      state.amount,
    );
  }
}

abstract class FarmWithdrawFormProvider {
  static final farmWithdrawForm = _farmWithdrawFormProvider;
}
