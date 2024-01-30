/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PoolListFormState with _$PoolListFormState {
  const factory PoolListFormState({
    @Default(0) int tabIndexSelected,
    @Default('') String searchText,
  }) = _PoolListFormState;
  const PoolListFormState._();

  bool get isVerifiedPoolsTabSelected => tabIndexSelected == 0;
  bool get isMyPoolsTabSelected => tabIndexSelected == 1;
  bool get isFavoritePoolsTabSelected => tabIndexSelected == 2;
  bool get isAllPoolsTabSelected => tabIndexSelected == 3;
  bool get isResultTabSelected => tabIndexSelected == 4;
}
