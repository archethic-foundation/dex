import 'package:aedex/application/notification.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/usecases/claim_farm.usecase.dart';
import 'package:aedex/ui/views/farm_claim/bloc/state.dart';
import 'package:aedex/ui/views/farm_list/layouts/components/farm_list_item.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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

  void setRewardAmount(double? rewardAmount) {
    state = state.copyWith(rewardAmount: rewardAmount);
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

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    final session = ref.read(sessionNotifierProvider).value ?? const Session();
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setFarmClaimProcessStep(
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

    return true;
  }

  Future<void> claim(BuildContext context, WidgetRef ref) async {
    setFarmClaimOk(false);
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider).value ?? const Session();
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);
    if (context.mounted) {
      final finalAmount = await ClaimFarmCase().run(
        ref,
        AppLocalizations.of(context)!,
        ref.watch(NotificationProviders.notificationService),
        state.farmAddress!,
        state.rewardToken!,
      );
      state = state.copyWith(finalAmount: finalAmount);

      if (context.mounted) {
        final farmListItemState =
            context.findAncestorStateOfType<FarmListItemState>();
        await farmListItemState?.reload();
      }
    }
  }
}

abstract class FarmClaimFormProvider {
  static final farmClaimForm = _farmClaimFormProvider;
}
