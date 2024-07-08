import 'package:aedex/application/notification.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/usecases/withdraw_farm_lock.usecase.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/bloc/state.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _farmLockWithdrawFormProvider = NotifierProvider.autoDispose<
    FarmLockWithdrawFormNotifier, FarmLockWithdrawFormState>(
  () {
    return FarmLockWithdrawFormNotifier();
  },
);

class FarmLockWithdrawFormNotifier
    extends AutoDisposeNotifier<FarmLockWithdrawFormState> {
  FarmLockWithdrawFormNotifier();

  @override
  FarmLockWithdrawFormState build() => const FarmLockWithdrawFormState();

  void setTransactionWithdrawFarmLock(Transaction transactionWithdrawFarmLock) {
    state = state.copyWith(
      transactionWithdrawFarmLock: transactionWithdrawFarmLock,
    );
  }

  void setDexFarmInfo(DexFarmLock dexFarmLockInfo) {
    state = state.copyWith(
      dexFarmLockInfo: dexFarmLockInfo,
    );
  }

  void setDepositIndex(int depositIndex) {
    state = state.copyWith(depositIndex: depositIndex);
  }

  void setAmount(
    BuildContext context,
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      amount: amount,
    );

    if (state.amount > state.depositedAmount!) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .farmLockWithdrawControlLPTokenAmountExceedDeposited,
        ),
      );
    }
  }

  void setDepositedAmount(double? depositedAmount) {
    state = state.copyWith(depositedAmount: depositedAmount);
  }

  void setRewardAmount(double? rewardAmount) {
    state = state.copyWith(rewardAmount: rewardAmount);
  }

  void setAmountMax(BuildContext context) {
    setAmount(context, state.depositedAmount!);
  }

  void setAmountHalf(
    BuildContext context,
  ) {
    setAmount(
      context,
      (Decimal.parse(state.depositedAmount.toString()) / Decimal.fromInt(2))
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

  void setFarmLockWithdrawOk(bool farmLockWithdrawOk) {
    state = state.copyWith(
      farmLockWithdrawOk: farmLockWithdrawOk,
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

  void setFinalAmountReward(double? finalAmountReward) {
    state = state.copyWith(finalAmountReward: finalAmountReward);
  }

  void setFinalAmountWithdraw(double? finalAmountWithdraw) {
    state = state.copyWith(finalAmountWithdraw: finalAmountWithdraw);
  }

  void setFarmLockWithdrawProcessStep(
    aedappfm.ProcessStep farmLockWithdrawProcessStep,
  ) {
    state = state.copyWith(
      processStep: farmLockWithdrawProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    final session = ref.read(SessionProviders.session);
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setFarmLockWithdrawProcessStep(
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
          cause:
              AppLocalizations.of(context)!.farmLockWithdrawControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.depositedAmount!) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .farmLockWithdrawControlLPTokenAmountExceedDeposited,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> withdraw(BuildContext context, WidgetRef ref) async {
    setFarmLockWithdrawOk(false);
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(SessionProviders.session);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);
    if (context.mounted) {
      final finalAmounts = await WithdrawFarmLockCase().run(
        ref,
        context,
        ref.watch(NotificationProviders.notificationService),
        state.farmAddress!,
        state.lpTokenAddress!,
        state.amount,
        state.depositIndex,
        state.rewardToken!,
      );

      state = state.copyWith(
        finalAmountReward: finalAmounts.finalAmountReward,
        finalAmountWithdraw: finalAmounts.finalAmountWithdraw,
      );
    }
  }
}

abstract class FarmLockWithdrawFormProvider {
  static final farmLockWithdrawForm = _farmLockWithdrawFormProvider;
}
