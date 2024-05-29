/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aedex/domain/models/dex_pool_tx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PoolTxListFormState with _$PoolTxListFormState {
  const factory PoolTxListFormState({
    List<DexPoolTx>? result,
  }) = _PoolTxListFormState;
  const PoolTxListFormState._();
}
