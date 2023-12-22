/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class Session with _$Session {
  const factory Session({
    @Default('testnet') String envSelected,
    @Default('') String endpoint,
    @Default('') String nameAccount,
    @Default('') String oldNameAccount,
    @Default('') String genesisAddress,
    @Default('') String error,
    @Default(false) bool isConnected,
    Subscription<Account>? accountSub,
    StreamSubscription<Account>? accountStreamSub,
    @Default(false) cacheFirstLoading,
  }) = _Session;
  const Session._();
}
