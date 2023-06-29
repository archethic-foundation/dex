/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/model/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pair.freezed.dart';

@freezed
class DexPair with _$DexPair {
  const factory DexPair({
    required DexToken token1,
    required DexToken token2,
  }) = _DexPair;
}
