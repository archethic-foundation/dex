import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_claim/bloc/state.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class FarmClaimFormNotifier extends _$FarmClaimFormNotifier {
  FarmClaimFormNotifier();

  @override
  FarmClaimFormState build() => const FarmClaimFormState();

  void setTransactionClaimFarm(archethic.Transaction transactionClaimFarm) {
    state = state.copyWith(transactionClaimFarm: transactionClaimFarm);
  }

  void setRewardAmount(double? rewardAmount) {
    state = state.copyWith(rewardAmount: rewardAmount);
  }

  void setPoolAddress(String poolAddress) {
    state = state.copyWith(
      poolAddress: poolAddress,
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

  void setFarmClaimOk(bool farmClaimOk) {
    state = state.copyWith(
      farmClaimOk: farmClaimOk,
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

  void setFarmClaimProcessStep(
    aedappfm.ProcessStep farmClaimProcessStep,
  ) {
    state = state.copyWith(
      processStep: farmClaimProcessStep,
    );
  }

  Future<void> validateForm(AppLocalizations localizations) async {
    if (control(localizations) == false) {
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setFarmClaimProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  bool control(AppLocalizations localizations) {
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
    setFarmClaimOk(false);
    setProcessInProgress(true);

    if (control(localizations) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);
    final finalAmount = await ref.read(claimFarmCaseProvider).run(
          localizations,
          this,
          state.farmAddress!,
          state.rewardToken!,
        );
    state = state.copyWith(finalAmount: finalAmount);

    ref
      ..invalidate(
        FarmListFormProvider.balance(state.lpTokenAddress),
      )
      ..invalidate(
        DexFarmProviders.getFarmInfos(
          state.farmAddress!,
          state.poolAddress!,
        ),
      );
  }
}
