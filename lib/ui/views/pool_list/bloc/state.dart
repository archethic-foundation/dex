/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PoolListFormState with _$PoolListFormState {
  const factory PoolListFormState({
    @Default(true) bool onlyVerifiedPools,
    @Default(false) bool onlyPoolsWithLiquidityPositions,
  }) = _PoolListFormState;
  const PoolListFormState._();
}
