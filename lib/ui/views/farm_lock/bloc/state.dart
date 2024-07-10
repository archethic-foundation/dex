/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmLockFormState with _$FarmLockFormState {
  const factory FarmLockFormState({
    DexPool? pool,
    DexFarm? farm,
    DexFarmLock? farmLock,
    @Default(0.0) double token1Balance,
    @Default(0.0) double token2Balance,
    @Default(0.0) double lpTokenBalance,
    @Default(0.0) double farmedTokensCapital,
    @Default(0.0) double farmedTokensCapitalInFiat,
    @Default(0.0) double farmedTokensRewards,
    @Default(0.0) double farmedTokensRewardsInFiat,
    @Default(false) bool mainInfoloadingInProgress,
  }) = _FarmLockFormState;
  const FarmLockFormState._();

  double get farmedTokensInFiat =>
      farmedTokensCapitalInFiat + farmedTokensRewardsInFiat;
}
