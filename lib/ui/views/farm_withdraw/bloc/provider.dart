import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/withdraw_farm.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
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

  void setAmount(
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      amount: amount,
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
