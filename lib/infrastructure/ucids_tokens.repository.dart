/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'package:aedex/domain/models/ucids_tokens.dart';
import 'package:aedex/domain/repositories/tokens/ucids_tokens.repository.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:flutter/services.dart';

class UcidsTokensRepositoryImpl implements UcidsTokensRepositoryInterface {
  @override
  Future<UcidsTokens> getUcidsTokens() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/tokens/ucids_tokens.json');

    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    return UcidsTokens.fromJson(jsonData);
  }

  @override
  Future<Map<String, int>> getUcidsTokensFromNetwork() async {
    final ucidsTokens = await getUcidsTokens();
    final network = EndpointUtil.getEnvironnement();

    switch (network) {
      case 'testnet':
        return ucidsTokens.testnet;
      case 'mainnet':
        return ucidsTokens.mainnet;
      case 'devnet':
        return ucidsTokens.devnet;
      default:
        return {};
    }
  }
}
