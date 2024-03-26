/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<void> _removePoolFromFavorite(
  _RemovePoolFromFavoriteRef ref,
  String poolGenesisAddress,
) async {
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  final poolHive = poolsListDatasource.getPool(poolGenesisAddress);
  var pool = poolHive!.toDexPool();

  pool = pool.copyWith(isFavorite: false);
  await poolsListDatasource.setPool(pool.toHive());

  ref.invalidate(DexPoolProviders.getPool(poolGenesisAddress));
}

@riverpod
Future<void> _addPoolFromFavorite(
  _AddPoolFromFavoriteRef ref,
  String poolGenesisAddress,
) async {
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  final poolHive = poolsListDatasource.getPool(poolGenesisAddress);
  var pool = poolHive!.toDexPool();

  pool = pool.copyWith(isFavorite: true);
  await poolsListDatasource.setPool(pool.toHive());

  ref.invalidate(DexPoolProviders.getPool(poolGenesisAddress));
}
