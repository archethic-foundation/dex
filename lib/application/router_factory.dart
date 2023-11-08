/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/domain/models/util/get_pool_list_response.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class RouterFactory with ModelParser {
  RouterFactory(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Return the code to create a pool for a pair of tokens.
  /// [token1Address] is the first token address of the pair
  /// [token2Address] is the second token address of the pair
  /// [poolAddress] is the genesis address of the pool chain
  /// [lpTokenAddress] is the address of the lp token (it should be the creation address of the pool)
  Future<Result<String, Failure>> getPoolCode(
    String token1Address,
    String token2Address,
    String poolAddress,
    String lpTokenAddress,
  ) async {
    return Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_pool_code',
              args: [
                token1Address,
                token2Address,
                poolAddress,
                lpTokenAddress,
              ],
            ),
          ),
        );
        return result.toString();
      },
    );
  }

  /// Return a the lp token definition to use when creating a pool. Returns a JSON stringified
  /// [token1Symbol] is the symbol of the first token
  /// [token2Symbol] is the symbol of the second token
  Future<Result<String, Failure>> getLPTokenDefinition(
    String token1Symbol,
    String token2Symbol,
  ) async {
    return Result.guard(
      () async {
        final tokenDefinition = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_lp_token_definition',
              args: [
                token1Symbol,
                token2Symbol,
              ],
            ),
          ),
        );
        return tokenDefinition.toString();
      },
    );
  }

  /// Returns the info of the pool for the 2 tokens address.
  /// Pool infos is a map with address as the genesis address of the pool lp_token_address as the lp token address of the pool.
  /// ({"address": "00001234...", "lp_token_address": "00005678..."})
  /// [token1Address] is the address of the first token
  /// [token2Address] is the address of the second token
  Future<Result<Map<String, dynamic>?, Failure>> getPoolInfos(
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
              function: 'get_pool_infos',
              args: [
                token1Address,
                token2Address,
              ],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>?;

        return result;
      },
    );
  }

  /// This actions allow users to add a new pool in the router.
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

  /// Return the infos of all the pools.
  /// Pool infos is a map with address as the genesis address of the pool, lp_token_address as the lp token address of the pool,
  /// tokens as the address of both token concatenated and separated by a slash.
  /// [{"address": "00001234...", "lp_token_address": "00005678...", "tokens": "0000456.../000789..."}]
  Future<Result<List<DexPool>, Failure>> getPoolList() async {
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

        for (final result in results) {
          dev.log('$result');
          final getPoolListResponse = GetPoolListResponse.fromJson(result);
          poolList.add(
            await poolListToModel(getPoolListResponse),
          );
        }

        return poolList;
      },
    );
  }
}
