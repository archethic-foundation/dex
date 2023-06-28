/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/model/dex_token.dart';
import 'package:aedex/model/util/model_parser.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_token.g.dart';

@riverpod
DexTokensRepository _dexTokensRepository(_DexTokensRepositoryRef ref) =>
    DexTokensRepository();

@riverpod
Future<List<DexToken>> _getTokenFromAddress(
  _GetTokenFromAddressRef ref,
  address,
) async {
  return ref.watch(_dexTokensRepositoryProvider).getTokenFromAddress(address);
}

@riverpod
Future<List<DexToken>> _getTokenFromAccount(
  _GetTokenFromAddressRef ref,
  address,
) async {
  return ref.watch(_dexTokensRepositoryProvider).getTokensFromAccount(address);
}

class DexTokensRepository with ModelParser {
  Future<List<DexToken>> getTokenFromAddress(String address) async {
    final tokenMap = await sl.get<ApiService>().getToken([address]);
    if (tokenMap[address] == null) {
      return [];
    }
    final dexToken = tokenSDKToModel(tokenMap[address]!);
    return <DexToken>[dexToken];
  }

  Future<List<DexToken>> getTokensFromAccount(
    String accountAddress,
  ) async {
    final dexTokens = <DexToken>[];
    var lastAddress = accountAddress;
    final lastAddressMap =
        await sl.get<ApiService>().getLastTransaction([accountAddress]);
    if (lastAddressMap[accountAddress] != null &&
        lastAddressMap[accountAddress]!.address != null) {
      lastAddress = lastAddressMap[accountAddress]!.address!.address!;
    }

    final balanceMap = await sl.get<ApiService>().fetchBalance([lastAddress]);
    final balance = balanceMap[lastAddress];
    if (balance == null) {
      return [];
    }

    final tokenAddressList = <String>[];
    for (final token in balance.token) {
      tokenAddressList.add(token.address!);
    }

    final tokenMap = await sl.get<ApiService>().getToken(
          tokenAddressList,
          request: 'genesis, name, id, supply, symbol, type',
        );
    tokenMap.forEach((key, value) {
      dexTokens.add(
        tokenSDKToModel(value),
      );
    });

    return dexTokens;
  }
}

abstract class DexTokensProviders {
  static final getTokenFromAddress = _getTokenFromAddressProvider;
  static final getTokenFromAccount = _getTokenFromAccountProvider;
}
