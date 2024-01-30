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
    DexPool poolInput,
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

    var ratioToken1Token2 = 0.0;
    var ratioToken2Token1 = 0.0;
    if (getPoolInfosResponse.token1.reserve > 0 &&
        getPoolInfosResponse.token2.reserve > 0) {
      ratioToken1Token2 = getPoolInfosResponse.token2.reserve /
          getPoolInfosResponse.token1.reserve;
      ratioToken2Token1 = getPoolInfosResponse.token1.reserve /
          getPoolInfosResponse.token2.reserve;
    }

    final token1 = poolInput.pair.token1.copyWith(
      reserve: getPoolInfosResponse.token1.reserve,
    );

    final token2 = poolInput.pair.token2.copyWith(
      reserve: getPoolInfosResponse.token2.reserve,
    );

    final dexPair = poolInput.pair.copyWith(
      token1: token1,
      token2: token2,
    );

    final lpToken = poolInput.lpToken.copyWith(
      supply: getPoolInfosResponse.lpToken.supply,
    );

    return poolInput.copyWith(
      pair: dexPair,
      lpToken: lpToken,
      infos: DexPoolInfos(
        fees: getPoolInfosResponse.fee,
        protocolFees: getPoolInfosResponse.protocolFee,
        ratioToken1Token2: ratioToken1Token2,
        ratioToken2Token1: ratioToken2Token1,
        token1TotalFee: getPoolInfosResponse.stats.token1TotalFee,
        token1TotalVolume: getPoolInfosResponse.stats.token1TotalVolume,
        token2TotalFee: getPoolInfosResponse.stats.token2TotalFee,
        token2TotalVolume: getPoolInfosResponse.stats.token2TotalVolume,
      ),
    );
  }

  Future<DexPool> poolListItemToModel(
    archethic.Balance userBalance,
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

    var lpTokenInUserBalance = false;
    for (final userTokensBalance in userBalance.token) {
      if (getPoolListResponse.lpTokenAddress.toUpperCase() ==
          userTokensBalance.address!.toUpperCase()) {
        lpTokenInUserBalance = true;
      }
    }

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
      lpTokenInUserBalance: lpTokenInUserBalance,
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
    var remainingReward = 0.0;
    if (getFarmInfosResponse.remainingReward == null) {
      final transactionChainMap = await sl
          .get<archethic.ApiService>()
          .getTransactionChain({farmGenesisAddress: ''});
      if (transactionChainMap[farmGenesisAddress] != null &&
          transactionChainMap[farmGenesisAddress]!.isNotEmpty) {
        final tx = transactionChainMap[farmGenesisAddress]!.first;

        for (final txInput in tx.inputs) {
          if (txInput.from != tx.address!.address &&
              (txInput.type == 'UCO' &&
                      getFarmInfosResponse.rewardToken == 'UCO' ||
                  txInput.type != 'UCO' &&
                      getFarmInfosResponse.rewardToken ==
                          txInput.tokenAddress)) {
            remainingReward = archethic.fromBigInt(txInput.amount).toDouble();
          }
        }
      }
    } else {
      remainingReward = getFarmInfosResponse.remainingReward!;
    }

    DexFarm? dexFarm = DexFarm(
      lpTokenDeposited: getFarmInfosResponse.lpTokenDeposited,
      nbDeposit: getFarmInfosResponse.nbDeposit,
      remainingReward: remainingReward,
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
