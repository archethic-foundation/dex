/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/model/dex_pair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool.freezed.dart';

@freezed
class DexPool with _$DexPool {
  const factory DexPool({
    @Default('') String poolAddress,
    @Default(0) int ranking,
    DexPair? pair,
    @Default(0.0) double token1Pooled,
    @Default(0.0) double token2Pooled,
    @Default(0.0) double amountOfLiquidity,
    @Default(0.0) double apr,
    @Default(0.0) double volume24h,
    @Default(0.0) double volume7d,
    @Default(0.0) double fees24h,
  }) = _DexPool;
}
