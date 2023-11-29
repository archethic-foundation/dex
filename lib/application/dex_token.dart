/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_token.g.dart';

@riverpod
DexTokensRepository _dexTokensRepository(_DexTokensRepositoryRef ref) =>
    DexTokensRepository();

@riverpod
Future<List<DexToken>> _getTokenFromAddress(
  _GetTokenFromAddressRef ref,
  address,
  accountAddress,
) async {
  return ref
      .watch(_dexTokensRepositoryProvider)
      .getTokenFromAddress(address, accountAddress);
}

@riverpod
Future<List<DexToken>> _getTokenFromAccount(
  _GetTokenFromAccountRef ref,
  accountAddress,
) async {
  return ref
      .watch(_dexTokensRepositoryProvider)
      .getTokensFromAccount(accountAddress);
}

@riverpod
Future<String?> _getTokenIcon(
  _GetTokenIconRef ref,
  address,
) async {
  return ref.watch(_dexTokensRepositoryProvider).getTokenIcon(address);
}

class DexTokensRepository with ModelParser {
  Future<List<DexToken>> getTokenFromAddress(
    String address,
    String accountAddress,
  ) async {
    final tokenMap = await sl.get<ApiService>().getToken(
      [address],
      request: 'name, id, supply, symbol, type',
    );
    if (tokenMap[address] == null) {
      return [];
    }

    var token = tokenMap[address];
    token = token!.copyWith(address: address);

    final balanceMap =
        await sl.get<ApiService>().fetchBalance([accountAddress]);
    final balance = balanceMap[accountAddress];
    var balanceAmount = 0.0;
    if (balance != null) {
      for (final tokenBalance in balance.token) {
        if (tokenBalance.address!.toUpperCase() == address.toUpperCase()) {
          balanceAmount = fromBigInt(tokenBalance.amount).toDouble();
          break;
        }
      }
    }
    final dexToken = tokenSDKToModel(token, balanceAmount);
    return <DexToken>[dexToken];
  }

  Future<List<DexToken>> getTokensFromAccount(
    String accountAddress,
  ) async {
    final dexTokens = <DexToken>[];
    final balanceMap =
        await sl.get<ApiService>().fetchBalance([accountAddress]);
    final balance = balanceMap[accountAddress];
    if (balance == null) {
      return [];
    }

    final tokenAddressList = <String>[];
    for (final token in balance.token) {
      if (token.tokenId == 0) tokenAddressList.add(token.address!);
    }

    final dexTokenUCO = ucoToken.copyWith(
      balance: fromBigInt(balance.uco).toDouble(),
      icon: 'Archethic.svg',
    );
    dexTokens.add(dexTokenUCO);

    final tokenMap = await sl.get<ApiService>().getToken(
          tokenAddressList,
          request: 'name, id, supply, symbol, type',
        );
    tokenMap.forEach((key, value) {
      final _token = value.copyWith(address: key);

      var balanceAmount = 0.0;
      for (final tokenBalance in balance.token) {
        if (tokenBalance.address!.toUpperCase() ==
            _token.address!.toUpperCase()) {
          balanceAmount = fromBigInt(tokenBalance.amount).toDouble();
          break;
        }
      }

      final dexToken = tokenSDKToModel(_token, balanceAmount);

      dexTokens.add(
        dexToken,
      );
    });

    dexTokens.sort(
      (a, b) => a.symbol.toUpperCase().compareTo(b.symbol.toUpperCase()),
    );

    return dexTokens;
  }

  Future<String?> getTokenIcon(String address) async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/common_bases.json');

    final jsonData = jsonDecode(jsonContent);

    final currentEnvironment = EndpointUtil.getEnvironnement();
    try {
      final tokens = jsonData['tokens'][currentEnvironment] as List<dynamic>;
      String? tokenIcon;
      for (final token in tokens) {
        if (token['address'].toString().toUpperCase() ==
            address.toUpperCase()) {
          tokenIcon = token['icon'];
          break;
        }
      }
      return tokenIcon;
    } catch (e) {
      return null;
    }
  }
}

abstract class DexTokensProviders {
  static const getTokenFromAddress = _getTokenFromAddressProvider;
  static const getTokenFromAccount = _getTokenFromAccountProvider;
  static const getTokenIcon = _getTokenIconProvider;
}
