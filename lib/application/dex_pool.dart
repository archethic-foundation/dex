/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/router_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pool.g.dart';

@riverpod
DexPoolsRepository _dexPoolsRepository(_DexPoolsRepositoryRef ref) =>
    DexPoolsRepository();

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final dexConf = await ref
      .watch(DexConfigProviders.dexConfigRepository)
      .getDexConfig('local');
  final apiService = sl.get<ApiService>();
  return ref
      .watch(_dexPoolsRepositoryProvider)
      .getPoolList(dexConf.routerGenesisAddress, apiService);
}

class DexPoolsRepository {
  Future<List<DexPool>> getPoolList(
    String routerAddress,
    ApiService apiService,
  ) async {
    final resultPoolList = await RouterFactory(
      routerAddress,
      apiService,
    ).getPoolList();
    return resultPoolList.map(
      success: (success) => success,
      failure: (failure) => [],
    );
  }
}

abstract class DexPoolProviders {
  static final getPoolList = _getPoolListProvider;
}
