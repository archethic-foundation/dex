/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool_infos.freezed.dart';
part 'dex_pool_infos.g.dart';

@freezed
class DexPoolInfos with _$DexPoolInfos {
  const factory DexPoolInfos({
    double? tvl,
    required double fees,
    required double protocolFees,
    required double ratioToken1Token2,
    required double ratioToken2Token1,
    required double token1TotalFee,
    required double token1TotalVolume,
    required double token2TotalFee,
    required double token2TotalVolume,
  }) = _DexPoolInfos;
  const DexPoolInfos._();

  factory DexPoolInfos.fromJson(Map<String, dynamic> json) =>
      _$DexPoolInfosFromJson(json);
}

@freezed
class DexPoolStats with _$DexPoolStats {
  const factory DexPoolStats({
    required double token1TotalVolume24h,
    required double token2TotalVolume24h,
    required double token1TotalVolume7d,
    required double token2TotalVolume7d,
    required double token1TotalFee24h,
    required double token2TotalFee24h,
    required double fee24h,
    required double feeAllTime,
    required double volume24h,
    required double volume7d,
    required double volumeAllTime,
  }) = _DexPoolStats;
  const DexPoolStats._();

  factory DexPoolStats.fromJson(Map<String, dynamic> json) =>
      _$DexPoolStatsFromJson(json);
}
