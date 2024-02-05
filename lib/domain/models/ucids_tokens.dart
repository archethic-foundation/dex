/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ucids_tokens.freezed.dart';
part 'ucids_tokens.g.dart';

@freezed
class UcidsTokens with _$UcidsTokens {
  const factory UcidsTokens({
    required Map<String, int> mainnet,
    required Map<String, int> testnet,
    required Map<String, int> devnet,
  }) = _UcidsTokens;

  factory UcidsTokens.fromJson(Map<String, dynamic> json) =>
      _$UcidsTokensFromJson(json);
}
