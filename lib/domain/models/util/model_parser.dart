import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/util/get_farm_infos_response.dart';
import 'package:aedex/domain/models/util/get_farm_list_response.dart';
import 'package:aedex/domain/models/util/get_pool_infos_response.dart';
import 'package:aedex/domain/models/util/get_pool_list_response.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';

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
    double balance,
  ) {
    return DexToken(
      balance: balance,
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

    final token1Verified = await VerifiedTokensRepository().isVerifiedToken(
      getPoolInfosResponse.token1.address.toUpperCase().toUpperCase(),
    );
    final token2Verified = await VerifiedTokensRepository().isVerifiedToken(
      getPoolInfosResponse.token2.address.toUpperCase().toUpperCase(),
    );

    final dexPair = DexPair(
      token1: DexToken(
        address: getPoolInfosResponse.token1.address.toUpperCase(),
        name: token1Name,
        symbol: token1Symbol,
        reserve: getPoolInfosResponse.token1.reserve,
        isVerified: token1Verified,
      ),
      token2: DexToken(
        address: getPoolInfosResponse.token2.address.toUpperCase(),
        name: token2Name,
        symbol: token2Symbol,
        reserve: getPoolInfosResponse.token2.reserve,
        isVerified: token2Verified,
      ),
    );

    final lpToken = DexToken(
      address: getPoolInfosResponse.lpToken.address.toUpperCase(),
      name: lpTokenName,
      symbol: lpTokenSymbol,
      supply: getPoolInfosResponse.lpToken.supply,
    );

    var ratioToken1Token2 = 0.0;
    var ratioToken2Token1 = 0.0;
    if (getPoolInfosResponse.token1.reserve > 0 &&
        getPoolInfosResponse.token2.reserve > 0) {
      ratioToken1Token2 =
          (Decimal.parse(getPoolInfosResponse.token2.reserve.toString()) /
                  Decimal.parse(getPoolInfosResponse.token1.reserve.toString()))
              .toDouble();
      ratioToken2Token1 =
          (Decimal.parse(getPoolInfosResponse.token1.reserve.toString()) /
                  Decimal.parse(getPoolInfosResponse.token2.reserve.toString()))
              .toDouble();
    }

    return DexPool(
      poolAddress: poolAddress,
      pair: dexPair,
      lpToken: lpToken,
      fees: getPoolInfosResponse.fee,
      ratioToken1Token2: ratioToken1Token2,
      ratioToken2Token1: ratioToken2Token1,
      token1TotalFee: getPoolInfosResponse.stats.token1TotalFee,
      token1TotalVolume: getPoolInfosResponse.stats.token1TotalVolume,
      token2TotalFee: getPoolInfosResponse.stats.token2TotalFee,
      token2TotalVolume: getPoolInfosResponse.stats.token2TotalVolume,
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

    final token1Verified = await VerifiedTokensRepository()
        .isVerifiedToken(tokens[0].toUpperCase());
    final token2Verified = await VerifiedTokensRepository()
        .isVerifiedToken(tokens[1].toUpperCase());

    final dexPair = DexPair(
      token1: DexToken(
        address: tokens[0].toUpperCase(),
        name: token1Name,
        symbol: token1Symbol,
        isVerified: token1Verified,
      ),
      token2: DexToken(
        address: tokens[1].toUpperCase(),
        name: token2Name,
        symbol: token2Symbol,
        isVerified: token2Verified,
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

  Future<DexFarm> farmListToModel(
    GetFarmListResponse getFarmListResponse,
    DexPool pool,
  ) async {
    final adressesToSearch = <String>[getFarmListResponse.lpTokenAddress];
    if (getFarmListResponse.rewardTokenAddress != 'UCO') {
      adressesToSearch.add(getFarmListResponse.rewardTokenAddress);
    }

    final tokenResultMap =
        await sl.get<archethic.ApiService>().getToken(adressesToSearch);
    DexToken? lpToken;
    if (tokenResultMap[getFarmListResponse.lpTokenAddress] != null) {
      lpToken = DexToken(
        address: getFarmListResponse.lpTokenAddress.toUpperCase(),
        name: tokenResultMap[getFarmListResponse.lpTokenAddress]!.name!,
        symbol: tokenResultMap[getFarmListResponse.lpTokenAddress]!.symbol!,
      );
    }

    DexToken? rewardToken;
    if (tokenResultMap[getFarmListResponse.rewardTokenAddress] != null) {
      rewardToken = DexToken(
        address: getFarmListResponse.rewardTokenAddress.toUpperCase(),
        name: tokenResultMap[getFarmListResponse.rewardTokenAddress]!.name!,
        symbol: tokenResultMap[getFarmListResponse.rewardTokenAddress]!.symbol!,
      );
    } else {
      if (getFarmListResponse.rewardTokenAddress == 'UCO') {
        rewardToken = const DexToken(name: 'UCO', symbol: 'UCO');
      }
    }

    return DexFarm(
      startDate: getFarmListResponse.startDate,
      endDate: getFarmListResponse.endDate,
      farmAddress: getFarmListResponse.address,
      rewardToken: rewardToken,
      lpToken: lpToken,
      lpTokenPair: pool.pair,
      poolAddress: pool.poolAddress,
    );
  }

  Future<DexFarm> farmInfosToModel(
    String farmGenesisAddress,
    GetFarmInfosResponse getFarmInfosResponse,
    DexPool pool, {
    DexFarm? dexFarmInput,
  }) async {
    DexFarm? dexFarm = DexFarm(
      lpTokenDeposited: getFarmInfosResponse.lpTokenDeposited,
      nbDeposit: getFarmInfosResponse.nbDeposit,
      remainingReward: getFarmInfosResponse.remainingReward,
      endDate: getFarmInfosResponse.endDate,
      startDate: getFarmInfosResponse.startDate,
      farmAddress: farmGenesisAddress,
      poolAddress: pool.poolAddress,
      lpTokenPair: pool.pair,
      statsRewardDistributed: getFarmInfosResponse.stats.rewardDistributed,
    );
    if (dexFarmInput == null || dexFarmInput.lpToken == null) {
      final adressesToSearch = <String>[getFarmInfosResponse.lpTokenAddress];
      final tokenResultMap =
          await sl.get<archethic.ApiService>().getToken(adressesToSearch);
      DexToken? lpToken;
      if (tokenResultMap[getFarmInfosResponse.lpTokenAddress] != null) {
        lpToken = DexToken(
          address: getFarmInfosResponse.lpTokenAddress.toUpperCase(),
          name: tokenResultMap[getFarmInfosResponse.lpTokenAddress]!.name!,
          symbol: tokenResultMap[getFarmInfosResponse.lpTokenAddress]!.symbol!,
        );
        dexFarm = dexFarm.copyWith(lpToken: lpToken);
      }
    } else {
      dexFarm = dexFarm.copyWith(lpToken: dexFarmInput.lpToken);
    }

    DexToken? rewardToken;
    if (dexFarmInput == null || dexFarmInput.rewardToken == null) {
      final adressesToSearch = <String>[getFarmInfosResponse.rewardToken];
      final tokenResultMap =
          await sl.get<archethic.ApiService>().getToken(adressesToSearch);

      if (tokenResultMap[getFarmInfosResponse.rewardToken] != null) {
        rewardToken = DexToken(
          address: getFarmInfosResponse.rewardToken.toUpperCase(),
          name: tokenResultMap[getFarmInfosResponse.rewardToken]!.name!,
          symbol: tokenResultMap[getFarmInfosResponse.rewardToken]!.symbol!,
        );
        dexFarm = dexFarm.copyWith(rewardToken: rewardToken);
      }
    } else {
      if (getFarmInfosResponse.rewardToken == 'UCO') {
        rewardToken = const DexToken(name: 'UCO', symbol: 'UCO');
        dexFarm = dexFarm.copyWith(rewardToken: rewardToken);
      } else {
        final adressesToSearch = <String>[getFarmInfosResponse.rewardToken];
        final tokenResultMap =
            await sl.get<archethic.ApiService>().getToken(adressesToSearch);

        if (tokenResultMap[getFarmInfosResponse.rewardToken] != null) {
          rewardToken = DexToken(
            address: getFarmInfosResponse.rewardToken.toUpperCase(),
            name: tokenResultMap[getFarmInfosResponse.rewardToken]!.name!,
            symbol: tokenResultMap[getFarmInfosResponse.rewardToken]!.symbol!,
          );
          dexFarm = dexFarm.copyWith(rewardToken: rewardToken);
        }
      }
    }

    return dexFarm;
  }
}
