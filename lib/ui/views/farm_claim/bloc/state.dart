/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum FarmClaimProcessStep { form, confirmation }

@freezed
class FarmClaimFormState with _$FarmClaimFormState {
  const factory FarmClaimFormState({
    @Default(FarmClaimProcessStep.form)
    FarmClaimProcessStep farmClaimProcessStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    DexFarm? dexFarm,
    DexFarmUserInfos? dexFarmUserInfo,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmClaimOk,
    @Default(false) bool walletConfirmation,
    Transaction? transactionClaimFarm,
    Failure? failure,
    double? finalAmount,
  }) = _FarmClaimFormState;
  const FarmClaimFormState._();

  bool get isControlsOk =>
      failure == null &&
      dexFarmUserInfo != null &&
      dexFarmUserInfo!.rewardAmount > 0;
}
