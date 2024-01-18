/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:aedex/application/factory.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';

class ArchethicContract with TransactionDexMixin {
  ArchethicContract();

  Future<Result<archethic.Transaction, Failure>> getAddPoolTx(
    String routerAddress,
    String factoryAddress,
    DexToken token1,
    DexToken token2,
    String poolSeed,
    String poolGenesisAddress,
    String lpTokenAddress,
  ) async {
    return Result.guard(() async {
      final apiService = sl.get<archethic.ApiService>();
      final routerFactory = RouterFactory(routerAddress, apiService);
      final poolInfosResult = await routerFactory.getPoolAddresses(
        token1.isUCO ? 'UCO' : token1.address!,
        token2.isUCO ? 'UCO' : token2.address!,
      );
      poolInfosResult.map(
        success: (success) {
          if (success != null && success['address'] != null) {
            throw const PoolAlreadyExists();
          }
        },
        failure: (failure) {
          return;
        },
      );

      String? poolCode;
      final factory = Factory(factoryAddress, apiService);
      final resultPoolCode = await factory.getPoolCode(
        token1.isUCO ? 'UCO' : token1.address!,
        token2.isUCO ? 'UCO' : token2.address!,
        poolGenesisAddress,
        lpTokenAddress,
      );
      resultPoolCode.map(
        success: (success) {
          if (success.isEmpty) {
            throw const Failure.other(
              cause: 'Pool code from smart contract is empty',
            );
          }
          poolCode = success;
        },
        failure: (failure) {
          throw failure;
        },
      );

      String? tokenDefinition;
      final resultLPTokenDefinition = await factory.getLPTokenDefinition(
        token1.symbol,
        token2.symbol,
      );
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

      final transactionPool = archethic.Transaction(
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
          .build(poolSeed, 0)
          .transaction
          .originSign(originPrivateKey);

      return transactionPool;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getAddPoolTxTransfer(
    archethic.Transaction transactionPool,
    String poolGenesisAddress,
  ) async {
    return Result.guard(() async {
      final feesToken = await calculateFees(transactionPool);
      final apiService = sl.get<archethic.ApiService>();
      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final transactionTransfer = archethic.Transaction(
        type: 'transfer',
        version: blockchainTxVersion,
        data: archethic.Transaction.initData(),
      ).addUCOTransfer(poolGenesisAddress, archethic.toBigInt(feesToken));

      return transactionTransfer;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getAddPoolPlusLiquidityTx(
    String routerAddress,
    String transactionPoolAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    String poolGenesisAddress,
    double slippage,
  ) async {
    return Result.guard(() async {
      final apiService = sl.get<archethic.ApiService>();
      final tokensAmmountMult =
          Decimal.parse('$token1Amount') * Decimal.parse('$token2Amount');

      // TODO(reddwarf03): A quoi ça sert ici ?
      // ignore: unused_local_variable
      var expectedTokenLP = sqrt(tokensAmmountMult.toDouble());
      final expectedTokenLPResult = await PoolFactory(
        poolGenesisAddress,
        apiService,
      ).getLPTokenToMint(token1Amount, token2Amount);
      expectedTokenLPResult.map(
        success: (success) {
          if (success != null) {
            expectedTokenLP = success;
          }
        },
        failure: (failure) {},
      );

      final slippagePourcent =
          (Decimal.parse('100') - Decimal.parse('$slippage')) /
              Decimal.parse('100');
      final token1minAmount =
          Decimal.parse('$token1Amount') * slippagePourcent.toDecimal();
      final token2minAmount =
          Decimal.parse('$token2Amount') * slippagePourcent.toDecimal();

      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final transactionAdd = archethic.Transaction(
        type: 'transfer',
        version: blockchainTxVersion,
        data: archethic.Transaction.initData(),
      ).addRecipient(
        poolGenesisAddress,
        action: 'add_liquidity',
        args: [
          token1minAmount.toDouble(),
          token2minAmount.toDouble(),
        ],
      ).addRecipient(
        routerAddress,
        action: 'add_pool',
        args: [
          if (token1.isUCO) 'UCO' else token1.address!,
          if (token2.isUCO) 'UCO' else token2.address!,
          transactionPoolAddress.toUpperCase(),
        ],
      );

      if (token1.isUCO) {
        transactionAdd.addUCOTransfer(
          poolGenesisAddress,
          archethic.toBigInt(token1Amount),
        );
      } else {
        transactionAdd.addTokenTransfer(
          poolGenesisAddress,
          archethic.toBigInt(token1Amount),
          token1.address!,
        );
      }

      if (token2.isUCO) {
        transactionAdd.addUCOTransfer(
          poolGenesisAddress,
          archethic.toBigInt(token2Amount),
        );
      } else {
        transactionAdd.addTokenTransfer(
          poolGenesisAddress,
          archethic.toBigInt(token2Amount),
          token2.address!,
        );
      }
      return transactionAdd;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getAddLiquidityTx(
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    String poolGenesisAddress,
    double slippage,
  ) async {
    return Result.guard(() async {
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
          }
        },
        failure: (failure) {},
      );

      if (expectedTokenLP == 0) {
        throw const Failure.other(
          cause: "Pool doesn't have liquidity, please fill both token amount",
        );
      }

      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final slippagePourcent =
          (Decimal.parse('100') - Decimal.parse('$slippage')) /
              Decimal.parse('100');
      final token1minAmount =
          Decimal.parse('$token1Amount') * slippagePourcent.toDecimal();
      final token2minAmount =
          Decimal.parse('$token2Amount') * slippagePourcent.toDecimal();

      final transactionLiquidity = archethic.Transaction(
        type: 'transfer',
        version: blockchainTxVersion,
        data: archethic.Transaction.initData(),
      ).addRecipient(
        poolGenesisAddress,
        action: 'add_liquidity',
        args: [
          token1minAmount.toDouble(),
          token2minAmount.toDouble(),
        ],
      );

      if (token1.isUCO) {
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

      if (token2.isUCO) {
        transactionLiquidity.addUCOTransfer(
          poolGenesisAddress,
          archethic.toBigInt(token2Amount),
        );
      } else {
        transactionLiquidity.addTokenTransfer(
          poolGenesisAddress,
          archethic.toBigInt(token2Amount),
          token2.address!,
        );
      }
      return transactionLiquidity;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getRemoveLiquidityTx(
    String lpTokenAddress,
    double lpTokenAmount,
    String poolGenesisAddress,
  ) async {
    return Result.guard(() async {
      const burnAddress =
          '00000000000000000000000000000000000000000000000000000000000000000000';
      final apiService = sl.get<archethic.ApiService>();
      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final transactionLiquidity = archethic.Transaction(
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
      return transactionLiquidity;
    });
  }

  Future<Result<double, Failure>> getOutputAmount(
    DexToken tokenToSwap,
    double tokenToSwapAmount,
    String poolGenesisAddress,
  ) async {
    return Result.guard(() async {
      const logName = 'ArchethicContract.getSwapInfos';
      final apiService = sl.get<archethic.ApiService>();

      var outputAmount = 0.0;
      final getSwapInfosResult = await PoolFactory(
        poolGenesisAddress,
        apiService,
      ).getSwapInfos(tokenToSwap.address!, tokenToSwapAmount);
      getSwapInfosResult.map(
        success: (success) {
          if (success != null) {
            outputAmount = success['output_amount'];
          }
        },
        failure: (failure) {
          sl.get<LogManager>().log(
                '$failure',
                level: LogLevel.error,
                name: logName,
              );
        },
      );
      return outputAmount;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getSwapTx(
    DexToken tokenToSwap,
    double tokenToSwapAmount,
    String poolGenesisAddress,
    double slippage,
    double outputAmount,
  ) async {
    return Result.guard(() async {
      final apiService = sl.get<archethic.ApiService>();
      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final minToReceive = outputAmount * ((100 - slippage) / 100);

      final transactionSwap = archethic.Transaction(
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

      if (tokenToSwap.isUCO) {
        transactionSwap.addUCOTransfer(
          poolGenesisAddress,
          archethic.toBigInt(tokenToSwapAmount),
        );
      } else {
        transactionSwap.addTokenTransfer(
          poolGenesisAddress,
          archethic.toBigInt(tokenToSwapAmount),
          tokenToSwap.address!,
        );
      }

      return transactionSwap;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getDepositTx(
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
  ) async {
    return Result.guard(() async {
      final apiService = sl.get<archethic.ApiService>();
      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final transaction = archethic.Transaction(
        type: 'transfer',
        version: blockchainTxVersion,
        data: archethic.Transaction.initData(),
      )
          .addTokenTransfer(
        farmGenesisAddress,
        archethic.toBigInt(amount),
        lpTokenAddress,
      )
          .addRecipient(
        farmGenesisAddress,
        action: 'deposit',
        args: [],
      );

      return transaction;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getWithdrawTx(
    String farmGenesisAddress,
    double amount,
  ) async {
    return Result.guard(() async {
      final apiService = sl.get<archethic.ApiService>();
      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final transaction = archethic.Transaction(
        type: 'transfer',
        version: blockchainTxVersion,
        data: archethic.Transaction.initData(),
      ).addRecipient(
        farmGenesisAddress,
        action: 'withdraw',
        args: [amount],
      );

      return transaction;
    });
  }

  Future<Result<archethic.Transaction, Failure>> getClaimTx(
    String farmGenesisAddress,
  ) async {
    return Result.guard(() async {
      final apiService = sl.get<archethic.ApiService>();
      final blockchainTxVersion = int.parse(
        (await apiService.getBlockchainVersion()).version.transaction,
      );

      final transaction = archethic.Transaction(
        type: 'transfer',
        version: blockchainTxVersion,
        data: archethic.Transaction.initData(),
      ).addRecipient(
        farmGenesisAddress,
        action: 'claim',
        args: [],
      );

      return transaction;
    });
  }
}
