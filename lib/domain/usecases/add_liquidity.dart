/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;

import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddLiquidityCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    String routerAddress,
    double slippage,
  ) async {
    dev.log('Token1 address: ${token1.address}', name: 'AddLiquidityCase');
    dev.log('Token2 address: ${token2.address}', name: 'AddLiquidityCase');

    final apiService = sl.get<archethic.ApiService>();
    final routerFactory = RouterFactory(routerAddress, apiService);
    dev.log('Router address: $routerAddress', name: 'AddLiquidityCase');

    String? liquidityGenesisAddress;
    final liquidityInfosResult =
        await routerFactory.getPoolInfos(token1.address!, token2.address!);
    liquidityInfosResult.map(
      success: (success) {
        liquidityGenesisAddress = success.toString();
      },
      failure: (failure) {
        return;
      },
    );

    final blockchainTxVersion = int.parse(
      (await apiService.getBlockchainVersion()).version.transaction,
    );

    final token1minAmount = token1Amount * ((100 - slippage) / 100);
    final token2minAmount = token2Amount * ((100 - slippage) / 100);

    var transactionLiquidity = archethic.Transaction(
      type: 'transfer',
      version: blockchainTxVersion,
      data: archethic.Transaction.initData(),
    )
        .addRecipient(
          liquidityGenesisAddress!,
          action: 'add_liquidity',
          args: [
            token1minAmount,
            token2minAmount,
          ],
        )
        .addTokenTransfer(
          liquidityGenesisAddress!,
          archethic.toBigInt(token1minAmount),
          token1.address!,
        )
        .addTokenTransfer(
          liquidityGenesisAddress!,
          archethic.toBigInt(token2minAmount),
          token2.address!,
        );

    try {
      final currentNameAccount = await getCurrentAccount();
      transactionLiquidity = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionLiquidity],
      ))
          .first;
    } catch (e) {
      dev.log('Signature failed', name: 'AddLiquidityCase');
      throw const Failure.userRejected();
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionLiquidity,
      ],
    );
  }
}
