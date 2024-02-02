/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/domain/models/util/get_farm_list_response.dart';
import 'package:aedex/domain/models/util/get_pool_list_response.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:aedex/infrastructure/hive/dex_token.hive.dart';
import 'package:aedex/infrastructure/hive/tokens_list.hive.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// Router is a helper factory for user to easily retrieve existing pools and create new pools.
class RouterFactory with ModelParser {
  RouterFactory(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Returns the info of the pool for the 2 tokens address.
  /// [token1Address] is the address of the first token
  /// [token2Address] is the address of the second token
  Future<Result<Map<String, dynamic>?, Failure>> getPoolAddresses(
    String token1Address,
    String token2Address,
  ) async {
    return Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_pool_addresses',
              args: [
                token1Address,
                token2Address,
              ],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>?;
        if (result == null) {
          sl.get<LogManager>().log(
                'getPoolAddresses: result null $token1Address $token2Address',
                level: LogLevel.error,
                name: 'getPoolAddresses',
              );
        }
        return result;
      },
    );
  }

  /// Return the infos of all the pools.
  Future<Result<List<DexPool>, Failure>> getPoolList(
    Balance? userBalance,
  ) async {
    return Result.guard(
      () async {
        final results = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_pool_list',
              args: [],
            ),
          ),
          resultMap: true,
        ) as List<dynamic>;

        final poolList = <DexPool>[];

        final tokensListDatasource =
            await HiveTokensListDatasource.getInstance();
        final tokensAddresses = <String>[];
        for (final result in results) {
          final getPoolListResponse = GetPoolListResponse.fromJson(result);
          final tokens = getPoolListResponse.tokens.split('/');
          if (tokens[0] != 'UCO') {
            if (tokensListDatasource.getToken(tokens[0]) == null) {
              tokensAddresses.add(tokens[0]);
            }
          }
          if (tokens[1] != 'UCO') {
            if (tokensListDatasource.getToken(tokens[1]) == null) {
              tokensAddresses.add(tokens[1]);
            }
          }
          if (tokensListDatasource
                  .getToken(getPoolListResponse.lpTokenAddress) ==
              null) {
            tokensAddresses.add(getPoolListResponse.lpTokenAddress);
          }
        }
        final tokenResultMap = await sl.get<ApiService>().getToken(
              tokensAddresses.toSet().toList(),
              request: 'name, symbol',
            );

        for (final entry in tokenResultMap.entries) {
          final address = entry.key.toUpperCase();
          var tokenResult = tokenSDKToModel(entry.value, 0);

          final tokenVerified =
              await VerifiedTokensRepository().isVerifiedToken(address);

          tokenResult =
              tokenResult.copyWith(address: address, isVerified: tokenVerified);
          await tokensListDatasource.setToken(tokenResult.toHive());
        }

        for (final result in results) {
          final getPoolListResponse = GetPoolListResponse.fromJson(result);
          poolList.add(
            await poolListItemToModel(
              userBalance,
              getPoolListResponse,
            ),
          );
        }

        return poolList;
      },
    );
  }

  /// Return the infos of all the farms.
  Future<Result<List<DexFarm>, Failure>> getFarmList(
    List<DexPool> poolList,
  ) async {
    return Result.guard(
      () async {
        final results = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_farm_list',
              args: [],
            ),
          ),
          resultMap: true,
        ) as List<dynamic>;

        final farmList = <DexFarm>[];

        for (final result in results) {
          final getFarmListResponse = GetFarmListResponse.fromJson(result);
          final dexpool = poolList.singleWhere(
            (pool) =>
                pool.lpToken.address!.toUpperCase() ==
                getFarmListResponse.lpTokenAddress.toUpperCase(),
          );

          farmList.add(
            await farmListToModel(getFarmListResponse, dexpool),
          );
        }

        return farmList;
      },
    );
  }

  /// This action allows users to add a new pool in the router.
  /// The transaction triggering this action should be the transaction that create the pool.
  /// The transaction should be a token transaction with the token definition returned by the function get_lp_token_definition.
  /// It should also have the code returned by the function get_pool_code.
  Future<Result<void, Failure>> addPool(
    String token1Address,
    String token2Address,
    String stateAddress,
  ) async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'add_pool',
              args: [
                token1Address,
                token2Address,
                stateAddress,
              ],
            ),
          ),
        );
      },
    );
  }

  /// This action allows the Master chain of the dex to add a new farm in the router.
  /// The transaction triggering this action should also add the first amount of reward token to the previously created farm.
  /// The transaction that created the farm should be a contract transaction with the code returned by the function get_farm_code
  /// of the Factory contract.
  Future<Result<void, Failure>> addFarm(
    String lpTokenAddress,
    int startDate,
    int endDate,
    String rewardTokenAddress,
    String farmCreationAddress,
  ) async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'add_farm',
              args: [
                lpTokenAddress,
                startDate,
                endDate,
                rewardTokenAddress,
                farmCreationAddress,
              ],
            ),
          ),
        );
      },
    );
  }
}
