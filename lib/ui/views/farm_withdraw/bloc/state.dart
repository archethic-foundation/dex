/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmWithdrawFormState with _$FarmWithdrawFormState {
  const factory FarmWithdrawFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    DexFarm? dexFarmInfo,
    DexFarmUserInfos? dexFarmUserInfo,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmWithdrawOk,
    @Default(false) bool walletConfirmation,
    @Default(0.0) double amount,
    Transaction? transactionWithdrawFarm,
    Failure? failure,
    String? farmAddress,
    DexToken? rewardToken,
    String? lpTokenAddress,
    double? finalAmountReward,
    double? finalAmountWithdraw,
  }) = _FarmWithdrawFormState;
  const FarmWithdrawFormState._();

  bool get isControlsOk => failure == null && amount > 0;
}
