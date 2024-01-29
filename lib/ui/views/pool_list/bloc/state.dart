/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PoolListFormState with _$PoolListFormState {
  const factory PoolListFormState({
    @Default(0) int tabIndexSelected,
  }) = _PoolListFormState;
  const PoolListFormState._();

  bool get isVerifiedPoolsTabSelected => tabIndexSelected == 0;
  bool get isUserTokenPoolsTabSelected => tabIndexSelected == 1;
}
