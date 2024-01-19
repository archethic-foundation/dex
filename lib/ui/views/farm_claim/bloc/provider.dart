import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/claim_farm.dart';
import 'package:aedex/ui/views/farm_claim/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _farmClaimFormProvider =
    NotifierProvider.autoDispose<FarmClaimFormNotifier, FarmClaimFormState>(
  () {
    return FarmClaimFormNotifier();
  },
);

class FarmClaimFormNotifier extends AutoDisposeNotifier<FarmClaimFormState> {
  FarmClaimFormNotifier();

  @override
  FarmClaimFormState build() => const FarmClaimFormState();

  void setTransactionClaimFarm(Transaction transactionClaimFarm) {
    state = state.copyWith(transactionClaimFarm: transactionClaimFarm);
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

  void setFarmClaimOk(bool farmClaimOk) {
    state = state.copyWith(
      farmClaimOk: farmClaimOk,
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

  void setFarmClaimProcessStep(
    FarmClaimProcessStep farmClaimProcessStep,
  ) {
    state = state.copyWith(
      farmClaimProcessStep: farmClaimProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setFarmClaimProcessStep(
      FarmClaimProcessStep.confirmation,
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

    return true;
  }

  Future<void> claim(BuildContext context, WidgetRef ref) async {
    setFarmClaimOk(false);

    if (control(context) == false) {
      return;
    }
    setProcessInProgress(true);

    await ClaimFarmCase().run(ref, state.dexFarmInfos!.farmAddress);

    setResumeProcess(false);
    setProcessInProgress(false);
    setFarmClaimOk(true);
  }
}

abstract class FarmClaimFormProvider {
  static final farmClaimForm = _farmClaimFormProvider;
}