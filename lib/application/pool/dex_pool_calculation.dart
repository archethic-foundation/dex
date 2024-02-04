/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<double> _getRatio(
  _GetRatioRef ref,
  String poolGenesisAddress,
  DexToken token,
) async {
  final apiService = sl.get<ApiService>();
  final poolRatioResult = await PoolFactory(
    poolGenesisAddress,
    apiService,
  ).getPoolRatio(
    token.isUCO ? 'UCO' : token.address!,
  );
  var ratio = 0.0;
  poolRatioResult.map(
    success: (success) {
      if (success != null) {
        ratio = success;
      }
    },
    failure: (failure) {},
  );
  return ratio;
}

@riverpod
({double tvl, double apr}) _estimatePoolTVLandAPRInFiat(
  _EstimatePoolTVLandAPRInFiatRef ref,
  DexPool? pool,
) {
  if (pool == null) return (tvl: 0.0, apr: 0.0);

  var fiatValueToken1 = 0.0;
  var fiatValueToken2 = 0.0;
  var tvl = 0.0;
  var apr = 0.0;
  fiatValueToken1 =
      ref.watch(DexTokensProviders.estimateTokenInFiat(pool.pair.token1));
  fiatValueToken2 =
      ref.watch(DexTokensProviders.estimateTokenInFiat(pool.pair.token2));

  if (fiatValueToken1 > 0 && fiatValueToken2 > 0) {
    tvl = pool.pair.token1.reserve * fiatValueToken1 +
        pool.pair.token2.reserve * fiatValueToken2;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 == 0) {
    tvl = pool.pair.token1.reserve * fiatValueToken1 * 2;
  }

  if (fiatValueToken1 == 0 && fiatValueToken2 > 0) {
    tvl = pool.pair.token2.reserve * fiatValueToken2 * 2;
  }

  if (tvl > 0 && pool.infos != null) {
    final archethicOracleUCO =
        ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

    final fiatFee = archethicOracleUCO.usd * pool.infos!.fees;
    apr = fiatFee * 365 / tvl;
  }

  return (tvl: tvl, apr: apr);
}

@riverpod
({
  double volume24h,
  double fee24h,
  double volumeAllTime,
  double feeAllTime,
}) _estimateStats(
  _EstimateStatsRef ref,
  DexPool pool,
) {
  var volume24h = 0.0;
  var fee24h = 0.0;
  var volumeAllTime = 0.0;
  var feeAllTime = 0.0;

  var priceToken1 = 0.0;
  var priceToken2 = 0.0;

  var token1TotalVolumeCurrentFiat = 0.0;
  var token2TotalVolumeCurrentFiat = 0.0;
  var token1TotalVolume24hFiat = 0.0;
  var token2TotalVolume24hFiat = 0.0;

  var token1TotalFeeCurrentFiat = 0.0;
  var token2TotalFeeCurrentFiat = 0.0;
  var token1TotalFee24hFiat = 0.0;
  var token2TotalFee24hFiat = 0.0;

  final archethicOracleUCO =
      ref.read(ArchethicOracleUCOProviders.archethicOracleUCO);

  if (pool.pair.token1.symbol == 'UCO') {
    priceToken1 = archethicOracleUCO.usd;
  } else {
    priceToken1 = ref.watch(
      CoinPriceProviders.coinPriceFromSymbol(pool.pair.token1.symbol),
    );
  }

  if (pool.pair.token2.symbol == 'UCO') {
    priceToken2 = archethicOracleUCO.usd;
  } else {
    priceToken2 = ref.watch(
      CoinPriceProviders.coinPriceFromSymbol(pool.pair.token2.symbol),
    );
  }

  if (priceToken1 == 0 && priceToken2 > 0) {
    priceToken1 = (Decimal.parse('${pool.infos!.ratioToken1Token2}') *
            Decimal.parse('$priceToken2'))
        .toDouble();
  }

  if (priceToken2 == 0 && priceToken1 > 0) {
    priceToken2 = (Decimal.parse('${pool.infos!.ratioToken2Token1}') *
            Decimal.parse('$priceToken1'))
        .toDouble();
  }

  final poolDetails = pool.infos;
  if (poolDetails != null) {
    token1TotalVolumeCurrentFiat = priceToken1 * poolDetails.token1TotalVolume;
    token2TotalVolumeCurrentFiat = priceToken2 * poolDetails.token2TotalVolume;

    token1TotalFeeCurrentFiat = priceToken1 * poolDetails.token1TotalFee;
    token2TotalFeeCurrentFiat = priceToken2 * poolDetails.token2TotalFee;

    token1TotalVolume24hFiat =
        priceToken1 * (poolDetails.token1TotalVolume24h ?? 0);
    token2TotalVolume24hFiat =
        priceToken2 * (poolDetails.token2TotalVolume24h ?? 0);

    token1TotalFee24hFiat = priceToken1 * (poolDetails.token1TotalFee24h ?? 0);
    token2TotalFee24hFiat = priceToken2 * (poolDetails.token2TotalFee24h ?? 0);
  }

  volumeAllTime = token1TotalVolumeCurrentFiat + token2TotalVolumeCurrentFiat;

  feeAllTime = token1TotalFeeCurrentFiat + token2TotalFeeCurrentFiat;

  volume24h =
      volumeAllTime - (token1TotalVolume24hFiat + token2TotalVolume24hFiat);

  fee24h = feeAllTime - (token1TotalFee24hFiat + token2TotalFee24hFiat);

  return (
    volume24h: volume24h,
    fee24h: fee24h,
    volumeAllTime: volumeAllTime,
    feeAllTime: feeAllTime
  );
}

