import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/bloc/state.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class FarmLockWithdrawFormNotifier extends _$FarmLockWithdrawFormNotifier {
  FarmLockWithdrawFormNotifier();

  @override
  FarmLockWithdrawFormState build() => const FarmLockWithdrawFormState();

  void setTransactionWithdrawFarmLock(Transaction transactionWithdrawFarmLock) {
    state = state.copyWith(
      transactionWithdrawFarmLock: transactionWithdrawFarmLock,
    );
  }

  void setDepositId(String depositId) {
    state = state.copyWith(depositId: depositId);
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

  void setPoolAddress(String poolAddress) {
    state = state.copyWith(poolAddress: poolAddress);
  }

  void setEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
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

  void setLpToken(DexToken lpToken) {
    state = state.copyWith(
      lpToken: lpToken,
    );
  }

  void setLPTokenPair(DexPair lpTokenPair) {
    state = state.copyWith(
      lpTokenPair: lpTokenPair,
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

    final session = ref.read(sessionNotifierProvider);
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

  Future<void> withdraw(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    setFarmLockWithdrawOk(false);
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);
    if (context.mounted) {
      final finalAmounts = await ref.read(withdrawFarmLockCaseProvider).run(
            localizations,
            ref.read(farmWithdrawFormNotifierProvider),
            state.farmAddress!,
            state.lpToken!.address!,
            state.amount,
            state.depositId,
            state.rewardToken!,
          );

      state = state.copyWith(
        finalAmountReward: finalAmounts.finalAmountReward,
        finalAmountWithdraw: finalAmounts.finalAmountWithdraw,
      );
    }
  }
}
