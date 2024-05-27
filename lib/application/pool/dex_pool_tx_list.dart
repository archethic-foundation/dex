/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<List<DexPoolTx>> _getPoolTxList(
  _GetPoolTxListRef ref,
  DexPool pool,
  String lastTransactionAddress,
) async {
  final apiService = aedappfm.sl.get<ApiService>();
  final dexPoolTxList = <DexPoolTx>[];
  final transactionChainResult = await apiService.getTransactionChain(
    {pool.poolAddress: lastTransactionAddress},
    orderAsc: false,
    request:
        ' address, type, inputs { amount, from, tokenAddress, type }, validationStamp { timestamp }, data { ledger { uco {transfers { amount to } }, token { transfers { amount to tokenAddress } } } }',
  );

  final fiatValueToken1 =
      ref.read(DexTokensProviders.estimateTokenInFiat(pool.pair.token1));
  final fiatValueToken2 =
      ref.read(DexTokensProviders.estimateTokenInFiat(pool.pair.token2));

  if (transactionChainResult[pool.poolAddress] != null) {
    final transactions = transactionChainResult[pool.poolAddress];
    for (final transaction in transactions!) {
      String? addressAccount;
      var token1Amount = 0.0;
      var token2Amount = 0.0;
      Address? addressAccountGenesis;
      DexActionType? typeTx;
      var totalValue = 0.0;

      // Add Liquidity
      if (transaction.type == 'token') {
        typeTx = DexActionType.addLiquidity;
        for (final input in transaction.inputs) {
          if (input.type != null && input.type! != 'state') {
            addressAccount ??= input.from;
            if (input.type != null && input.type! == 'UCO') {
              if (pool.pair.token1.isUCO) {
                token1Amount = fromBigInt(input.amount).toDouble();
              } else {
                if (pool.pair.token2.isUCO) {
                  token2Amount = fromBigInt(input.amount).toDouble();
                }
              }
            } else {
              if (pool.pair.token1.address != null &&
                  input.tokenAddress != null &&
                  pool.pair.token1.address!.toUpperCase() ==
                      input.tokenAddress!.toUpperCase()) {
                token1Amount = fromBigInt(input.amount).toDouble();
              } else {
                if (pool.pair.token2.address != null &&
                    input.tokenAddress != null &&
                    pool.pair.token2.address!.toUpperCase() ==
                        input.tokenAddress!.toUpperCase()) {
                  token2Amount = fromBigInt(input.amount).toDouble();
                }
              }
            }
          }
        }
      } else {
        // Remove liquidity
        if (transaction.type == 'transfer' &&
            (transaction.data!.ledger!.token!.transfers.length +
                    transaction.data!.ledger!.uco!.transfers.length) ==
                2) {
          typeTx = DexActionType.removeLiquidity;
          for (final tokenTransfer
              in transaction.data!.ledger!.token!.transfers) {
            addressAccount ??= tokenTransfer.to;
            if (tokenTransfer.tokenAddress != null &&
                tokenTransfer.tokenAddress!.toUpperCase() ==
                    pool.pair.token1.address) {
              token1Amount = fromBigInt(tokenTransfer.amount).toDouble();
            } else {
              if (tokenTransfer.tokenAddress != null &&
                  tokenTransfer.tokenAddress!.toUpperCase() ==
                      pool.pair.token2.address) {
                token2Amount = fromBigInt(tokenTransfer.amount).toDouble();
              }
            }
          }
          for (final ucoTransfer in transaction.data!.ledger!.uco!.transfers) {
            addressAccount ??= ucoTransfer.to;
            if (pool.pair.token1.isUCO) {
              token1Amount = fromBigInt(ucoTransfer.amount).toDouble();
            } else {
              if (pool.pair.token2.isUCO) {
                token2Amount = fromBigInt(ucoTransfer.amount).toDouble();
              }
            }
          }
        } else {
          // Swap
          for (final tokenTransfer
              in transaction.data!.ledger!.token!.transfers) {
            typeTx = DexActionType.swap;
            addressAccount ??= tokenTransfer.to;
            if (tokenTransfer.tokenAddress != null &&
                tokenTransfer.tokenAddress!.toUpperCase() ==
                    pool.pair.token1.address) {
              token1Amount = fromBigInt(tokenTransfer.amount).toDouble();
            } else {
              if (tokenTransfer.tokenAddress != null &&
                  tokenTransfer.tokenAddress!.toUpperCase() ==
                      pool.pair.token2.address) {
                token2Amount = fromBigInt(tokenTransfer.amount).toDouble();
              }
            }
          }
          for (final ucoTransfer in transaction.data!.ledger!.uco!.transfers) {
            addressAccount ??= ucoTransfer.to;
            if (pool.pair.token1.isUCO) {
              token1Amount = fromBigInt(ucoTransfer.amount).toDouble();
            } else {
              if (pool.pair.token2.isUCO) {
                token2Amount = fromBigInt(ucoTransfer.amount).toDouble();
              }
            }
          }
        }
      }

      if (addressAccount != null) {
        addressAccountGenesis =
            await apiService.getGenesisAddress(addressAccount);
      }

      totalValue = ((Decimal.parse(fiatValueToken1.toString()) *
                  Decimal.parse(token1Amount.toString())) +
              (Decimal.parse(fiatValueToken2.toString()) *
                  Decimal.parse(token2Amount.toString())))
          .toDouble();

      final dexPoolTx = DexPoolTx(
        addressTx: transaction.address!.address,
        typeTx: typeTx,
        time: DateTime.fromMillisecondsSinceEpoch(
          transaction.validationStamp!.timestamp! * 1000,
        ),
        addressAccount: addressAccountGenesis?.address,
        token1Amount: token1Amount,
        token2Amount: token2Amount,
        pair: pool.pair,
        totalValue: totalValue,
      );

      dexPoolTxList.add(dexPoolTx);
    }
  }

  return dexPoolTxList;
}
