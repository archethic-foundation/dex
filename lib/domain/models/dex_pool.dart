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
    @Default(0.0) double ratio,
  }) = _DexPool;
}
