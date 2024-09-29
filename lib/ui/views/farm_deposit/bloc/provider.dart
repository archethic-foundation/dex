import 'package:aedex/application/balance.dart';
import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/state.dart';
import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class FarmDepositFormNotifier extends _$FarmDepositFormNotifier {
  FarmDepositFormNotifier();

  @override
  FarmDepositFormState build() => const FarmDepositFormState();

  Future<void> initBalances() async {
    final lpTokenBalance = await ref.read(
      getBalanceProvider(
        state.dexFarmInfo!.lpToken!.address,
      ).future,
    );
    state = state.copyWith(lpTokenBalance: lpTokenBalance);
  }

  void setTransactionDepositFarm(archethic.Transaction transactionDepositFarm) {
    state = state.copyWith(transactionDepositFarm: transactionDepositFarm);
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

  void setAmountHalf() {
    setAmount(
      (Decimal.parse(state.lpTokenBalance.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
  }

  void setDexFarmInfo(DexFarm dexFarmInfo) {
    state = state.copyWith(
      dexFarmInfo: dexFarmInfo,
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

  void setFarmDepositOk(bool farmDepositOk) {
    state = state.copyWith(
      farmDepositOk: farmDepositOk,
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

  void setFarmDepositProcessStep(
    aedappfm.ProcessStep farmDepositProcessStep,
  ) {
    state = state.copyWith(
      processStep: farmDepositProcessStep,
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

    setFarmDepositProcessStep(
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

    if (state.amount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: localizations.farmDepositControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.lpTokenBalance) {
      setFailure(
        aedappfm.Failure.other(
          cause: localizations.farmDepositControlLPTokenAmountExceedBalance,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> deposit(AppLocalizations localizations) async {
    setFarmDepositOk(false);
    setProcessInProgress(true);

    if (control(localizations) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);

    final finalAmount = await ref.read(depositFarmCaseProvider).run(
          localizations,
          this,
          state.dexFarmInfo!.farmAddress,
          state.dexFarmInfo!.lpToken!.address,
          state.amount,
          state.dexFarmInfo!.farmAddress,
          false,
        );

    state = state.copyWith(finalAmount: finalAmount);

    ref
      ..invalidate(
        FarmListFormProvider.balance(state.dexFarmInfo!.lpToken!.address),
      )
      ..invalidate(
        DexFarmProviders.getFarmInfos(
          state.dexFarmInfo!.farmAddress,
          state.dexFarmInfo!.poolAddress,
        ),
      );
  }
}
