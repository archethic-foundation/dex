import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/state.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:aedex/util/riverpod.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class FarmLockDepositFormNotifier extends _$FarmLockDepositFormNotifier {
  FarmLockDepositFormNotifier();

  @override
  FarmLockDepositFormState build() {
    final lpTokenBalance = _watchLPTokenBalance();

    // Reuse previous state values.
    // If this is a first build, uses a default state.
    return (stateOrNull ?? const FarmLockDepositFormState()).copyWith(
      lpTokenBalance: lpTokenBalance,
    );
  }

  double _watchLPTokenBalance() {
    /// Rebuilds this provider when lpTokenAddress changes
    /// That way, it will watch the appropriate lpBalanceProvider.
    ref.invalidateSelfOnPropertyChange(
      (state) => state?.lpTokenAddress,
    );

    final lpTokenAddress = stateOrNull?.lpTokenAddress;
    if (lpTokenAddress == null) return 0;
    return ref.watch(getBalanceProvider(lpTokenAddress)).valueOrNull ?? 0.0;
  }

  void setPoolsListTab(PoolsListTab poolsListTab) {
    state = state.copyWith(poolsListTab: poolsListTab);
  }

  void setTransactionFarmLockDeposit(
    archethic.Transaction transactionFarmLockDeposit,
  ) {
    state =
        state.copyWith(transactionFarmLockDeposit: transactionFarmLockDeposit);
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
    setAmount(state.lpTokenBalance);
  }

  void setFilterAvailableLevels(Map<String, int> filterAvailableLevels) {
    state = state.copyWith(filterAvailableLevels: filterAvailableLevels);
  }

  void setAmountHalf() {
    setAmount(
      (Decimal.parse(state.lpTokenBalance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setDexPool(DexPool pool) {
    state = state.copyWith(
      pool: pool,
    );
  }

  void setDexFarmLock(DexFarmLock farmLock) {
    state = state.copyWith(
      farmLock: farmLock,
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

  void setFarmLockDepositOk(bool farmLockDepositOk) {
    state = state.copyWith(
      farmLockDepositOk: farmLockDepositOk,
    );
  }

  void setFinalAmount(double? finalAmount) {
    state = state.copyWith(finalAmount: finalAmount);
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setFarmLockDepositDuration(
    FarmLockDepositDurationType farmLockDepositDuration,
  ) {
    state = state.copyWith(farmLockDepositDuration: farmLockDepositDuration);
  }

  void setLevel(String level) {
    state = state.copyWith(level: level);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setAPREstimation(double? aprEstimation) {
    state = state.copyWith(aprEstimation: aprEstimation);
  }

  void setFarmLockDepositProcessStep(
    aedappfm.ProcessStep processStep,
  ) {
    state = state.copyWith(
      processStep: processStep,
    );
  }

  void filterAvailableLevels() {
    final availableLevelsFiltered = <String, int>{};
    var needMax = false;
    final farmEndDate = state.farmLock!.endDate!;
    for (final entry in state.farmLock!.availableLevels.entries) {
      final level = entry.key;
      final endDate = entry.value;
      if (level != '0') {
        if (DateTime.fromMillisecondsSinceEpoch(
          entry.value * 1000,
        ).isBefore(farmEndDate)) {
          availableLevelsFiltered[level] = endDate;
        } else {
          if (needMax == false) {
            availableLevelsFiltered['max'] =
                farmEndDate.millisecondsSinceEpoch ~/ 1000;
            state = state.copyWith(
              farmLockDepositDuration: FarmLockDepositDurationType.max,
            );
            needMax = true;
          }
        }
      }
    }
    state = state.copyWith(filterAvailableLevels: availableLevelsFiltered);
  }

  Future<void> validateForm(AppLocalizations appLocalizations) async {
    if (control(appLocalizations) == false) {
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(session.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setFarmLockDepositProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  bool control(AppLocalizations appLocalizations) {
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
          cause: appLocalizations.farmDepositControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.lpTokenBalance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.farmDepositControlLPTokenAmountExceedBalance,
        ),
      );
      return false;
    }

    if (state.amount < 0.00000143) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.farmDepositControlAmountMin,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> lock(AppLocalizations appLocalizations) async {
    setFarmLockDepositOk(false);
    setProcessInProgress(true);

    if (control(appLocalizations) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);

    final finalAmount = await ref.read(depositFarmLockCaseProvider).run(
          appLocalizations,
          this,
          state.farmLock!.farmAddress,
          state.farmLock!.lpToken!.address,
          state.amount,
          state.farmLock!.farmAddress,
          false,
          state.farmLockDepositDuration,
          state.level,
        );

    state = state.copyWith(finalAmount: finalAmount);
  }
}
