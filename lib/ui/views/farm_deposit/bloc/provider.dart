import 'package:aedex/application/balance.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/usecases.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/state.dart';
import 'package:aedex/ui/views/farm_list/layouts/components/farm_list_item.dart';
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
class FarmDepositFormNotifier extends _$FarmDepositFormNotifier {
  FarmDepositFormNotifier();

  @override
  FarmDepositFormState build() => const FarmDepositFormState();

  Future<void> initBalances() async {
    final lpTokenBalance = await ref.read(
      getBalanceProvider(
        state.dexFarmInfo!.lpToken!.isUCO
            ? 'UCO'
            : state.dexFarmInfo!.lpToken!.address!,
      ).future,
    );
    state = state.copyWith(lpTokenBalance: lpTokenBalance);
  }

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

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
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
          cause: AppLocalizations.of(context)!.farmDepositControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.lpTokenBalance) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .farmDepositControlLPTokenAmountExceedBalance,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> deposit(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    setFarmDepositOk(false);
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider);
    await aedappfm.ConsentRepositoryImpl().addAddress(session.genesisAddress);

    if (context.mounted) {
      final finalAmount = await ref.read(depositFarmCaseProvider).run(
            localizations,
            state.dexFarmInfo!.farmAddress,
            state.dexFarmInfo!.lpToken!.address!,
            state.amount,
            state.dexFarmInfo!.farmAddress,
            false,
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
