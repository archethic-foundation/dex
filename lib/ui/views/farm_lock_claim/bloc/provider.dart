import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_claim/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class FarmLockClaimFormNotifier extends _$FarmLockClaimFormNotifier {
  FarmLockClaimFormNotifier();

  @override
  FarmLockClaimFormState build() => const FarmLockClaimFormState();

  void setTransactionClaimFarmLock(
    archethic.Transaction transactionClaimFarmLock,
  ) {
    state = state.copyWith(transactionClaimFarmLock: transactionClaimFarmLock);
  }

  void setRewardAmount(double? rewardAmount) {
    state = state.copyWith(rewardAmount: rewardAmount);
  }

  void setFarmAddress(String farmAddress) {
    state = state.copyWith(
      farmAddress: farmAddress,
    );
  }

  void setPoolAddress(String poolAddress) {
    state = state.copyWith(
      poolAddress: poolAddress,
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

  void setDepositId(String depositId) {
    state = state.copyWith(depositId: depositId);
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

  void setFarmLockClaimOk(bool farmLockClaimOk) {
    state = state.copyWith(
      farmLockClaimOk: farmLockClaimOk,
    );
  }

  void setFinalAmount(double? finalAmount) {
    state = state.copyWith(finalAmount: finalAmount);
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

  void setFarmLockClaimProcessStep(
    aedappfm.ProcessStep farmLockClaimProcessStep,
  ) {
    state = state.copyWith(
      processStep: farmLockClaimProcessStep,
    );
  }

  Future<void> validateForm() async {
    if (control() == false) {
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setFarmLockClaimProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  bool control() {
    setFailure(null);

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      setFailure(
        const aedappfm.Failure.incompatibleBrowser(),
      );
      return false;
    }

    return true;
  }

  Future<void> claim(AppLocalizations localizations) async {
    setFarmLockClaimOk(false);
    setProcessInProgress(true);

    if (control() == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);

    final finalAmount = await ref.read(claimFarmLockCaseProvider).run(
          localizations,
          this,
          state.farmAddress!,
          state.depositId!,
          state.rewardToken!,
        );
    state = state.copyWith(finalAmount: finalAmount);

    ref
      ..invalidate(FarmListFormProvider.balance(state.lpTokenAddress))
      ..invalidate(
        DexFarmProviders.getFarmInfos(
          state.farmAddress!,
          state.poolAddress!,
        ),
      );
  }
}
