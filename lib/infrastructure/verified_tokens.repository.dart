/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'package:aedex/domain/models/verified_tokens.dart';
import 'package:aedex/domain/repositories/tokens/verified_tokens.repository.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:flutter/services.dart';

class VerifiedTokensRepositoryImpl
    implements VerifiedTokensRepositoryInterface {
  @override
  Future<VerifiedTokens> getVerifiedTokens() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/tokens/verified_tokens.json');

    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    return VerifiedTokens.fromJson(jsonData);
  }

  @override
  Future<List<String>> getVerifiedTokensFromNetwork() async {
    final verifiedTokens = await getVerifiedTokens();
    final network = EndpointUtil.getEnvironnement();

    switch (network) {
      case 'testnet':
        return verifiedTokens.testnet;
      case 'mainnet':
        return verifiedTokens.mainnet;
      case 'devnet':
        return verifiedTokens.devnet;
      default:
        return [];
    }
  }

  @override
  Future<bool> isVerifiedToken(
    String address,
  ) async {
    if (address == 'UCO') {
      return true;
    }
    final verifiedTokens = await getVerifiedTokensFromNetwork();
    if (verifiedTokens.contains(address.toUpperCase())) {
      return true;
    }
    return false;
  }
}
