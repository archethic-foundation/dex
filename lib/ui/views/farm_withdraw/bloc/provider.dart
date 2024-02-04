import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/withdraw_farm.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
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

    final userInfo = await ref.read(
      DexFarmProviders.getUserInfos(
        state.dexFarmInfo!.farmAddress,
        session.genesisAddress,
      ).future,
    );
    state = state.copyWith(dexFarmUserInfo: userInfo);
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

  void setDexFarmInfo(DexFarm dexFarmInfo) {
    state = state.copyWith(
      dexFarmInfo: dexFarmInfo,
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

    if (state.amount > state.dexFarmUserInfo!.depositedAmount) {
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
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    await WithdrawFarmCase().run(
      ref,
      state.dexFarmInfo!.farmAddress,
      state.dexFarmInfo!.lpToken!.address!,
      state.amount,
    );
  }
}

abstract class FarmWithdrawFormProvider {
  static final farmWithdrawForm = _farmWithdrawFormProvider;
}
