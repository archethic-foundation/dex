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

const logName = 'SwapCase';

class SwapCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    double slippage,
  ) async {
    dev.log('Token1 address: ${token1.address}', name: logName);

    final apiService = sl.get<archethic.ApiService>();

    var outputAmount = 0.0;
    final getSwapInfosResult = await PoolFactory(
      poolGenesisAddress,
      apiService,
    ).getSwapInfos(token1.address!, token1Amount);
    getSwapInfosResult.map(
      success: (success) {
        if (success != null) {
          outputAmount = success['output_amount'];
          dev.log('outputAmount: $outputAmount', name: logName);
        } else {
          dev.log('outputAmount: null', name: logName);
        }
      },
      failure: (failure) {
        dev.log('expectedTokenLP failure: $failure', name: logName);
      },
    );

    if (outputAmount == 0) {
      throw const Failure.other(
        cause: 'Error outputAmount',
      );
    }
    final minToReceive = outputAmount * ((100 - slippage) / 100);

    final blockchainTxVersion = int.parse(
      (await apiService.getBlockchainVersion()).version.transaction,
    );

    var transactionLiquidity = archethic.Transaction(
      type: 'transfer',
      version: blockchainTxVersion,
      data: archethic.Transaction.initData(),
    ).addRecipient(
      poolGenesisAddress,
      action: 'swap',
      args: [
        minToReceive,
      ],
    );

    if (token1.address == 'UCO') {
      transactionLiquidity.addUCOTransfer(
        poolGenesisAddress,
        archethic.toBigInt(token1Amount),
      );
    } else {
      transactionLiquidity.addTokenTransfer(
        poolGenesisAddress,
        archethic.toBigInt(token1Amount),
        token1.address!,
      );
    }

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
