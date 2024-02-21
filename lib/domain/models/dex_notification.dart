/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_notification.freezed.dart';
part 'dex_notification.g.dart';

enum DexActionType { swap, addLiquidity, removeLiquidity }

@freezed
class DexNotification with _$DexNotification {
  const factory DexNotification({
    DexActionType? actionType,
    String? txAddress,
    double? amount,
    DateTime? timestamp,
  }) = _DexNotification;
  const DexNotification._();

  factory DexNotification.fromJson(Map<String, dynamic> json) =>
      _$DexNotificationFromJson(json);
}
