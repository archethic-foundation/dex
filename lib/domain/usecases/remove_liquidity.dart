/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_riverpod/flutter_riverpod.dart';

const logName = 'RemoveLiquidityCase';
const burnAddress =
    '00000000000000000000000000000000000000000000000000000000000000000000';

class RemoveLiquidityCase with TransactionDexMixin {
  Future<void> run(
    String poolGenesisAddress,
    WidgetRef ref,
    String lpTokenAddress,
    double lpTokenAmount,
  ) async {
    dev.log('LP Token address: $lpTokenAddress', name: logName);

    final apiService = sl.get<archethic.ApiService>();
    final blockchainTxVersion = int.parse(
      (await apiService.getBlockchainVersion()).version.transaction,
    );

    var transactionLiquidity = archethic.Transaction(
      type: 'transfer',
      version: blockchainTxVersion,
      data: archethic.Transaction.initData(),
    ).addRecipient(
      poolGenesisAddress,
      action: 'remove_liquidity',
      args: [],
    ).addTokenTransfer(
      burnAddress,
      archethic.toBigInt(lpTokenAmount),
      lpTokenAddress,
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
