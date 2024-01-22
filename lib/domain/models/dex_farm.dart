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
    @Default(0) int startDate,
    @Default(0) int endDate,
    DexToken? rewardToken,
    @Default(0) double remainingReward,
    @Default(0) double lpTokenDeposited,
    @Default(0) int nbDeposit,
  }) = _DexFarm;
  const DexFarm._();
}
