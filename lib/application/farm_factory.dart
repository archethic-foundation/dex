/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// Farm is a factory allowing users to deposit lp token from a pool and to receive reward for a period of time.
class FarmFactory with ModelParser {
  FarmFactory(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Returns the informations of the farm
  Future<Result<Map<String, dynamic>?, Failure>> getFarmInfos() async {
    return Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_farm_infos',
              args: [],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>?;
        if (result == null) {
          sl.get<LogManager>().log(
                'result null',
                level: LogLevel.error,
                name: 'getFarmInfos',
              );
        }
        return result;
      },
    );
  }

  /// Returns the informations of a user who has deposited lp token in the farm
  Future<Result<({double depositedAmount, double rewardAmount}), Failure>>
      getUserInfos(
    String userGenesisAddress,
  ) async {
    return Result.guard(
      () async {
        final results = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_user_infos',
              args: [userGenesisAddress],
            ),
          ),
          resultMap: true,
        ) as List<dynamic>;
/*
        // TODO (reddwarf03): to finish
        final depositedAmount = results['deposited_amount'] as double;
        final rewardAmount = results['reward_amount'] as double;
*/
        const depositedAmount = 0.0;
        const rewardAmount = 0.0;

        return (depositedAmount: depositedAmount, rewardAmount: rewardAmount);
      },
    );
  }

  /// This action allow user to deposit lp token in the farm.
  /// User must send tokens to the farm's genesis address.
  /// It's fund will be hold by the contract and could be reclaimed using withdraw action.
  /// The user will gain reward each second based on the reward amount and it's share of the farm. The reward can be claimed using the claim actions.
  /// A user can deposit multiple time in the same farm, or in multiple farms.
  Future<Result<void, Failure>> deposit() async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'deposit',
              args: [],
            ),
          ),
        ) as List<dynamic>;
      },
    );
  }

  /// This action allow user to claim all the reward he earned since he deposited in the farm or since it's last claim.
  Future<Result<void, Failure>> claim() async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'claim',
              args: [],
            ),
          ),
        ) as List<dynamic>;
      },
    );
  }

  /// This action allow user to withdraw all or a part of it's deposited lp token. In the same time is also claim it's earned rewards.
  /// [amount] is the amount the user wants to withdraw
  Future<Result<void, Failure>> withdraw(double amount) async {
    return Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'withdraw',
              args: [amount],
            ),
          ),
        ) as List<dynamic>;
      },
    );
  }
}
