/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/dex_config.dart';
import 'package:aedex/application/pool_factory.dart';
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_pair.g.dart';

@riverpod
DexPairsRepository _dexPairsRepository(_DexPairsRepositoryRef ref) =>
    DexPairsRepository();

@riverpod
Future<List<DexPair>> _getDexPairs(
  _GetDexPairsRef ref,
) async {
  final poolFactoryAddress = await ref
      .watch(DexConfigProviders.dexConfigRepository)
      .getDexConfig('local');
  final apiService = sl.get<ApiService>();
  return ref
      .watch(_dexPairsRepositoryProvider)
      .getDexPairs(poolFactoryAddress.routerGenesisAddress, apiService);
}

class DexPairsRepository {
  Future<List<DexPair>> getDexPairs(
    String poolFactoryAddress,
    ApiService apiService,
  ) async {
    final resultPairTokens = await PoolFactory(
      poolFactoryAddress,
      apiService,
    ).getPairTokens();
    return resultPairTokens.map(
      success: (success) => [success],
      failure: (failure) => [],
    );
  }
}

abstract class DexPairsProviders {
  static final getDexPairs = _getDexPairsProvider;
}
