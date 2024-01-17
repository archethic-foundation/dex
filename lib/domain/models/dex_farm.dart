/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm.freezed.dart';

@freezed
class DexFarm with _$DexFarm {
  const factory DexFarm({
    @Default('') String farmAddress,
    DexToken? lpToken,
    @Default(0) int startDate,
    @Default(0) int endDate,
    @Default('') String rewardToken,
  }) = _DexFarm;
  const DexFarm._();
}
