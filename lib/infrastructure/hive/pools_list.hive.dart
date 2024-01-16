/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/infrastructure/hive/dex_pool.hive.dart';
import 'package:hive/hive.dart';

class HivePoolsListDatasource {
  HivePoolsListDatasource._(this._box);

  static const String _poolsListBox = 'poolsListBox';
  final Box<DexPoolHive> _box;

  static const String aeSwapPoolsList = 'ae_swap_pool_list';

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HivePoolsListDatasource> getInstance() async {
    final box = await Hive.openBox<DexPoolHive>(_poolsListBox);
    return HivePoolsListDatasource._(box);
  }

  Future<void> setPoolsList(List<DexPoolHive> v) async {
    await _box.clear();
    for (final pool in v) {
      await _box.put(pool.poolAddress, pool);
    }
  }

  List<DexPoolHive> getPoolsList() {
    return _box.values.toList();
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
