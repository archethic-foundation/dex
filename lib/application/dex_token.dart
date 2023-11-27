/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
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
  _GetTokenFromAccountRef ref,
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
    final dexToken = tokenSDKToModel(tokenMap[address]!, 0);
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
      (a, b) => a.name.compareTo(b.name),
    );

    return dexTokens;
  }
}

abstract class DexTokensProviders {
  static const getTokenFromAddress = _getTokenFromAddressProvider;
  static const getTokenFromAccount = _getTokenFromAccountProvider;
}
