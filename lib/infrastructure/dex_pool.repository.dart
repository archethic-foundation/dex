import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/pool/pool_factory.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/result.dart';
import 'package:aedex/domain/repositories/dex_pool.repository.dart';
import 'package:aedex/infrastructure/hive/pools_list.hive.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexPoolRepositoryImpl implements DexPoolRepository {
  DexPoolRepositoryImpl({required this.apiService});

  final ApiService apiService;
  @override
  Future<DexPool?> getPool(Ref ref, String address) async {
    final poolsListDatasource = await HivePoolsListDatasource.getInstance();

    final poolHive = poolsListDatasource.getPool(address);
    if (poolHive == null) {
      final poolListResult = await ref.read(
        DexPoolProviders.getPoolListForSearch(address.toUpperCase()).future,
      );
      if (poolListResult.isNotEmpty) {
        final pool = poolListResult.firstWhere(
          (element) =>
              element.poolAddress.toUpperCase() == address.toUpperCase(),
        );
        return ref.read(DexPoolProviders.getPoolInfos(pool).future);
      }
    }

    return poolsListDatasource.getPool(address)?.toDexPool();
  }

  @override
  Future<DexPool> populatePoolInfos(
    DexPool poolInput,
  ) async {
    final apiService = sl.get<ApiService>();
    final poolFactory = PoolFactory(poolInput.poolAddress, apiService);

    return poolFactory.populatePoolInfos(poolInput).valueOrThrow;
  }
}
