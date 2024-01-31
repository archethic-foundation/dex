/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PoolListFormState with _$PoolListFormState {
  const factory PoolListFormState({
    @Default(PoolsListTab.verified) PoolsListTab tabIndexSelected,
    @Default('') String searchText,
  }) = _PoolListFormState;
  const PoolListFormState._();
}