@riverpod
DexPool _populatePoolInfosWithTokenStats24h(
  _PopulatePoolInfosWithTokenStats24hRef ref,
  DexPool pool,
  Map<String, List<Transaction>> transactionChainResult,
) {
  var token1TotalVolume24h = 0.0;
  var token2TotalVolume24h = 0.0;
  var token1TotalFee24h = 0.0;
  var token2TotalFee24h = 0.0;
  if (transactionChainResult[pool.poolAddress] != null &&
      transactionChainResult[pool.poolAddress]!.isNotEmpty) {
    final transaction = transactionChainResult[pool.poolAddress]!.first;
    if (transaction.validationStamp != null &&
        transaction.validationStamp!.ledgerOperations != null &&
        transaction
            .validationStamp!.ledgerOperations!.unspentOutputs.isNotEmpty) {
      for (final unspentOutput
          in transaction.validationStamp!.ledgerOperations!.unspentOutputs) {
        if (unspentOutput.state != null) {
          final state = unspentOutput.state;
          token1TotalVolume24h = state!['stats'] == null ||
                  state['stats']['token1_total_volume'] == null
              ? 0
              : Decimal.parse(
                  state['stats']['token1_total_volume'].toString(),
                ).toDouble();
          token2TotalVolume24h = state['stats'] == null ||
                  state['stats']['token2_total_volume'] == null
              ? 0
              : Decimal.parse(
                  state['stats']['token2_total_volume'].toString(),
                ).toDouble();
          token1TotalFee24h = state['stats'] == null ||
                  state['stats']['token1_total_fee'] == null
              ? 0
              : Decimal.parse(state['stats']['token1_total_fee'].toString())
                  .toDouble();
          token2TotalFee24h = state['stats'] == null ||
                  state['stats']['token2_total_fee'] == null
              ? 0
              : Decimal.parse(state['stats']['token2_total_fee'].toString())
                  .toDouble();
        }
      }
    }
  }

  var poolInfos = pool.infos!;
  poolInfos = poolInfos.copyWith(
    token1TotalVolume24h: token1TotalVolume24h,
    token2TotalVolume24h: token2TotalVolume24h,
    token1TotalFee24h: token1TotalFee24h,
    token2TotalFee24h: token2TotalFee24h,
  );
  return pool.copyWith(infos: poolInfos);
}
