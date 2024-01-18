import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/usecases/deposit_farm.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/state.dart';
import 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _farmDepositFormProvider =
    NotifierProvider.autoDispose<FarmDepositFormNotifier, FarmDepositFormState>(
  () {
    return FarmDepositFormNotifier();
  },
);

class FarmDepositFormNotifier
    extends AutoDisposeNotifier<FarmDepositFormState> {
  FarmDepositFormNotifier();

  @override
  FarmDepositFormState build() => const FarmDepositFormState();

  void setTransactionDepositFarm(Transaction transactionDepositFarm) {
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

  void setFarmDepositOk(bool farmDepositOk) {
    state = state.copyWith(
      farmDepositOk: farmDepositOk,
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

  void setFarmDepositProcessStep(
    FarmDepositProcessStep farmDepositProcessStep,
  ) {
    state = state.copyWith(
      farmDepositProcessStep: farmDepositProcessStep,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    setFarmDepositProcessStep(
      FarmDepositProcessStep.confirmation,
    );
  }

  bool control(BuildContext context) {
    setFailure(null);

    if (kIsWeb &&
        (BrowserUtil().isEdgeBrowser() ||
            BrowserUtil().isInternetExplorerBrowser())) {
      setFailure(
        const Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.amount <= 0) {
      setFailure(
        Failure.other(
          cause: AppLocalizations.of(context)!.farmDepositControlAmountEmpty,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> deposit(BuildContext context, WidgetRef ref) async {
    setFarmDepositOk(false);

    if (control(context) == false) {
      return;
    }
    setProcessInProgress(true);

    await DepositFarmCase().run(
      ref,
      state.dexFarmInfos!.farmAddress,
      state.dexFarmInfos!.lpToken!.address!,
      state.amount,
    );

    setResumeProcess(false);
    setProcessInProgress(false);
    setFarmDepositOk(true);
  }
}

abstract class FarmDepositFormProvider {
  static final farmDepositForm = _farmDepositFormProvider;
}
