/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<double> _estimateTokenInFiat(
  _EstimateTokenInFiatRef ref,
  DexToken token,
) async {
  var fiatValue = 0.0;
  if (token.symbol == 'UCO') {
    final archethicOracleUCO =
        ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

    fiatValue = archethicOracleUCO.usd;
  } else {
    final price = await ref
        .watch(MarketProviders.getPriceFromSymbol(token.symbol).future);

    fiatValue = price;
  }
  return fiatValue;
}

@riverpod
Future<double> _estimatePoolTVLInFiat(
  _EstimatePoolTVLInFiatRef ref,
  DexPool pool,
) async {
  var fiatValueToken1 = 0.0;
  var fiatValueToken2 = 0.0;

  fiatValueToken1 = await ref
      .watch(DexPoolProviders.estimateTokenInFiat(pool.pair!.token1).future);
  fiatValueToken2 = await ref
      .watch(DexPoolProviders.estimateTokenInFiat(pool.pair!.token2).future);

  if (fiatValueToken1 > 0 && fiatValueToken2 > 0) {
    return pool.pair!.token1.reserve * fiatValueToken1 +
        pool.pair!.token2.reserve * fiatValueToken1;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 == 0) {
    return pool.pair!.token1.reserve * fiatValueToken1 * 2;
  }

  if (fiatValueToken1 == 0 && fiatValueToken2 > 0) {
    return pool.pair!.token2.reserve * fiatValueToken2 * 2;
  }

  return 0;
}

@riverpod
Future<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> _estimateStats(
  _EstimateStatsRef ref,
  DexPool currentPoolInfos,
) async {
  final apiService = sl.get<ApiService>();
  final fromCriteria = (DateTime.now()
              .subtract(
                const Duration(days: 1),
              )
              .millisecondsSinceEpoch /
          1000)
      .round();
  final transactionChainResult = await apiService.getTransactionChain(
    {currentPoolInfos.poolAddress: ''},
    request:
        ' validationStamp { ledgerOperations { unspentOutputs { state } } }',
    fromCriteria: fromCriteria,
  );

  var volume24h = 0.0;
  var fee24h = 0.0;
  var volumeAllTime = 0.0;
  var feeAllTime = 0.0;

  var priceToken1 = 0.0;
  var priceToken2 = 0.0;

  var token1TotalVolume24h = 0.0;
  var token2TotalVolume24h = 0.0;
  var token1TotalFee24h = 0.0;
  var token2TotalFee24h = 0.0;

  var token1TotalVolumeCurrentFiat = 0.0;
  var token2TotalVolumeCurrentFiat = 0.0;
  var token1TotalVolume24hFiat = 0.0;
  var token2TotalVolume24hFiat = 0.0;

  var token1TotalFeeCurrentFiat = 0.0;
  var token2TotalFeeCurrentFiat = 0.0;
  var token1TotalFee24hFiat = 0.0;
  var token2TotalFee24hFiat = 0.0;

  if (transactionChainResult[currentPoolInfos.poolAddress] != null &&
      transactionChainResult[currentPoolInfos.poolAddress]!.isNotEmpty) {
    final transaction =
        transactionChainResult[currentPoolInfos.poolAddress]!.first;
    if (transaction.validationStamp != null &&
        transaction.validationStamp!.ledgerOperations != null &&
        transaction
            .validationStamp!.ledgerOperations!.unspentOutputs.isNotEmpty) {
      for (final unspentOutput
          in transaction.validationStamp!.ledgerOperations!.unspentOutputs) {
        if (unspentOutput.state != null) {
          final state = unspentOutput.state;
          token1TotalVolume24h =
              Decimal.parse(state!['stats']['token1_total_volume'].toString())
                  .toDouble();
          token2TotalVolume24h =
              Decimal.parse(state['stats']['token2_total_volume'].toString())
                  .toDouble();
          token1TotalFee24h =
              Decimal.parse(state['stats']['token1_total_fee'].toString())
                  .toDouble();
          token2TotalFee24h =
              Decimal.parse(state['stats']['token2_total_fee'].toString())
                  .toDouble();
        }
      }
    }
  }

  final archethicOracleUCO =
      ref.read(ArchethicOracleUCOProviders.archethicOracleUCO);

  if (currentPoolInfos.pair!.token1.symbol == 'UCO') {
    priceToken1 = archethicOracleUCO.usd;
  } else {
    priceToken1 = await ref.read(
      MarketProviders.getPriceFromSymbol(currentPoolInfos.pair!.token1.symbol)
          .future,
    );
  }

  if (currentPoolInfos.pair!.token2.symbol == 'UCO') {
    priceToken2 = archethicOracleUCO.usd;
  } else {
    priceToken2 = await ref.read(
      MarketProviders.getPriceFromSymbol(currentPoolInfos.pair!.token2.symbol)
          .future,
    );
  }

  if (priceToken1 == 0 && priceToken2 > 0) {
    final ratio = await ref.read(
      DexPoolProviders.getRatio(
        currentPoolInfos.poolAddress,
        currentPoolInfos.pair!.token1,
      ).future,
    );

    priceToken1 = ratio * priceToken2;
  }

  if (priceToken2 == 0 && priceToken1 > 0) {
    final ratio = await ref.read(
      DexPoolProviders.getRatio(
        currentPoolInfos.poolAddress,
        currentPoolInfos.pair!.token2,
      ).future,
    );

    priceToken2 = ratio * priceToken1;
  }

  token1TotalVolumeCurrentFiat =
      priceToken1 * currentPoolInfos.token1TotalVolume;
  token2TotalVolumeCurrentFiat =
      priceToken2 * currentPoolInfos.token2TotalVolume;
  token1TotalVolume24hFiat = priceToken1 * token1TotalVolume24h;
  token2TotalVolume24hFiat = priceToken2 * token2TotalVolume24h;

  token1TotalFeeCurrentFiat = priceToken1 * currentPoolInfos.token1TotalFee;
  token2TotalFeeCurrentFiat = priceToken2 * currentPoolInfos.token2TotalFee;
  token1TotalFee24hFiat = priceToken1 * token1TotalFee24h;
  token2TotalFee24hFiat = priceToken2 * token2TotalFee24h;

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
