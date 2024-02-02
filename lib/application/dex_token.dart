/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:aedex/infrastructure/hive/dex_token.hive.dart';
import 'package:aedex/infrastructure/hive/tokens_list.hive.dart';
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
  return ref.watch(_dexTokensRepositoryProvider).getTokenFromAddress(address);
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
  ) async {
    DexToken? token;
    final tokensListDatasource = await HiveTokensListDatasource.getInstance();
    final tokenHive = tokensListDatasource.getToken(address);
    if (tokenHive == null) {
      final tokenMap = await sl.get<ApiService>().getToken(
        [address],
        request: 'name, symbol',
      );
      if (tokenMap[address] != null) {
        token = tokenSDKToModel(tokenMap[address]!, 0);
        token = token.copyWith(address: address);
        await tokensListDatasource.setToken(token.toHive());
      }
    } else {
      token = tokenHive.toModel();
    }

    if (token == null) {
      return [];
    }

    return <DexToken>[token];
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
          request: 'name, symbol, properties',
        );

    for (final entry in tokenMap.entries) {
      final key = entry.key;
      final value = entry.value;

      final _token = value.copyWith(address: key);

      var balanceAmount = 0.0;
      for (final tokenBalance in balance.token) {
        if (tokenBalance.address!.toUpperCase() ==
            _token.address!.toUpperCase()) {
          balanceAmount = fromBigInt(tokenBalance.amount).toDouble();
          break;
        }
      }

      var dexToken = tokenSDKToModel(_token, balanceAmount);

      final tokenSymbolSearch = <String>[];
      if (value.properties.isNotEmpty &&
          value.properties['token1_address'] != null &&
          value.properties['token2_address'] != null) {
        if (value.properties['token1_address'] != 'UCO') {
          tokenSymbolSearch.add(value.properties['token1_address']);
        }
        if (value.properties['token2_address'] != 'UCO') {
          tokenSymbolSearch.add(value.properties['token2_address']);
        }
        final tokensSymbolMap = await sl.get<ApiService>().getToken(
              tokenSymbolSearch,
              request: 'name, symbol',
            );

        dexToken = dexToken.copyWith(
          isLpToken: true,
          lpTokenPair: DexPair(
            token1: value.properties['token1_address'] != 'UCO'
                ? DexToken(
                    address: value.properties['token1_address'],
                    name: tokensSymbolMap[value.properties['token1_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token1_address']]!
                            .name!
                        : '',
                    symbol: tokensSymbolMap[
                                value.properties['token1_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token1_address']]!
                            .symbol!
                        : '',
                  )
                : ucoToken,
            token2: value.properties['token2_address'] != 'UCO'
                ? DexToken(
                    address: value.properties['token2_address'],
                    name: tokensSymbolMap[value.properties['token2_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token2_address']]!
                            .name!
                        : '',
                    symbol: tokensSymbolMap[
                                value.properties['token2_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token2_address']]!
                            .symbol!
                        : '',
                  )
                : ucoToken,
          ),
        );
      }
      dexTokens.add(
        dexToken,
      );
    }

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
