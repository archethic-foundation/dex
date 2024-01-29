/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool.freezed.dart';

@freezed
class DexPool with _$DexPool {
  const factory DexPool({
    required String poolAddress,
    required DexToken lpToken,
    required DexPair pair,
    required bool lpTokenInUserBalance,
    DexPoolInfos? infos,
  }) = _DexPool;
  const DexPool._();

  bool get isVerified => pair.token1.isVerified && pair.token2.isVerified;
}

@freezed
class DexPoolInfos with _$DexPoolInfos {
  const factory DexPoolInfos({
    // required int ranking, // TODO activate and use this
    required double fees,
    required double ratioToken1Token2,
    required double ratioToken2Token1,
    // required double estimatePoolTVLInFiat,
    required double token1TotalFee,
    required double token1TotalVolume,
    required double token2TotalFee,
    required double token2TotalVolume,
  }) = _DexPoolInfos;
  const DexPoolInfos._();
}
