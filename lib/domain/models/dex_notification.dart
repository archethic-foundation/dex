/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_notification.freezed.dart';

enum DexActionType {
  swap,
  addLiquidity,
  removeLiquidity,
  claimFarm,
  depositFarm,
  withdrawfarm,
  addPool
}

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

  const factory DexNotification.claimFarm({
    @Default(DexActionType.claimFarm) DexActionType actionType,
    String? txAddress,
    double? amount,
    DexToken? rewardToken,
  }) = _DexNotificationClaimFarm;

  const factory DexNotification.depositFarm({
    @Default(DexActionType.depositFarm) DexActionType actionType,
    String? txAddress,
    double? amount,
    String? farmAddress,
    bool? isUCO,
  }) = _DexNotificationDepositFarm;

  const factory DexNotification.withdrawFarm({
    @Default(DexActionType.withdrawfarm) DexActionType actionType,
    String? txAddress,
    double? amountReward,
    double? amountWithdraw,
    bool? isFarmClose,
    DexToken? rewardToken,
  }) = _DexNotificationWithdrawFarm;
}
