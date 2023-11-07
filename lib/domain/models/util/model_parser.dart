import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/util/get_pool_list_response.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

mixin ModelParser {
  Token tokenModelToSDK(
    DexToken token,
  ) {
    return Token(
      name: token.name,
      genesis: token.genesisAddress,
      symbol: token.symbol,
    );
  }

  DexToken tokenSDKToModel(
    Token token,
  ) {
    return DexToken(
      name: token.name ?? '',
      genesisAddress: token.genesis ?? '',
      symbol: token.symbol ?? '',
    );
  }

  DexPool poolListToModel(
    GetPoolListResponse getPoolListResponse,
  ) {
    final tokens = getPoolListResponse.tokens.split('/');

    final dexPair = DexPair(
      token1: DexToken(genesisAddress: tokens[0]),
      token2: DexToken(genesisAddress: tokens[1]),
    );
    return DexPool(
      poolAddress: getPoolListResponse.address,
      pair: dexPair,
      lpTokenAddress: getPoolListResponse.lpTokenAddress,
    );
  }
}
