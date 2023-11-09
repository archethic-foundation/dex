/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class PoolFactory {
  PoolFactory(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Returns pool's info (tokens address, reserve, fee)
  Future<Result<DexPool, Failure>> getPoolInfos() async {
    return Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_pair_tokens',
              args: [],
            ),
          ),
          resultMap: true,
        ) as List<dynamic>;

        log('$result');

        return DexPool();
      },
    );
  }

  /// This action allow user to add liquidity to the pool. User must send tokens to the pool's genesis address.
  /// The amounts sent should be equivalent to the pool ratio. User can specify a slippage tolerence by providing the minimum amount by token that the pool can use.
  /// If there is more fund sent by the user than the needed liquidity, the excedent is returned to the user.
  /// In exchange of the liquidity, the user will receive some LP token.
  /// [token1MinAmount] is the minimum amount of token1 to add in liquidity (token1 is the first token returned by the function get_pair_tokens())
  /// [token2MinAmount] is the minimum amount of token2 to add in liquidity (token2 is the second token returned by the function get_pair_tokens())
  Future<Result<void, Failure>> addLiquidity(
    double token1MinAmount,
    double token2MinAmount,
  ) async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'add_liquidity',
              args: [
                token1MinAmount,
                token2MinAmount,
              ],
            ),
          ),
        );
      },
    );
  }

  /// This action allow user to remove the liquidity he previously provided.
  /// User must send the lp token he wants to remove to the burn address ("000...000")
  /// (don't forget to add the pool in recipient otherwise lp token will only be burned).
  /// The pool will calculate the share of the user and return the corresponding amount of both pool tokens.
  Future<Result<void, Failure>> removeLiquidity() async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'remove_liquidity',
              args: [],
            ),
          ),
        );
      },
    );
  }

  /// This action allow user to swap a token of the pool against the other token.
  /// User must send the input token to the pool's genesis address.
  /// The pool will calculate the output amount and send it to the user.
  /// User can specify a slippage tolerence by providing the minimum amount of the output token to receive.
  /// [minAmountToReceive] is the minimum amount of the output token to receive
  Future<Result<void, Failure>> swap(
    double minAmountToReceive,
  ) async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'swap',
              args: [
                minAmountToReceive,
              ],
            ),
          ),
        );
      },
    );
  }

  /// Returns the amount of LP token that will be minted if the amount of tokens are provided
  /// [token1Amount] Amount of token1 to provide (token1 is the first token returned by get_pair_tokens)
  /// [token1Amount] Amount of token2 to provide (token2 is the second token returned by get_pair_tokens)
  Future<Result<double?, Failure>> getLPTokenToMint(
    double token1Amount,
    double token2Amount,
  ) async {
    return Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_lp_token_to_mint',
              args: [
                token1Amount,
                token2Amount,
              ],
            ),
          ),
        );
        return double.tryParse(result.toString());
      },
    );
  }

  /// Returns the equivalent amount of the other token of the pool. This should be used in the process of adding liquidity
  /// [tokenAddress] is the token you want to provide (result amount will be the other token)
  /// [tokenAmount] is the amount of token_address you want to provide
  Future<Result<double?, Failure>> getEquivalentAmount(
    String tokenAddress,
    double tokenAmount,
  ) async {
    return Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_equivalent_amount',
              args: [
                tokenAddress,
                tokenAmount,
              ],
            ),
          ),
        );
        return double.tryParse(result.toString());
      },
    );
  }
}
