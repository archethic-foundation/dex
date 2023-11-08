/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPoolCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    String routerAddress,
    double slippage,
  ) async {
    dev.log('Token1 address: ${token1.address}', name: 'AddPoolCase');
    dev.log('Token2 address: ${token2.address}', name: 'AddPoolCase');

    final poolSeed = archethic.generateRandomSeed();
    final poolGenesisAddress =
        archethic.deriveAddress(poolSeed, 0).toUpperCase();
    final lpTokenAddress = archethic.deriveAddress(poolSeed, 1).toUpperCase();
    final apiService = sl.get<archethic.ApiService>();
    final routerFactory = RouterFactory(routerAddress, apiService);
    dev.log('Router address: $routerAddress', name: 'AddPoolCase');

    dev.log('poolGenesisAddress : $poolGenesisAddress', name: 'AddPoolCase');
    dev.log('lpTokenAddress: $lpTokenAddress', name: 'AddPoolCase');

    final poolInfosResult =
        await routerFactory.getPoolInfos(token1.address!, token2.address!);
    poolInfosResult.map(
      success: (success) {
        if (success == null) {
          throw const Failure.other(
            cause: 'Pool already exists for these tokens',
          );
        }
      },
      failure: (failure) {
        return;
      },
    );

    String? poolCode;
    final resultPoolCode = await routerFactory.getPoolCode(
      token1.address!,
      token2.address!,
      poolGenesisAddress,
      lpTokenAddress,
    );
    resultPoolCode.map(
      success: (success) {
        if (success.isEmpty) {
          throw const Failure.other(cause: 'pb poolCode');
        }
        poolCode = success;
      },
      failure: (failure) {
        throw const Failure.other(cause: 'pb poolCode');
      },
    );

    String? tokenDefinition;
    final resultLPTokenDefinition =
        await routerFactory.getLPTokenDefinition(token1.symbol, token2.symbol);
    resultLPTokenDefinition.map(
      success: (success) {
        tokenDefinition = success;
      },
      failure: (failure) {
        return;
      },
    );

    final storageNoncePublicKey = await apiService.getStorageNoncePublicKey();
    final aesKey = archethic.uint8ListToHex(
      Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
      ),
    );
    final authorizedKey = archethic.AuthorizedKey(
      encryptedSecretKey: archethic
          .uint8ListToHex(archethic.ecEncrypt(aesKey, storageNoncePublicKey)),
      publicKey: storageNoncePublicKey,
    );

    final blockchainTxVersion = int.parse(
      (await apiService.getBlockchainVersion()).version.transaction,
    );
    final originPrivateKey = apiService.getOriginKey();

    final transactionToken = archethic.Transaction(
      type: 'token',
      version: blockchainTxVersion,
      data: archethic.Transaction.initData(),
    )
        .setContent(tokenDefinition!)
        .setCode(poolCode!)
        .addOwnership(
          archethic.uint8ListToHex(
            archethic.aesEncrypt(poolSeed, aesKey),
          ),
          [authorizedKey],
        )
        .addRecipient(
          routerAddress,
          action: 'add_pool',
          args: [
            token1.address!,
            token2.address!,
          ],
        )
        .build(poolSeed, 0)
        .transaction
        .originSign(originPrivateKey);

    dev.log(
      'transactionToken address ${transactionToken.address!.address}',
      name: 'AddPoolCase',
    );

    final feesToken = await calculateFees(transactionToken);
    dev.log('feesToken: $feesToken', name: 'AddPoolCase');

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

    var transactionTransfer = archethic.Transaction(
      type: 'transfer',
      version: blockchainTxVersion,
      data: archethic.Transaction.initData(),
    ).addUCOTransfer(poolGenesisAddress, archethic.toBigInt(feesToken));

    try {
      final currentNameAccount = await getCurrentAccount();
      transactionTransfer = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionTransfer],
      ))
          .first;
    } catch (e) {
      dev.log('Signature failed', name: 'AddPoolCase');
      throw const Failure.userRejected();
    }

    // TODO(reddwarf03): Only one signature
    try {
      final currentNameAccount = await getCurrentAccount();
      transactionLiquidity = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionLiquidity],
      ))
          .first;
    } catch (e) {
      dev.log('Signature failed', name: 'AddPoolCase');
      throw const Failure.userRejected();
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionTransfer,
        transactionToken,
        transactionLiquidity,
      ],
    );
  }
}
