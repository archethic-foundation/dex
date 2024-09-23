/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_token.freezed.dart';
part 'dex_token.g.dart';

@freezed
class DexTokenDescription with _$DexTokenDescription {
  const factory DexTokenDescription({
    required String name,
    required String address,
    required String symbol,
    required String icon,
  }) = _DexTokenDescription;
  const DexTokenDescription._();

  factory DexTokenDescription.fromJson(Map<String, dynamic> json) =>
      _$DexTokenDescriptionFromJson(json);

  bool get isUCO => symbol == 'UCO' && (address == 'UCO');

  DexToken get toToken => DexToken(
        name: name,
        address: address,
        symbol: symbol,
        icon: icon,
      );
}

@freezed
class DexToken with _$DexToken {
  const factory DexToken({
    @Default('') String name,
    String? address,
    String? icon,
    @Default('') String symbol,
    @Default(0.0) double balance,
    @Default(0.0) double reserve,
    @Default(0.0) double supply,
    @Default(false) bool isVerified,
    @Default(false) bool isLpToken,
    DexPair? lpTokenPair,
  }) = _DexToken;
  const DexToken._();

  factory DexToken.fromJson(Map<String, dynamic> json) =>
      _$DexTokenFromJson(json);

  bool get isUCO => symbol == 'UCO' && (address == null || address! == 'UCO');
}

DexToken get ucoToken => const DexToken(
      name: 'Universal Coin',
      symbol: 'UCO',
      address: 'UCO',
      icon: 'Archethic.svg',
      isVerified: true,
    );
