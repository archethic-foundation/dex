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
    DexToken token2,
    String routerAddress,
  ) async {
    dev.log('Token1 address: ${token1.address}', name: 'AddPoolCase');
    dev.log('Token2 address: ${token2.address}', name: 'AddPoolCase');

    final poolSeed = archethic.generateRandomSeed();
    final stateSeed = archethic.generateRandomSeed();
    final poolGenesisAddress =
        archethic.deriveAddress(poolSeed, 0).toUpperCase();
    final lpTokenAddress = archethic.deriveAddress(poolSeed, 1).toUpperCase();
    final stateContractAddress =
        archethic.deriveAddress(stateSeed, 0).toUpperCase();
    final apiService = sl.get<archethic.ApiService>();
    final routerFactory = RouterFactory(routerAddress, apiService);
    dev.log('Router address: $routerAddress', name: 'AddPoolCase');

    dev.log('poolGenesisAddress : $poolGenesisAddress', name: 'AddPoolCase');
    dev.log('lpTokenAddress: $lpTokenAddress', name: 'AddPoolCase');
    dev.log('stateContractAddress: $stateContractAddress', name: 'AddPoolCase');

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
      stateContractAddress,
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
            stateContractAddress,
          ],
        )
        .build(poolSeed, 0)
        .transaction
        .originSign(originPrivateKey);

    final fees = await calculateFees(transactionToken);
    dev.log('fees: $fees', name: 'AddPoolCase');

    var transactionTransfer = archethic.Transaction(
      type: 'transfer',
      version: blockchainTxVersion,
      data: archethic.Transaction.initData(),
    ).addUCOTransfer(poolGenesisAddress, archethic.toBigInt(fees));
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
