import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/util/get_pool_infos_response.dart';
import 'package:aedex/domain/models/util/get_pool_list_response.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

mixin ModelParser {
  archethic.Token tokenModelToSDK(
    DexToken token,
  ) {
    return archethic.Token(
      name: token.name,
      genesis: token.address,
      symbol: token.symbol,
    );
  }

  DexToken tokenSDKToModel(
    archethic.Token token,
  ) {
    return DexToken(
      name: token.name ?? '',
      address: token.address ?? '',
      symbol: token.symbol ?? '',
    );
  }

  Future<DexPool> poolInfoToModel(
    String poolAddress,
    GetPoolInfosResponse getPoolInfosResponse,
  ) async {
    final adressesToSearch = <String>[getPoolInfosResponse.lpToken.address];
    if (getPoolInfosResponse.token1.address != 'UCO') {
      adressesToSearch.add(getPoolInfosResponse.token1.address);
    }
    if (getPoolInfosResponse.token2.address != 'UCO') {
      adressesToSearch.add(getPoolInfosResponse.token2.address);
    }

    final tokenResultMap = await sl.get<archethic.ApiService>().getToken(
          adressesToSearch,
        );

    // TODO(reddwarf03): Check cache
    var token1Name = '';
    var token1Symbol = '';
    if (getPoolInfosResponse.token1.address == 'UCO') {
      token1Name = 'Universal Coin';
      token1Symbol = 'UCO';
    } else {
      if (tokenResultMap[getPoolInfosResponse.token1.address] != null) {
        token1Name = tokenResultMap[getPoolInfosResponse.token1.address]!.name!;
        token1Symbol =
            tokenResultMap[getPoolInfosResponse.token1.address]!.symbol!;
      }
    }

    var token2Name = '';
    var token2Symbol = '';
    if (getPoolInfosResponse.token2.address == 'UCO') {
      token2Name = 'Universal Coin';
      token2Symbol = 'UCO';
    } else {
      if (tokenResultMap[getPoolInfosResponse.token2.address] != null) {
        token2Name = tokenResultMap[getPoolInfosResponse.token2.address]!.name!;
        token2Symbol =
            tokenResultMap[getPoolInfosResponse.token2.address]!.symbol!;
      }
    }

    var lpTokenName = '';
    var lpTokenSymbol = '';
    if (tokenResultMap[getPoolInfosResponse.lpToken.address] != null) {
      lpTokenName = tokenResultMap[getPoolInfosResponse.lpToken.address]!.name!;
      lpTokenSymbol =
          tokenResultMap[getPoolInfosResponse.lpToken.address]!.symbol!;
    }

    final dexPair = DexPair(
      token1: DexToken(
        address: getPoolInfosResponse.token1.address.toUpperCase(),
        name: token1Name,
        symbol: token1Symbol,
        reserve: getPoolInfosResponse.token1.reserve,
      ),
      token2: DexToken(
        address: getPoolInfosResponse.token2.address.toUpperCase(),
        name: token2Name,
        symbol: token2Symbol,
        reserve: getPoolInfosResponse.token2.reserve,
      ),
    );

    final lpToken = DexToken(
      address: getPoolInfosResponse.lpToken.address.toUpperCase(),
      name: lpTokenName,
      symbol: lpTokenSymbol,
      supply: getPoolInfosResponse.lpToken.supply,
    );

    return DexPool(
      poolAddress: poolAddress,
      pair: dexPair,
      lpToken: lpToken,
    );
  }

  Future<DexPool> poolListToModel(
    GetPoolListResponse getPoolListResponse,
  ) async {
    final tokens = getPoolListResponse.tokens.split('/');

    final adressesToSearch = <String>[getPoolListResponse.lpTokenAddress];
    if (tokens[0] != 'UCO') {
      adressesToSearch.add(tokens[0]);
    }
    if (tokens[1] != 'UCO') {
      adressesToSearch.add(tokens[1]);
    }

    // TODO(reddwarf03): Check cache

    final tokenResultMap =
        await sl.get<archethic.ApiService>().getToken(adressesToSearch);
    var token1Name = '';
    var token1Symbol = '';

    if (tokens[0] == 'UCO') {
      token1Name = 'Universal Coin';
      token1Symbol = 'UCO';
    } else {
      if (tokenResultMap[tokens[0]] != null) {
        token1Name = tokenResultMap[tokens[0]]!.name!;
        token1Symbol = tokenResultMap[tokens[0]]!.symbol!;
      }
    }

    var token2Name = '';
    var token2Symbol = '';
    if (tokens[1] == 'UCO') {
      token2Name = 'Universal Coin';
      token2Symbol = 'UCO';
    } else {
      if (tokenResultMap[tokens[1]] != null) {
        token2Name = tokenResultMap[tokens[1]]!.name!;
        token2Symbol = tokenResultMap[tokens[1]]!.symbol!;
      }
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
