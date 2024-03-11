/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/util/get_farm_infos_response.dart';
import 'package:aedex/domain/models/util/get_user_infos_response.dart';
import 'package:aedex/domain/models/util/model_parser.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// Farm is a factory allowing users to deposit lp token from a pool and to receive reward for a period of time.
class FarmFactory with ModelParser {
  FarmFactory(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Returns the informations of the farm
  Future<Map<String, dynamic>> getFarmInfos(
    DexPool pool, {
    DexFarm? dexFarmInput,
  }) async {
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
    ) as Map<String, dynamic>;

    return result;
  }

  Future<aedappfm.Result<DexFarm, aedappfm.Failure>> populateFarmInfos(
    DexPool pool,
    DexFarm farmInput,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await getFarmInfos(pool, dexFarmInput: farmInput);

        final getFarmInfosResponse = GetFarmInfosResponse.fromJson(result);
        return farmInfosToModel(
          factoryAddress,
          getFarmInfosResponse,
          pool,
          dexFarmInput: farmInput,
        );
      },
    );
  }

  /// Returns the informations of a user who has deposited lp token in the farm
  Future<aedappfm.Result<DexFarmUserInfos, aedappfm.Failure>> getUserInfos(
    String userGenesisAddress,
  ) async {
    return aedappfm.Result.guard(
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
        ) as Map<String, dynamic>?;

        final getUserInfosResponse = GetUserInfosResponse.fromJson(results!);
        return DexFarmUserInfos(
          depositedAmount: getUserInfosResponse.depositedAmount,
          rewardAmount: getUserInfosResponse.rewardAmount,
        );
      },
    );
  }

  /// This action allow user to claim all the reward he earned since he deposited in the farm or since it's last claim.
  Future<aedappfm.Result<void, aedappfm.Failure>> claim() async {
    return aedappfm.Result.guard(
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
  Future<aedappfm.Result<void, aedappfm.Failure>> withdraw(
    double amount,
  ) async {
    return aedappfm.Result.guard(
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
