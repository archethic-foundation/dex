/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmLockFormBalances with _$FarmLockFormBalances {
  const factory FarmLockFormBalances({
    @Default(0.0) double token1Balance,
    @Default(0.0) double token2Balance,
    @Default(0.0) double lpTokenBalance,
  }) = _FarmLockFormBalances;
  const FarmLockFormBalances._();
}

@freezed
class FarmLockFormSummary with _$FarmLockFormSummary {
  const factory FarmLockFormSummary({
    @Default(0.0) double farmedTokensCapital,
    @Default(0.0) double farmedTokensCapitalInFiat,
    @Default(0.0) double farmedTokensRewards,
    @Default(0.0) double farmedTokensRewardsInFiat,
  }) = _FarmLockFormSummary;
  const FarmLockFormSummary._();

  double get farmedTokensInFiat =>
      farmedTokensCapitalInFiat + farmedTokensRewardsInFiat;
}
