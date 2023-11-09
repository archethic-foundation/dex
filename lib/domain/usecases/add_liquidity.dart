/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;

import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'AddLiquidityCase';

class AddLiquidityCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    double slippage,
  ) async {
    dev.log('Token1 address: ${token1.address}', name: logName);
    dev.log('Token2 address: ${token2.address}', name: logName);

    final apiService = sl.get<archethic.ApiService>();

    var expectedTokenLP = 0.0;
    final expectedTokenLPResult = await PoolFactory(
      poolGenesisAddress,
      apiService,
    ).getLPTokenToMint(token1Amount, token2Amount);
    expectedTokenLPResult.map(
      success: (success) {
        if (success != null) {
          expectedTokenLP = success;
          dev.log('expectedTokenLP: $expectedTokenLP', name: logName);
        } else {
          dev.log('expectedTokenLP: null', name: logName);
        }
      },
      failure: (failure) {
        dev.log('expectedTokenLP failure: $failure', name: logName);
      },
    );

    if (expectedTokenLP == 0) {
      throw const Failure.other(
        cause: "Pool doesn't have liquidity, please fill both token amount",
      );
    }

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
          poolGenesisAddress,
          action: 'add_liquidity',
          args: [
            token1minAmount,
            token2minAmount,
          ],
        )
        .addTokenTransfer(
          poolGenesisAddress,
          archethic.toBigInt(token1minAmount),
          token1.address!,
        )
        .addTokenTransfer(
          poolGenesisAddress,
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
      dev.log('Signature failed', name: logName);
      throw const Failure.userRejected();
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionLiquidity,
      ],
    );
  }
}
