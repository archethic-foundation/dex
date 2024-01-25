/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool.freezed.dart';

@freezed
class DexPool with _$DexPool {
  const factory DexPool({
    @Default('') String poolAddress,
    DexToken? lpToken,
    @Default(0) int ranking,
    DexPair? pair,
    @Default(0.0) double fees,
    @Default(0.0) double ratioToken1Token2,
    @Default(0.0) double ratioToken2Token1,
    @Default(0.0) double estimatePoolTVLInFiat,
    @Default(false) bool lpTokenInUserBalance,
    @Default(0.0) double token1TotalFee,
    @Default(0.0) double token1TotalVolume,
    @Default(0.0) double token2TotalFee,
    @Default(0.0) double token2TotalVolume,
  }) = _DexPool;
  const DexPool._();

  bool get isVerified =>
      pair != null && pair!.token1.verified && pair!.token2.verified;
}
