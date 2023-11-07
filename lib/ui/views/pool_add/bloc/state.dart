/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum PoolAddProcessStep { form, confirmation }

@freezed
class PoolAddFormState with _$PoolAddFormState {
  const factory PoolAddFormState({
    @Default(PoolAddProcessStep.form) PoolAddProcessStep poolAddProcessStep,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool poolAddOk,
    @Default(false) bool walletConfirmation,
    DexToken? token1,
    DexToken? token2,
    @Default(0.0) double token1Balance,
    @Default(0.0) double token1Amount,
    @Default(0.0) double token2Balance,
    @Default(0.0) double token2Amount,
    @Default(0.0) double networkFees,
    Failure? failure,
  }) = _PoolAddFormState;
  const PoolAddFormState._();

  bool get isControlsOk => failure == null;
}
