/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPoolCase with TransactionDexMixin {
  Future<void> run(
    WidgetRef ref,
    String token1Address,
    String token2Address,
    String routerAddress,
  ) async {
    // Generate seed's pool
    final poolSeed = archethic.generateRandomSeed();
    final stateSeed = archethic.generateRandomSeed();
    final poolGenesisAddress = archethic.deriveAddress(poolSeed, 0);
    final lpTokenAddress = archethic.deriveAddress(poolSeed, 1);
    final stateContractAddress = archethic.deriveAddress(stateSeed, 0);
    final apiService = sl.get<archethic.ApiService>();
    final routerFactory = RouterFactory(routerAddress, apiService);

    final poolInfosResult =
        await routerFactory.getPoolInfos(token1Address, token2Address);
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
    String? tokenDefinition;

    final resultsFuture = await Future.wait(
      [
        routerFactory.getPoolCode(
          token1Address,
          token2Address,
          poolGenesisAddress,
          lpTokenAddress,
          stateContractAddress,
        ),
        routerFactory.getLPTokenDefinition(token1Address, token2Address)
      ],
    );

    resultsFuture[0].map(
      success: (success) {
        poolCode = success;
      },
      failure: (failure) {
        return;
      },
    );

    resultsFuture[1].map(
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
            token1Address,
            token2Address,
            stateContractAddress,
          ],
        )
        .build(poolSeed, 0)
        .transaction
        .originSign(originPrivateKey);

    final fees = await calculateFees(transactionToken);

    final txPreviousAddress =
        '00${archethic.uint8ListToHex(archethic.hash(transactionToken.previousPublicKey))}';

    var transactionTransfer = archethic.Transaction(
      type: 'transfer',
      version: blockchainTxVersion,
      data: archethic.Transaction.initData(),
    ).addUCOTransfer(txPreviousAddress, archethic.toBigInt(fees));
    try {
      final currentNameAccount = await getCurrentAccount();
      transactionTransfer = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionTransfer],
      ))
          .first;
    } catch (e) {
      dev.log('Signature failed');
      return;
    }

    await sendTransactions(
      <archethic.Transaction>[
        transactionTransfer,
        transactionToken,
      ],
    );
  }
}
