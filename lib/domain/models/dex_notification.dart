/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_notification.freezed.dart';

enum DexActionType { swap, addLiquidity, removeLiquidity }

@freezed
class DexNotification with _$DexNotification {
  const factory DexNotification({
    required DexActionType actionType,
    String? txAddress,
    double? amount,
    DexToken? dexToken,
  }) = _DexNotification;
  const DexNotification._();
}
