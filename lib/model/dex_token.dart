/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_token.freezed.dart';

@freezed
class DexToken with _$DexToken {
  const factory DexToken({
    required String name,
    required String genesisAddress,
    required String symbol,
  }) = _DexToken;
}
