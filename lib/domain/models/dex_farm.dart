/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm.freezed.dart';

@freezed
class DexFarm with _$DexFarm {
  const factory DexFarm({
    @Default('') String farmAddress,
    @Default('') String poolAddress,
    @Default(0) double apr,
    DexToken? lpToken,
    DexPair? lpTokenPair,
    @Default(0) int startDate, // FIXME : this should be a DaateTime
    @Default(0) int endDate, // FIXME : this should be a DaateTime
    DexToken? rewardToken,
    @Default(0) double remainingReward,
    @Default(0) double remainingRewardInFiat,
    @Default(0) double lpTokenDeposited,
    @Default(0) int nbDeposit,
    @Default(0.0) double statsRewardDistributed,
  }) = _DexFarm;
  const DexFarm._();
}

extension TimestampExt on int {
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(
        this * 1000,
        isUtc: true,
      );
}
