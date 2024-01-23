/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class Factory with ModelParser {
  Factory(this.factoryAddress, this.apiService);

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

  /// Return the code to create a farm for a LP token and a reward token.
  /// [lpTokenAddress] is the lp token to provide in the farm
  /// [startDate] is the timestamp (in sec) where the farm starts to give reward (should be between 2 hours and 1 week from farm creation date)
  /// [endDate] is the timestamp (in sec) where the farm ends to give reward (should be between 1 month and 1 year from start date)
  /// [rewardTokenAddress] is the reward token address or "UCO"
  /// [farmGenesisAddress] is the genesis address of the farm contract chain
  Future<Result<String, Failure>> getFarmCode(
    String lpTokenAddress,
    int startDate,
    int endDate,
    String rewardTokenAddress,
    String farmGenesisAddress,
  ) async {
    return Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_farm_code',
              args: [
                lpTokenAddress,
                startDate,
                endDate,
                rewardTokenAddress,
                farmGenesisAddress,
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
}
