/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm_user_infos.freezed.dart';

@freezed
class DexFarmUserInfos with _$DexFarmUserInfos {
  const factory DexFarmUserInfos({
    @Default(0.0) double depositedAmount,
    @Default(0.0) double rewardAmount,
  }) = _DexFarmUserInfos;
  const DexFarmUserInfos._();
}
