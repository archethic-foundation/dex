/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_token.freezed.dart';

@freezed
class DexToken with _$DexToken {
  const factory DexToken({
    @Default('') String name,
    String? genesisAddress,
    @Default('') String symbol,
    @Default(0.0) double balance,
  }) = _DexToken;
}

DexToken get ucoToken => const DexToken(name: 'Universal Coin', symbol: 'UCO');
