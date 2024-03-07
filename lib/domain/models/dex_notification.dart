/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_notification.freezed.dart';

enum DexActionType { swap, addLiquidity, removeLiquidity }

@freezed
class DexNotification with _$DexNotification {
  const DexNotification._();

  const factory DexNotification.swap({
    @Default(DexActionType.swap) DexActionType actionType,
    String? txAddress,
    double? amountSwapped,
    DexToken? tokenSwapped,
  }) = _DexNotificationSwap;

  const factory DexNotification.addLiquidity({
    @Default(DexActionType.addLiquidity) DexActionType actionType,
    String? txAddress,
    double? amount,
    DexToken? lpToken,
  }) = _DexNotificationAddLiquidity;

  const factory DexNotification.removeLiquidity({
    @Default(DexActionType.removeLiquidity) DexActionType actionType,
    String? txAddress,
    double? amountToken1,
    double? amountToken2,
    double? amountLPToken,
    DexToken? token1,
    DexToken? token2,
    DexToken? lpToken,
  }) = _DexNotificationRemoveLiquidity;
}
