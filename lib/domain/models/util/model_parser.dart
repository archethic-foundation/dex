import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/util/get_pool_list_response.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

mixin ModelParser {
  Token tokenModelToSDK(
    DexToken token,
  ) {
    return Token(
      name: token.name,
      genesis: token.address,
      symbol: token.symbol,
    );
  }

  DexToken tokenSDKToModel(
    Token token,
  ) {
    return DexToken(
      name: token.name ?? '',
      address: token.address ?? '',
      symbol: token.symbol ?? '',
    );
  }

  Future<DexPool> poolListToModel(
    GetPoolListResponse getPoolListResponse,
  ) async {
    final tokens = getPoolListResponse.tokens.split('/');

    // TODO(reddwarf03): Check cache

    final tokenResultMap = await sl
        .get<ApiService>()
        .getToken([tokens[0], tokens[1], getPoolListResponse.lpTokenAddress]);
    var token1Name = '';
    var token1Symbol = '';
    if (tokenResultMap[tokens[0]] != null) {
      token1Name = tokenResultMap[tokens[0]]!.name!;
      token1Symbol = tokenResultMap[tokens[0]]!.symbol!;
    }
    var token2Name = '';
    var token2Symbol = '';
    if (tokenResultMap[tokens[1]] != null) {
      token2Name = tokenResultMap[tokens[1]]!.name!;
      token2Symbol = tokenResultMap[tokens[1]]!.symbol!;
    }
    var lpTokenName = '';
    var lpTokenSymbol = '';
    if (tokenResultMap[getPoolListResponse.lpTokenAddress] != null) {
      lpTokenName = tokenResultMap[getPoolListResponse.lpTokenAddress]!.name!;
      lpTokenSymbol =
          tokenResultMap[getPoolListResponse.lpTokenAddress]!.symbol!;
    }

    final dexPair = DexPair(
      token1: DexToken(
        address: tokens[0].toUpperCase(),
        name: token1Name,
        symbol: token1Symbol,
      ),
      token2: DexToken(
        address: tokens[1].toUpperCase(),
        name: token2Name,
        symbol: token2Symbol,
      ),
    );

    final lpToken = DexToken(
      address: getPoolListResponse.lpTokenAddress.toUpperCase(),
      name: lpTokenName,
      symbol: lpTokenSymbol,
    );

    return DexPool(
      poolAddress: getPoolListResponse.address,
      pair: dexPair,
      lpToken: lpToken,
    );
  }
}
